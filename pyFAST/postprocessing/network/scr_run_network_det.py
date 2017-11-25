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

data_folder = './new-82/partition/'
save_str = './results/new_82_network_detection_all'

channel_vars = ['KHZ', 'THZ',  'OXZ',  'MQZ', 'LTZ']
detdata_filenames = ['NZ.KHZ.HHZ.2yr.82_pairs_sorted', 'NZ.THZ.HHZ.2yr.82_pairs_sorted', 
       'NZ.OXZ.HHZ.2yr.82_pairs_sorted', 'NZ.MQZ.HHZ.2yr.82_pairs_sorted', 'LTZ_sorted']


nchannels = len(channel_vars)
nstations = len(channel_vars)
max_fp    = 32000000  #/ largest fingperprint index  (was 'nfp')
#max_fp  =    360000000
dt_fp     = 2.0      #/ time lag between fingerprints
dgapL     = 15       #/ = 30  #/ largest gap between detections along a single diagonal
dgapW     = 3        #/ largest gap between detections adjacent diagonals
ivals_thresh = 2

#/ specifies which chunck of data (dt range) to process
q1 = 5
q2 = 86400

# only detections within 24 of each other
min_dets = 5
min_sum  = 2 * ivals_thresh * min_dets
max_width = 8

#/ number of station detections to be included in event list
nsta_thresh = 2

# number of cores for parallelism
num_cores = min(multiprocessing.cpu_count(), 8)

PARTITION_SIZE = 100000000     # Size of partition in lines (this is around 2 GB per partition)
PARTITION_GAP = 5              # Minimum dt gap between partitions

######################################################################### 
##                  Event-pair detection functions                     ##
#########################################################################  

def partition(fname):
    print '  Building chunks and pickling for %s...' % fname
    load_file = data_folder + fname
    with open(load_file, 'r') as f:
        lines_read = 0
        bytes_so_far = 0
        prev_dt = None
        byte_positions = [0]
        for index, line in enumerate(f):
            tmp = line.strip().split()
            dt = int(tmp[0])
            idx1 = int(tmp[1])
            ivals = int(tmp[2])
            if not prev_dt:
                prev_dt = dt
            if (dt - prev_dt > PARTITION_GAP and lines_read >= PARTITION_SIZE) or \
                (lines_read >= PARTITION_SIZE * 2):
                byte_positions.append(bytes_so_far)
                lines_read = 0
            curr_bytes = len(line.encode())
            bytes_so_far += curr_bytes
            prev_dt = dt
            lines_read += 1
    byte_positions.append(bytes_so_far)
    return byte_positions

def detection_init():
    global process_counter
    process_counter = multiprocessing.Value('i', 0)

def detection(args):
    byte_pos = args[0]
    bytes_to_read = args[1]
    cidx = args[2]
    start = time.time()
    pid = os.getpid()
    associator =  NetworkAssociator()
    clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)
    global process_counter
    with process_counter.get_lock():
        process_counter.value += 1

    # get events - create hashtable
    diags = clouds.p_triplet_to_diags(detdata_filenames[cidx], byte_pos, bytes_to_read, 
                                      pid_prefix = str(pid + process_counter.value * 1000), ivals_thresh = ivals_thresh)
    #/ extract event-pair clouds
    curr_event_dict = clouds.diags_to_event_list(diags, npass = 3)
    del diags
    #/ prune event-pairs
    prune_events(curr_event_dict, min_dets, min_sum, max_width)
    print '    Time taken for %s:' % file, time.time() - start
    #/ get bounding boxes
    diags_dict = associator.clouds_to_network_diags_one_channel(
        curr_event_dict, cidx)
    del curr_event_dict
    print "Saving diags_dict to byte%d_diags.dat" % byte_pos
    with open('byte%d_diags.dat' % byte_pos, "wb") as f:
        pickle.dump(diags_dict, f, protocol=pickle.HIGHEST_PROTOCOL)
    del diags_dict
    return 'byte%d_diags.dat' % byte_pos

def process(cidx):
    print detdata_filenames[cidx]
    print '  Extracting event-pair clouds ...'
    t0 = time.time()
    byte_positions = byte_positions_list[cidx]
    args = []
    for idx in xrange(len(byte_positions)): # fill args with tuples of the form (byte_pos, bytes_to_read, cidx). bytes_to_read is -1 for the last byte_pos, in which case we will call read() with no argument
        if idx == len(byte_positions) - 1:
            args.append((byte_positions[idx], -1, cidx))
        else:
            args.append((byte_positions[idx], byte_positions[idx + 1] - byte_positions[idx], cidx))
    pool = multiprocessing.Pool(num_cores, initializer=detection_init)
    output_files = pool.map(detection, args)
    pool.terminate()
    print '  total time for %s:' % (detdata_filenames[cidx]), time.time() - t0
    return output_files


if __name__ == '__main__':

    grand_start_time = time.time()

    #########################################################################
    ##                  Event-pair detection                               ##
    #########################################################################

    p = multiprocessing.Pool(len(detdata_filenames))
    byte_positions_list = p.map(partition, detdata_filenames) # list of lists of byte positions, each list corresponding to one of detdata_filenames

    print 'TOTAL PARTITIONING TIME:', time.time() - grand_start_time

    process_start_time = time.time()

    dict_names = {}
    for cidx in xrange(len(detdata_filenames)):
        dict_names[cidx] = process(cidx)
        gc.collect()

    print 'TOTAL PROCESSING TIME:', time.time() - process_start_time
#########################################################################
##                         Network detection                           ##
##         (NOTE: updated to include adjacent diagonal hashes)         ##
#########################################################################

    gc.collect()
    print 'Extracting network events...'

    associator =  NetworkAssociator()

    #/ map events to diagonals
    t4 = time.time()

    all_diags_dict = defaultdict(list)
    for cidx in xrange(len(channel_vars)):
        for file in dict_names[cidx]:
            print file
            diags_dict = pickle.load(open(file, 'rb'))
            for k in diags_dict:
                all_diags_dict[k].extend(diags_dict[k])

    #/ sort event pairs by initial time t1 in bounding box
    for k in all_diags_dict:
        all_diags_dict[k].sort(key=lambda x: x[0][2])

    print "Saving all_diags_dict to all_diags_dict.dat"
    with open('all_diags_dict.dat', "wb") as f:
        pickle.dump(all_diags_dict, f, protocol=pickle.HIGHEST_PROTOCOL)
    print ' time to build network index:', time.time() - t4

    # associator =  NetworkAssociator()
    # all_diags_dict = pickle.load(open('all_diags_dict.dat', "rb"))
    #/ pseudo-association
    t5 = time.time()
    print 'Performing network pseudo-association...'
    icount, network_events = associator.associate_network_diags(
        all_diags_dict, nstations = nstations, offset = 20, include_stats = True)
    print ' time pseudo-association:', time.time() - t5
    del all_diags_dict

########################################################################
#         EVENT RESOLUTION - detections                              ##
########################################################################

    print "Saving network event to network_event.dat"
    with open('network_event.dat', "wb") as f:
        pickle.dump(network_events, f, protocol=pickle.HIGHEST_PROTOCOL)
    # network_events = pickle.load(open('network_event.dat', 'rb'))
    # print "Loaded network event"

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
