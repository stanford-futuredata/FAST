import cPickle as pickle
import time
import numpy as np
from collections import defaultdict
from itertools import count, islice
from operator import itemgetter
try:
    from itertools import izip
except ImportError:
    izip = zip
try:
    xrange
except NameError:
    xrange = range
import multiprocessing
import multiprocessing.pool
import os
from event_resolution import *
from new_association import *

#########################################################################
##            Network detection - data & parameters                    ##
#########################################################################

data_folder = './'
save_str = './results/numpy_detection'

channel_vars = ['LMA', 'LSD', 'DCD', 'VPD', 'SHD']
detdata_filenames = ['LMD_sorted.txt', 
    'LSD_sorted.txt', 'DCD_sorted.txt', 'VPD_sorted.txt', 'SHD_sorted.txt']

nchannels = len(channel_vars)
nstations = len(channel_vars)
max_fp    = 360000000  #/ largest fingperprint index  (was 'nfp')
dt_fp     = 1.0      #/ time lag between fingerprints
dgapL     = 15       #/ = 30  #/ largest gap between detections along a single diagonal
dgapW     = 3        #/ largest gap between detections adjacent diagonals
ivals_thresh = 3

#/ specifies which chunck of data (dt range) to process
q1 = 5
q2 = 86400

# only detections within 24 of each other
min_dets = 5
min_sum  = 6*min_dets
max_width = 8

#/ number of station detections to be included in event list
nsta_thresh = 2

# number of cores for parallelism
num_cores = min(multiprocessing.cpu_count(), 8)

M = 1 + 4 + 1 + 1 + 1 + 3

#########################################################################
print "creating all_diags_dict"
files = [data_folder + f for f in os.listdir(data_folder) if '.npy' in f]
print "reading %d files to numpy array..." % len(files)
all_arrs = []
for file in files:
    if 'all_diags_dict' in file:
    	continue
    print file
    arr = np.load(file)
    all_arrs.append(arr)

all_diags = np.concatenate(all_arrs)
all_diags[:, 7] = -1

#/ sort event pairs by diagonal and initial time t1 in bounding box
inds = np.lexsort([all_diags[:,0], all_diags[:,1]])
all_diags = all_diags[inds, ...]

print "Saving all_diags_dict to all_diags_dict.dat"
np.save("all_diags_dict.npy", all_diags)

associator =  NetworkAssociator()

t5 = time.time()
print 'Performing network pseudo-association...'
icount, network_events = associator.associate_network_diags(
    all_diags, nstations = nstations, offset = 20, include_stats = True)
print ' time pseudo-association:', time.time() - t5
del all_diags

########################################################################
#         EVENT RESOLUTION - detections                              ##
########################################################################

print "Saving network event to network_event.dat"
with open('network_event.dat', "wb") as f:
    pickle.dump(network_events, f, protocol=pickle.HIGHEST_PROTOCOL)

gc.collect()
# Get network events
network_events_final = get_network_events_final_by_station(
    network_events, max_fp, nstations, nsta_thresh)

# add all events to list and dedup
final_eventlist, network_eventlist, nfinal = event_to_list_and_dedup(network_events_final, nstations)

#/ get statistics for each event
final_eventstats = np.zeros((nfinal, 8))
for idx, netevent in enumerate(network_eventlist):
    flatten(netevent)
    tot_dets = 0
    max_dets = 0
    tot_vol  = 0
    max_vol  = 0
    tot_nsta = 0
    max_dL   = 0
    max_peaksum = 0
    for nid in netevent:
        ndets, vol, nsta, dL, peaksum = get_event_stats(network_events[nid])
        tot_dets += ndets
        tot_vol  += vol
        tot_nsta += nsta
        max_dets = max(max_dets, ndets)
        max_vol  = max(max_vol, vol)
        max_dL   = max(max_dL, dL)
        max_peaksum   = max(max_peaksum, peaksum)
    final_eventstats[idx] =  np.asarray([max_dL, len(netevent), tot_nsta, tot_dets, max_dets, tot_vol, max_vol, max_peaksum], dtype= int)  
        #/ store in array - total stats and highest stat for any event pair containing event

final_eventstats_str = output_results(final_eventlist, final_eventstats, save_str, channel_vars)

#/ pickle output:
mdict = dict()
mdict['data_folder'] = data_folder     #ok
mdict['channel_vars'] = channel_vars   #ok
mdict['detdata_filenames'] = detdata_filenames  #ok
mdict['dgapL'] = dgapL   #ok
mdict['dgapW'] = dgapW   #ok
mdict['final_eventlist'] = final_eventlist  #ok
mdict['network_eventlist'] = network_eventlist  #ok
mdict['final_eventstats'] = final_eventstats
mdict['final_eventstats_str'] = final_eventstats_str
mdict['nchannels'] = nchannels  #ok
mdict['nstations'] = nstations  #ok
mdict['nfp'] = max_fp       #ok
mdict['dt_minval'] = q1  #ok
mdict['dt_maxval'] = q2  #ok
mdict['ivals_thresh'] = ivals_thresh #ok
mdict['min_dets'] = min_dets         #ok
mdict['min_sum'] = min_sum           #ok
mdict['max_width'] = max_width       #ok
mdict['nsta_thresh'] = nsta_thresh   #ok
with open(save_str + '.dat', "wb") as f:
    pickle.dump(mdict, f, protocol=pickle.HIGHEST_PROTOCOL)

print 'GRAND TOTAL TIME:', time.time() - grand_start_time