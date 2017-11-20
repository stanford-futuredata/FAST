######################################################################### 
##                NETWORK DETECTION                                    ##
######################################################################### 

######################################################################### 
##             loads necessary libraries                               ##
######################################################################### 

import cPickle as pickle
import gc
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
from pseudo_association import *
from event_resolution import *


#########################################################################
##            Network detection - data & parameters                    ##
#########################################################################

base_dir = '/lfs/1/krong/HectorMine/'
data_folder = base_dir + 'partition/'
out_folder = base_dir + 'network_detection/'

channel_vars = ['CDY', 'CPM', 'GTM', 'HEC', 'RMM', 'RMR', 'TPC']
detdata_filenames = {}
for i, cha in enumerate(channel_vars):
  detdata_filenames[i] = 'candidate_pairs_'+cha+'_combined.txt'

nchannels = len(channel_vars)
nstations = len(channel_vars)
max_fp    = 74797    #/ largest fingerprint index  (was 'nfp')
dt_fp     = 1.0      #/ time lag between fingerprints
dgapL     = 3        #/ = 30  #/ largest gap between detections along a single diagonal
dgapW     = 3        #/ largest gap between detections adjacent diagonals
ivals_thresh = 6     # number of votes
num_pass  = 2

#/ specifies which chunck of data (dt range) to process
q1 = 5
q2 = 86400

# only detections within 24 of each other
min_dets = 4
min_sum  = ivals_thresh * min_dets
max_width = 8 # prevent diagonals from getting too fat (blobby)

#/ number of station detections to be included in event list (threshold)
nsta_thresh = 2
save_str = out_folder + '%dsta_%dstathresh' % (nstations, nsta_thresh)

# Offset length between start time on nearest(earliest) station and end time on farthest(latest) station
input_offset = 3

# number of cores for parallelism
num_cores = 4

# Dimension of the event dictionary entry in numpy format:
# [dt, bbox * 4, station_id, diagonalKey, networkEventID, event_stats * 3]
M = 1 + 4 + 1 + 1 + 1 + 3

######################################################################### 
##                  Event-pair detection functions                     ##
#########################################################################  

def dict_to_numpy(d):
    num_entries = sum(len(d[k]) for k in d)
    arr = np.empty([num_entries, M], dtype=np.int32)
    idx = 0
    for k in d:
        for event in d[k]:
            arr[idx, :] = [k, event[0][0], event[0][1], event[0][2],
                event[0][3], event[1], hash(event[2]), -1, event[4][0], event[4][1], event[4][2]]
            idx += 1
    return arr

def detection_init():
    global process_counter
    process_counter = multiprocessing.Value('i', 0)

def detection(args):
    file = args[0]
    cidx = args[1]
    associator =  NetworkAssociator()
    global process_counter
    with process_counter.get_lock():
        process_counter.value += 1
    start = time.time()
    pid = os.getpid()
    clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)

    # get events - create hashtable
    diags = clouds.p_triplet_to_diags(file,
        pid_prefix = str(pid + process_counter.value * 1000),
        ivals_thresh = ivals_thresh)
    #/ extract event-pair clouds
    curr_event_dict = clouds.diags_to_event_list(diags, npass = 2)
    del diags
    #/ prune event-pairs
    prune_events(curr_event_dict, min_dets, min_sum, max_width)
    print '    Time taken for %s:' % file, time.time() - start
    #/ Save event-pairs for the single station case
    if len(channel_vars) == 1:
        with open('%s_event_pairs.dat' % file, "wb") as f:
            pickle.dump(curr_event_dict, f, protocol=pickle.HIGHEST_PROTOCOL)
        del curr_event_dict
        return

    #/ get bounding boxes
    diags_dict = associator.clouds_to_network_diags_one_channel(
        curr_event_dict, cidx)
    del curr_event_dict
    print "Saving diags_dict to %s.npy" % file
    arr = dict_to_numpy(diags_dict)
    np.save('%s.npy' % file, arr)
    del diags_dict, arr

def process(cidx):
    print detdata_filenames[cidx]
    print '  Extracting event-pair clouds ...'
    t0 = time.time()
    files = [data_folder + f for f in os.listdir(data_folder) if f.startswith(detdata_filenames[cidx]) and not '.npy' in f]
    args = [[f, cidx] for f in files]
    pool = multiprocessing.Pool(num_cores, initializer=detection_init)
    pool.map(detection, args)
    pool.terminate()
    print '  total time for %s:' % (detdata_filenames[cidx]), time.time() - t0
    return files


if __name__ == '__main__':

    grand_start_time = time.time()

#########################################################################
##                  Event-pair detection                               ##
#########################################################################

    fnames = []
    for cidx in xrange(len(channel_vars)):
        fnames.extend(process(cidx))
        gc.collect()

#########################################################################
##                         Network detection                           ##
##         (NOTE: updated to include adjacent diagonal hashes)         ##
#########################################################################

    gc.collect()
    print 'Extracting network events...'

    #/ Single station network detection
    if len(channel_vars) == 1:
        event_dict = defaultdict(list)
        for file in fnames:
            print file
            event_pairs = pickle.load(open('%s_event_pairs.dat' % file, 'rb'))
            for k in event_pairs:
                event_dict[k].extend(event_pairs[k])

        event_start, event_dt, event_stats, pair_list = event_resolution_single(
            event_dict, max_fp)
        # TODO: Save to prettier formats
        events = {'event_start': event_start, 'event_dt': event_dt,
            'event_stats': event_stats}
        with open('%s_%s_events.dat' % (save_str,
            channel_vars[0]), "wb") as f:
            pickle.dump(events, f, protocol=pickle.HIGHEST_PROTOCOL)
        if pair_list is not None:
            with open('%s_%s_pairs_list.dat' % (save_str,
                channel_vars[0]), "wb") as f:
                pickle.dump(pair_list, f, protocol=pickle.HIGHEST_PROTOCOL)
        exit(1)

    #/ map events to diagonals
    t4 = time.time()

    all_arrs = []
    for file in fnames:
        print file
        arr = np.load('%s.npy' % file)
        all_arrs.append(arr)
    all_diags = np.concatenate(all_arrs)
    #/ sort event pairs by diagonal and initial time t1 in bounding box
    inds = np.lexsort([all_diags[:,3], all_diags[:,0]])
    all_diags = all_diags[inds, ...]

    print "Saving all_diags_dict to all_diags_dict.dat"
    np.save("all_diags_dict.npy", all_diags)
    print ' time to build network index:', time.time() - t4

    associator =  NetworkAssociator()
    #/ pseudo-association
    t5 = time.time()
    print 'Performing network pseudo-association...'
    icount, network_events = associator.associate_network_diags(
        all_diags, nstations = nstations, offset = input_offset, include_stats = True)
    print ' time pseudo-association:', time.time() - t5
    del all_diags

########################################################################
#         EVENT RESOLUTION - detections                              ##
########################################################################

    print "Saving network event to network_event.dat"
    with open('network_event.dat', "wb") as f:
        pickle.dump(network_events, f, protocol=pickle.HIGHEST_PROTOCOL)
    # network_events = pickle.load(open('network_event.dat', 'rb'))
    # print "Loaded network event"

    gc.collect()
    #/ Get network events
    network_events_final = get_network_events_final_by_station(
        network_events, max_fp, nstations, nsta_thresh)

    #/ add all events to list and dedup
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
