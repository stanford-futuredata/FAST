import numpy as np
import sys
from operator import itemgetter
import os
from os.path import isfile, join
import multiprocessing
import argparse
import subprocess

MB_TO_BYTES = 1024 * 1024

def str2bool(v):
  return v.lower() in ("yes", "true", "t", "1")

''' Helper function that defines the sorting order '''
def _get_sort_key(line):
    nums = line.split()
    return (int(nums[0]), int(nums[1]))

''' Helper function to get names of all intermediate (sorted) files '''
def _get_sorted_fname(fname):
    return fname + "_sorted"

''' Helper function to get names of all intermediate (sorted) files '''
def _get_pairs_fname(fname):
    return fname + "_pairs"

def get_global_index_map(idx_fname):
    f = open(idx_fname, 'r')
    idx_map = {}
    for i, line in enumerate(f.readlines()):
        idx_map[i] = int(line.strip())
    f.close()
    return idx_map

def parse_memory(string):
    if string[-1].lower() == 'k':
        return int(string[:-1]) * 1024
    elif string[-1].lower() == 'm':
        return int(string[:-1]) * 1024 * 1024
    elif string[-1].lower() == 'g':
        return int(string[:-1]) * 1024 * 1024 * 1024
    else:
        return int(string)

def _parse_line(line):
    idx = line.rfind(' ')
    return line[:idx], int(line[idx+1:])

def _output_buffer(buf, f_out):
    lines = []
    if args.thresh:
        for elem in buf:
            if elem[1] >= args.thresh:
                lines.append("%s %d\n" % (elem[0], elem[1]))
    else:
        for elem in buf:
            lines.append("%s %d\n" % (elem[0], elem[1]))
    f_out.writelines(lines)

def parse_partition(fname):
    print "Parsing %s" % fname
    # File size in bytes
    file_size = os.path.getsize(fname)
    offset = 0
    global_idx = None
    f = open(fname, 'r')
    pairs_file = open(_get_pairs_fname(fname), 'w')

    # Read binary file in chunks
    while offset < file_size:
        read_size = min(partition_memory, file_size - offset)
        buf = f.read(read_size)
        delta_offset = 0
        a = np.frombuffer(buf, dtype=np.uint32)
        i = 0
        lines = []
        while (i < len(a)):
            idx = a[i]
            i += 1
            counts = a[i]
            i += 1
            if args.idx:
                global_idx = idx_map[idx]
            # Read extra bytes
            if i + counts > len(a):
                read_size = (i + counts - len(a)) * 4
                buf = f.read(read_size)
                delta_offset += read_size
                a = np.concatenate([a, np.frombuffer(buf, dtype=np.uint32)])
            for j in range(counts / 2):
                # Only add things that are above specified thresholds
                if args.thresh is None or a[i + j * 2 + 1] >= args.thresh:
                    # Map station fingerprint index to global index
                    if args.idx:
                        lines.append('%d %d %d\n' %(
                            idx_map[a[i + j * 2]] - global_idx, idx_map[a[i + j * 2]], a[i + j * 2 + 1]))
                    # Use station index
                    else:
                        lines.append('%d %d %d\n' %(a[i + j * 2] - idx, a[i + j * 2], a[i + j * 2 + 1]))
            i += counts

        pairs_file.writelines(lines)
        delta_offset += min(partition_memory, file_size - offset)
        offset += delta_offset

    pairs_file.close()
    f.close()

def sort(fname):
    print "Sorting %s" % fname
    subprocess.call(['sort', '-k1,1n', '-k2,2n', '-o', fname + '_sorted', fname])
    print "Done sorting %s" % fname
    os.remove(fname)

def merge(sorted_filenames):
    print "Merging files"
    subprocess.call(['sort', '-m'] + sorted_filenames + ['-k1,1n', '-k2,2n', '-o', '%s_merged.txt' % args.prefix])
    map(lambda f: os.remove(f), sorted_filenames)

''' Add up similarity and filter out those below threshold '''
def filter_and_reduce():
    print "Filtering by threshold, outputing results to %s_combined.txt" % args.prefix
    f_out = open('%s_combined.txt' % args.prefix, 'w')
    with open('%s_merged.txt' % args.prefix, 'r') as f:
        buf = []
        line = f.readline()
        reduce_key, reduce_val = _parse_line(line)
        for line in f:
            key, val = _parse_line(line)
            if key == reduce_key:
                reduce_val += val
            else:
                buf.append([reduce_key, reduce_val])
                # Output in chunks
                if len(buf) >= 10000:
                    _output_buffer(buf, f_out)
                    buf = []
                reduce_key = key
                reduce_val = val
    # Add last element
    if buf[-1][0] != reduce_key:
        buf.append([reduce_key, reduce_val])
    # Flush remaining buffer
    if len(buf) > 0:
        _output_buffer(buf, f_out)
    f_out.close()
    # Remove intermediate file
    os.remove('%s_merged.txt' % args.prefix)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-d',
                        '--dir',
                        help='directory of binary output files',
                        default='./')
    parser.add_argument('-p',
                        '--prefix',
                        help='prefix for all binary output files')
    parser.add_argument('-t',
                        '--thresh',
                        nargs='?',
                        help='threshold of similarity')
    parser.add_argument('-i',
                        '--idx',
                        nargs='?',
                        help='global idx file')
    parser.add_argument('-m',
                        '--mem',
                        help='amount of memory to use for parsing',
                        default='300M')
    parser.add_argument('-c',
                        '--combine',
                        action='store_true',
                        help='whether to filter and reduce')
    args = parser.parse_args()

    idx_map = {}
    if args.idx:
        idx_map = get_global_index_map(args.idx)

    fnames = []
    for f in os.listdir(args.dir):
        if args.prefix in f and isfile(join(args.dir, f)) and not '_pairs' in f:
            fnames.append(join(args.dir, f))

    partition_memory = parse_memory(args.mem) / len(fnames)
    p = multiprocessing.Pool(len(fnames))
    # Parse each binary output partition
    p.map(parse_partition, fnames)
    # Sort each partition
    pairs_fnames = map(_get_pairs_fname, fnames)
    p.map(sort, pairs_fnames)
    # Merge sorted partitinos
    sorted_filenames = map(_get_sorted_fname, pairs_fnames)
    merge(sorted_filenames)
    if args.combine:
        filter_and_reduce()


