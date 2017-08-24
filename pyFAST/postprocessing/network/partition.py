import time
import numpy as np
import multiprocessing

PARTITION_SIZE = 100000000     # Size of partition in lines (this is around 2 GB per partition)
SIZE_HINT = 128 * 1024 * 1024  # Size of file read buffer in bytes
PARTITION_GAP = 5              # Minimum dt gap between partitions

data_folder = './8-2/'
parition_folder = './8-2/partition/'
detdata_filenames = ['KHZ-HHZ-2yr-82-sorted.txt', 
    'OXZ-HHZ-2yr-82-sorted.txt', 'THZ-HHZ-2yr-82-sorted.txt', 'MQZ-HHZ-2yr-82-sorted.txt']


num_cores = min(multiprocessing.cpu_count(), 8)

def partition(fname):
    print '  Building chunks and pickling for %s...' % fname
    t0 = time.time()
    load_file = data_folder + fname

    f = open(load_file, 'r')
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
            if dt != prev_dt:
                if ((dt - prev_dt > PARTITION_GAP and len(write_buf) >= PARTITION_SIZE)) or \
                    (len(write_buf) >= PARTITION_SIZE * 2):
                    f_out = open('%s%s_%d' % (parition_folder, fname, f_count), 'w')
                    f_out.writelines(write_buf)
                    f_out.close()
                    f_count += 1
                    write_buf = []
                prev_dt = dt

            write_buf.append(line)
    f.close()
    if len(write_buf) > 0:
        f_out = open('%s%s_%d' % (parition_folder, fname, f_count), 'w')
        f_out.writelines(write_buf)
        f_out.close()

    print '  Time for %s:' % fname, time.time() - t0


if __name__ == '__main__':
    grand_start_time = time.time()

    p = multiprocessing.Pool(len(detdata_filenames))
    p.map(partition, detdata_filenames)

    print 'TOTAL PARTITIONING TIME:', time.time() - grand_start_time
