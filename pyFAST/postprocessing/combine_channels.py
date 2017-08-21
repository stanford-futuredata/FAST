import sys
import argparse
import os
from multiprocessing import Pool
from extsort import *

def str2bool(v):
  return v.lower() in ("yes", "true", "t", "1")

''' Helper function that defines the sorting order '''
def _get_sort_key(line):
    nums = line.split()
    return (int(nums[0]), int(nums[1]))

''' Helper function to get names of all intermediate (sorted) files '''
def _get_sorted_fname(fname):
    return fname + "_sorted"

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

def _parse_line(line):
    idx = line.rfind(' ')
    return line[:idx], int(line[idx+1:])

''' Sort each input file '''
def sort(fname):
    sorter = ExternalSort(parse_memory(args.mem) / len(args.filenames))
    print "Sorting %s" %fname
    sorter.sort(fname, lambda line: _get_sort_key(line))

''' Merge all sorted file '''
def merge():
    print "Merging files"
    merger = FileMerger(MergeByKey())
    buffer_size = parse_memory(args.mem) / (len(args.filenames) + 1)
    if args.sort:
        sorted_filenames = map(_get_sorted_fname, args.filenames)
        merger.merge(sorted_filenames, 'merged.txt', buffer_size)
        map(lambda f: os.remove(f), sorted_filenames)
    else:
        merger.merge(args.filenames, 'merged.txt', buffer_size)

''' Add up similarity and filter out those below threshold '''
def filter_and_reduce():
    print "Filtering by threshold, outputing results to %s" % args.outfile
    f_out = open(args.outfile, 'w')
    with open('merged.txt', 'r') as f:
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
    os.remove("merged.txt")


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-m',
                        '--mem',
                        help='amount of memory to use for sorting',
                        default='300M')
    parser.add_argument('-t',
                        '--thresh',
                        type=int,
                        nargs='?',
                        help='threshold for total similarity over all components')
    parser.add_argument('filenames',
                        metavar='<filename1 filename2...>',
                        nargs='+',
                        help='name of file to combine')
    parser.add_argument("--sort", type=str2bool, nargs='?',
                        default=True, help="Whether to sort input files")
    parser.add_argument('-o',
                        '--outfile',
                        help='output filename',
                        default='combined.txt')
    args = parser.parse_args()
    pool = Pool(len(args.filenames))

    if args.sort:
        pool.map(sort, args.filenames)
    merge()
    filter_and_reduce()

