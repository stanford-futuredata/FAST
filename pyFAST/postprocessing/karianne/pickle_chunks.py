import cPickle as pickle
import time
import numpy as np
import multiprocessing
from operator import itemgetter

data_folder = './pairs/'
save_str = './results/network_detection'

channel_vars = ['GVZ_HHZ', 'KHZ_HHZ', 'LTZ_HHZ']
detdata_filenames = ['9days_NZ_GVZ_HHZ.txt', '9days_NZ_KHZ_HHZ.txt', '9days_NZ_LTZ_HHZ.txt']

# channel_vars = ['KHZ_HHZ', 'GVZ_HHZ', 'LTZ_HHZ', 'MQZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
# detdata_filenames = ['KHZ_total.txt', 'GVZ_total.txt', 'LTZ_total.txt', 'MQZ_total.txt', 'OXZ_total.txt', 'THZ_total.txt']

# channel_vars = ['MQZ_HHZ', 'KHZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
# detdata_filenames = ['MQZ-HHZ-10,11-104_pairs.txt', 'KHZ-HHZ-10,11-104_pairs.txt', 'OXZ-HHZ-10,11-104_pairs.txt', 'THZ-HHZ-10,11-104_pairs.txt']

num_cores = min(multiprocessing.cpu_count(), 24)

grand_start_time = time.time()

def diag_coordsV(t1, t2):
    # for case where t1, t2 are vectors
    return np.subtract(t2, t1)

def partition(dt, sorted_indices, partition_size):
    ranges = []
    first_set = False
    counter = 0
    for idx in xrange(len(sorted_indices)):
        counter += 1
        if not first_set:
            first = idx
            first_set = True
        elif (dt[sorted_indices[idx]] - dt[sorted_indices[prev]] > 5 and counter >= partition_size) or (counter >= partition_size * 2):
            ranges.append((first, prev))
            counter = 0
            first = idx
        prev = idx
    if counter > 0:
        ranges.append((first, idx))
    return ranges

for cidx in xrange(len(channel_vars)):

    print detdata_filenames[cidx]
    print '  Building chunks and pickling...'

    # loads data, converts to (int_idx1, int_dt2 > 0, int_value) format (mapper)
    t0 = time.time()
    load_file = data_folder + detdata_filenames[cidx]
    idx1 = []
    idx2 = []
    ivals = []
    dt = []
    with open(load_file, 'r') as f:
        for index, line in enumerate(f):
            data = line.strip().split(' ')
            idx1.append(int(data[0]))
            dt.append(int(data[1]) - int(data[0]))
            #idx2.append(int(data[1]))
            ivals.append(int(data[2]))
    #dt = diag_coordsV(idx1,idx2)
    #del idx2 # optimize memory

    print '    time to load data:', time.time() - t0
    print '    number of detection pairs (total):', len(idx1)

    sort_start = time.time()
    sorted_indices = [x[0] for x in sorted(enumerate(dt), key=itemgetter(1))]
    print '    sort time:', time.time() - sort_start
    partition_start = time.time()
    index_ranges = partition(dt, sorted_indices, len(dt) / num_cores) # index_ranges are indices of indices!
    print '    partition time:', time.time() - partition_start
    pickle_start = time.time()
    for first, last in index_ranges:
        tmp = np.array(dt)
        np.save("./raw/" + detdata_filenames[cidx].split('.')[0] + "_dt_" + str(first) + "to" + str(last) + ".txt",
            tmp[sorted_indices[first:last + 1]])
        #with open("./raw/" + detdata_filenames[cidx].split('.')[0] + "_dt_" + str(first) + "to" + str(last) + ".txt", "wb") as f:
            # f.write(','.join(str(dt[i]) for i in sorted_indices[first:last + 1]))
            # tmp = []
            # for i in sorted_indices[first:last + 1]:
            #     tmp.append(dt[i])
            #     f.write(str(dt[i]))
            #pickle.dump([dt[i] for i in sorted_indices[first:last + 1]], f, -1)
        tmp = np.array(idx1)
        np.save("./raw/" + detdata_filenames[cidx].split('.')[0] + "_idx1_" + str(first) + "to" + str(last) + ".txt",
            tmp[sorted_indices[first:last + 1]])
        #with open("./raw/" + detdata_filenames[cidx].split('.')[0] + "_idx1_" + str(first) + "to" + str(last) + ".txt", "wb") as f:
            #f.write(','.join(str(idx1[i]) for i in sorted_indices[first:last + 1]))

            # for i in sorted_indices[first:last + 1]:
            #     f.write(str(idx1[i]))
            #pickle.dump([idx1[i] for i in sorted_indices[first:last + 1]], f, -1)
        tmp = np.array(ivals)
        np.save("./raw/" + detdata_filenames[cidx].split('.')[0] + "_ivals_" + str(first) + "to" + str(last) + ".txt",
            tmp[sorted_indices[first:last + 1]])
       # with open("./raw/" + detdata_filenames[cidx].split('.')[0] + "_ivals_" + str(first) + "to" + str(last) + ".txt", "wb") as f:
       #    f.write(','.join(str(ivals[i]) for i in sorted_indices[first:last + 1]))
            # for i in sorted_indices[first:last + 1]:
            #     f.write(str(ivals[i]))
            #pickle.dump([ivals[i] for i in sorted_indices[first:last + 1]], f, -1)
    print '    pickle time:', time.time() - pickle_start
    print '  Total time for %s:' % detdata_filenames[cidx], time.time() - t0

print 'GRAND TOTAL CHUNKING AND PICKLING TIME:', time.time() - grand_start_time
