import cPickle as pickle
import numpy as np
import os

data_folder = './'
M = 1 + 4 + 1 + 1 + 1 + 3

files = [data_folder + f for f in os.listdir(data_folder) if '.dat' in f]
print "converting %d files to numpy array..." % len(files)
for file in files:
    print file
    d = pickle.load(open(file, 'rb'))
    num_entries = sum(len(d[k]) for k in d)
    arr = np.empty([num_entries, M], dtype=np.int32)
    idx = 0
    for k in d:
    	for event in d[k]:
    		arr[idx, :] = [k, event[0][0], event[0][1], event[0][2],
    			event[0][3], event[1], hash(event[2]), -1, event[4][0], event[4][1], event[4][2]]
    		idx += 1
    fname = file[:-4] + '.npy'
    np.save(fname, arr)
    del d