import cPickle as pickle
import time
import numpy as np
import multiprocessing
from operator import itemgetter

data_folder = './9days_sorted/'
save_str = './results/network_detection'

#channel_vars = ['GVZ_HHZ', 'KHZ_HHZ', 'LTZ_HHZ']
#detdata_filenames = ['9days_NZ_GVZ_HHZ.txt', '9days_NZ_KHZ_HHZ.txt', '9days_NZ_LTZ_HHZ.txt']

channel_vars = ['KHZ', 'GVZ', 'LTZ', 'MQZ', 'OXZ', 'THZ']
detdata_filenames = ['KHZ_sorted_total.txt', 'GVZ_sorted_total.txt', 'LTZ_sorted_total.txt', 
    'MQZ_sorted_total.txt', 'OXZ_sorted_total.txt', 'THZ_sorted_total.txt']

# channel_vars = ['MQZ_HHZ', 'KHZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
# detdata_filenames = ['MQZ-HHZ-10,11-104_pairs.txt', 'KHZ-HHZ-10,11-104_pairs.txt', 'OXZ-HHZ-10,11-104_pairs.txt', 'THZ-HHZ-10,11-104_pairs.txt']

num_cores = min(multiprocessing.cpu_count(), 8)

grand_start_time = time.time()

def partition(fname, partition_size):
    SIZE_HINT = 128 * 1024 * 1024
    f = open(fname, 'r')
    prev_dt = None
    write_buf = []
    f_count = 0
    while True:
        read_buf = f.readlines(SIZE_HINT)
        if not read_buf:
            break
        for line in read_buf:
            tmp = line.strip().split()
            dt = int(tmp[0])
            idx1 = int(tmp[1])
            ivals = int(tmp[2])

            if not prev_dt:
                prev_dt = dt
            elif (dt - prev_dt > 5 and len(write_buf) >= partition_size) or (len(write_buf) >= partition_size * 2):
                f_out = open('%s_%d' % (fname, f_count), 'w')
                f_out.writelines(write_buf)
                f_out.close()
                f_count += 1
                write_buf = []
                prev_dt = dt
            write_buf.append(line)
    f.close()
    if len(write_buf) > 0:
        f_out = open('%s_%d' % (fname, f_count), 'w')
        f_out.writelines(write_buf)
        f_out.close()

for cidx in xrange(len(channel_vars)):

    print detdata_filenames[cidx]
    print '  Building chunks and pickling...'

    # loads data, converts to (int_idx1, int_dt2 > 0, int_value) format (mapper)
    t0 = time.time()
    load_file = data_folder + detdata_filenames[cidx]

    partition_start = time.time()
    partition(load_file, 2000000) # index_ranges are indices of indices!
    print '    partition time:', time.time() - partition_start
    print '  Total time for %s:' % detdata_filenames[cidx], time.time() - t0

print 'GRAND TOTAL CHUNKING AND PICKLING TIME:', time.time() - grand_start_time
