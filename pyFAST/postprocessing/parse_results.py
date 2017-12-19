import numpy as np
import sys
from operator import itemgetter
import os
from os.path import isfile, join
import multiprocessing
import argparse
import subprocess
from subprocess import Popen, PIPE
import time
import struct

MB_TO_BYTES = 1024 * 1024

def str2bool(v):
  return v.lower() in ("yes", "true", "t", "1")

def get_dirname(d):
    if d[-1] == '/':
        return d
    return d + '/'

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

def _get_combined_fname(i):
    return 'merged_%02d' % i

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

def get_positions(fname):
    print "Getting positions %s" % fname
    start = time.time()
    # File size in bytes
    file_size = os.path.getsize(fname)
    with open(fname, 'r') as f:
        pos_list = [] # list of positions of idx values, in bytes
        pointer = 4 # 5th byte, second uint32, first count
        while pointer < file_size:
            pos_list.append(pointer - 4) # count position minus 1 byte gives position of idx
            f.seek(pointer)
            count = struct.unpack('I', f.read(4))[0] # read uint32 at current position
            pointer += (count + 2) * 4 # jump to the next count
    final_list = []
    first_pos = pos_list[0]
    prev_pos = pos_list[0]
    for pos in pos_list:
        if pos - first_pos > partition_memory:
            final_list.append((fname, first_pos, prev_pos))
            first_pos = pos
        prev_pos = pos
    final_list.append((fname, first_pos, prev_pos))
    print "Time to get positions:", time.time() - start
    return final_list

def parse_chunk(tup):
    filename = tup[0]
    first_pos = tup[1]
    last_pos = tup[2]
    print "Parsing %s at (%d,%d)" % (filename, first_pos, last_pos)
    start = time.time()
    pairs_file_name = _get_pairs_fname("%s_(%d,%d)" % (filename, first_pos, last_pos))
    pairs_file = open(pairs_file_name, 'w')
    with open(filename, 'r') as f:
        f.seek(last_pos + 4) # seek the position of the last count
        last_count = struct.unpack('I', f.read(4))[0]
        read_size = last_pos + (last_count + 2) * 4 - first_pos # size of chunk to read in bytes
        f.seek(first_pos)
        buf = f.read(read_size)
        a = np.frombuffer(buf, dtype=np.uint32)
        i = 0
        lines = []
        while i < len(a):
            idx = a[i]
            i += 1
            counts = a[i]
            i += 1
            if args.idx:
                global_idx = idx_map[idx]
            for j in range(counts / 2):
                # Only add things that are above specified thresholds
                sim = a[i + j * 2 + 1]
                idx2 = a[i + j * 2]
                if args.thresh is None or sim >= args.thresh:
                    # Map station fingerprint index to global index
                    if args.idx:
                        lines.append('%d %d %d\n' %(
                            abs(idx_map[idx2] - global_idx), max(idx_map[idx2], global_idx), sim))
                    # Use station index
                    else:
                        lines.append('%d %d %d\n' %(abs(idx2 - idx), max(idx2, idx), sim))
            i += counts
    pairs_file.writelines(lines)
    pairs_file.close()
    print "Time to parse %s at (%d,%d):" % (filename, first_pos, last_pos), time.time() - start
    return pairs_file_name

def sort(fname):
    print "Sorting %s" % fname
    start = time.time()
    subprocess.call(['sort', '-k1,1n', '-k2,2n', '-o', fname + '_sorted', fname])
    print "Done sorting %s, time taken:" % fname, time.time() - start
    os.remove(fname)

def merge_chunk(chunk_filenames):
    print "Merging chunk"
    merged_fname = '%s_merged.txt' % (chunk_filenames[0])
    subprocess.call(
        ['sort', '-m'] + chunk_filenames + \
        ['-T', get_dirname(args.dir), '-k1,1n', '-k2,2n', '-o', merged_fname])
    if args.sort:
        map(lambda f: os.remove(f), chunk_filenames)
    return merged_fname

def merge(sorted_filenames):
    print "Merging files"
    start = time.time()
    # Too many input files
    l = len(sorted_filenames)
    if len(sorted_filenames) > args.nprocs:
        n = l / args.nprocs
        merged_fnames = p.map(merge_chunk,
            [sorted_filenames[i:i + n] for i in range(0, l, n)])
        subprocess.call(
            ['sort', '-m'] + merged_fnames + \
            ['-T', get_dirname(args.dir), '-k1,1n', '-k2,2n', 
            '-o', '%s%s_merged.txt' % (get_dirname(args.dir), args.prefix)])
        map(lambda f: os.remove(f), merged_fnames)
    else:
        subprocess.call(
            ['sort', '-m'] + sorted_filenames + \
            ['-T', get_dirname(args.dir), '-k1,1n', '-k2,2n', 
            '-o', '%s%s_merged.txt' % (get_dirname(args.dir), args.prefix)])
        if args.sort:
            map(lambda f: os.remove(f), sorted_filenames)
    print "Done merging, time taken:", time.time() - start

def filter_and_reduce_file(idx):
    fname = _get_combined_fname(idx)
    f_out = open('%s%s_reduced' % (get_dirname(args.dir), fname), 'w')
    with open('%s%s' % (get_dirname(args.dir), fname), 'r') as f:
        buf = []
        line = f.readline()
        reduce_key, reduce_val = _parse_line(line)
        # Check the end of previous partition
        if idx > 0:
            cmd = 'tail -n 1 %s' % (_get_combined_fname(idx - 1))
            proc = Popen(cmd.split(), stdout=PIPE, stderr=PIPE)
            output, err = proc.communicate()
            if reduce_key in output:
                while reduce_key in line:
                    line = f.next()
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
    # Check the start of next partition
    if idx < args.nprocs - 1:
        f_next = open('%s%s' % (get_dirname(args.dir), _get_combined_fname(idx + 1)), 'r')
        line = f_next.next()
        while reduce_key in line:
            key, val = _parse_line(line)
            reduce_val += val
            line = f_next.next()
        f_next.close()
   # Add last element
    if buf[-1][0] != reduce_key:
        buf.append([reduce_key, reduce_val])
    # Flush remaining buffer
    if len(buf) > 0:
        _output_buffer(buf, f_out)
    f_out.close()

''' Add up similarity and filter out those below threshold '''
def filter_and_reduce(p):
    print "Filtering by threshold, outputing results to %s%s_combined.txt" \
        % (get_dirname(args.dir), args.prefix)
    start = time.time()
    # Split into smaller files
    subprocess.call(
        ('split -d --number=l/%d %s%s_merged.txt %smerged_' % (
            args.nprocs, get_dirname(args.dir), args.prefix, get_dirname(args.dir))).split())
    # Filter and reduce
    p.map(filter_and_reduce_file, range(args.nprocs))
    # (Optional) Concatenate back
    # Remove intermediate files
    final_fname = '%s%s_combined.txt' % (get_dirname(args.dir), args.prefix)
    for i in range(args.nprocs):
        fname = '%s%s_reduced' % (get_dirname(args.dir), _get_combined_fname(i))
        os.system("cat %s >> %s" % (fname, final_fname))
        os.remove(fname)
        os.remove('%s%s' % (get_dirname(args.dir), _get_combined_fname(i)))
    os.remove('%s%s_merged.txt' % (get_dirname(args.dir), args.prefix))
    print "Done filtering, time taken:", time.time() - start

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
                        type=int,
                        nargs='?',
                        help='threshold of similarity')
    parser.add_argument('-i',
                        '--idx',
                        nargs='?',
                        help='global idx file')
    parser.add_argument('-m',
                        '--mem',
                        help='amount of memory to use for parsing',
                        default='20G')
    parser.add_argument("--parse", type=str2bool, nargs='?',
                        default=True, help="Whether to parse input files (default to true)")
    parser.add_argument("--sort", type=str2bool, nargs='?',
                        default=True, help="Whether to sort input files (default to true)")
    parser.add_argument('-c',
                        '--combine',
                        type=str2bool,
                        default=False,
                        help='whether to combine similarity for the same pair')
    parser.add_argument('-n',
                       '--nprocs',
                       type=int,
                       default=multiprocessing.cpu_count() / 2,
                       help='number of processes')
    args = parser.parse_args()

    grand_start_time = time.time()

    # Get global index map
    idx_map = {}
    if args.idx:
        idx_map = get_global_index_map(args.idx)

    # Get input files
    fnames = []
    for f in os.listdir(args.dir):
        if args.prefix in f and isfile(join(args.dir, f)):
            fnames.append(join(args.dir, f))

    partition_memory = parse_memory(args.mem) / args.nprocs
    p = multiprocessing.Pool(args.nprocs)
    out_fnames = fnames
    # Parse
    if args.parse:
        file_chunks = p.map(get_positions, fnames) # list of lists, where each list is a list of tuples of the form (fname, first_pos, last_pos)
        file_chunks = [chunk for chunk_list in file_chunks for chunk in chunk_list] # flatten the list
        # Parse each binary output partition
        out_fnames = p.map(parse_chunk, file_chunks)
    # Sort each partition
    if args.sort:
        p.map(sort, out_fnames)
        out_fnames = map(_get_sorted_fname, out_fnames)
    # Merge sorted partitinos
    merge(out_fnames)
    # Combine results from multiple channels
    if args.combine:
        filter_and_reduce(p)

    print "Total time taken:", time.time() - grand_start_time
