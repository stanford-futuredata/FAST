######################################################################### 
##                NETWORK DETECTION                                    ##
######################################################################### 

######################################################################### 
##             loads necessary libraries                               ##
######################################################################### 

import cPickle as pickle
import sys
import gc
import time
import numpy as np
from collections import defaultdict
from itertools import count, islice
from operator import itemgetter
import multiprocessing
import os
from pseudo_association import *
from event_resolution import *
from util import *
from os.path import isfile, join, getsize


# Dimension of the event dictionary entry in numpy format:
# [dt, bbox * 4, station_id, diagonalKey, networkEventID, event_stats * 3]
M = 1 + 4 + 1 + 1 + 1 + 3

######################################################################### 
##                  Event-pair detection functions                     ##
#########################################################################  

def partition(fname):
    PARTITION_SIZE = param["performance"]["partition_size"]
    PARTITION_GAP = param["performance"]["partition_gap"]

    print '  Partitioning %s...' % fname
    load_file = data_folder + fname
    file_size = getsize(load_file)
    with open(load_file, 'rb') as f:
        byte_positions = [0]
        while file_size - f.tell() > PARTITION_SIZE:
            f.seek(PARTITION_SIZE, 1) # jump PARTITION_SIZE bytes from current file position
            f.readline() # read a line to make sure we're now at the beginning of a new line (if we end up in the middle of a line, now we're at the start of the following line)
            tmp = f.readline().strip().split()
            dt = int(tmp[0])
            prev_dt = dt
            lines_read = 0
            end_reached = False
            while lines_read < PARTITION_SIZE:
                line_start = f.tell()
                line = f.readline()
                if line == '':
                    end_reached = True
                    break
                tmp = line.strip().split()
                dt = int(tmp[0])
                if dt - prev_dt > PARTITION_GAP:
                    break
                lines_read += 1
                prev_dt = dt
            if not end_reached: # this means the previous while loop ended either because we found a dt more than PARTITION_GAP away from prev_dt, or we read one more PARTITION_SIZE in which case we just split here
                byte_positions.append(line_start)
    return byte_positions

def dict_to_numpy(d):
    num_entries = sum(len(d[k]) for k in d)
    arr = np.empty([num_entries, M], dtype=np.int32)
    idx = 0
    for k in d:
        for event in d[k]:
            arr[idx, :] = [k, event[0][0], event[0][1], event[0][2],
                event[0][3], event[1], hash(event[2]), -1,
                event[4][0], event[4][1], event[4][2]]
            idx += 1
    return arr

def detection_init():
    global process_counter
    process_counter = multiprocessing.Value('i', 0)

def detection(args):
    byte_pos = args[0]
    bytes_to_read = args[1]
    cidx = args[2]
    fname = data_folder + detdata_filenames[cidx]
    start = time.time()
    pid = os.getpid()
    associator =  NetworkAssociator()
    clouds = EventCloudExtractor(dL = param["network"]["dgapL"], 
        dW = param["network"]["dgapW"])
    global process_counter
    with process_counter.get_lock():
        process_counter.value += 1

    # get events - create hashtable
    pid_prefix = str(pid + process_counter.value * 1000)
    diags = clouds.p_triplet_to_diags(fname, byte_pos, 
        bytes_to_read, pid_prefix = pid_prefix, 
        ivals_thresh = param["network"]["ivals_thresh"])
    #/ extract event-pair clouds
    curr_event_dict = clouds.diags_to_event_list(diags, 
        npass = param['network']["num_pass"])
    del diags
    #/ prune event-pairs
    min_sum = get_min_sum(param)
    prune_events(curr_event_dict, param["network"]["min_dets"], 
        min_sum, param["network"]["max_width"])
    print '    Time taken for %s (byte %d):' % (detdata_filenames[cidx], byte_pos), time.time() - start
    #/ Save event-pairs for the single station case
    if nstations == 1:
        with open('%s%s_byte_%d_event_pairs.dat' % (data_folder,
            detdata_filenames[cidx], byte_pos), "wb") as f:
            pickle.dump(curr_event_dict, f, protocol=pickle.HIGHEST_PROTOCOL)
        del curr_event_dict
        return

    #/ get bounding boxes
    diags_dict = associator.clouds_to_network_diags_one_channel(
        curr_event_dict, cidx)
    del curr_event_dict
    print "    Saving diags_dict to %s_byte_%d.npy" % (detdata_filenames[cidx], byte_pos)
    arr = dict_to_numpy(diags_dict)
    np.save('%s%s_byte_%d.npy' % (data_folder, detdata_filenames[cidx], byte_pos), arr)
    del diags_dict, arr
    return '%s%s_byte_%d.npy' % (data_folder, detdata_filenames[cidx], byte_pos)

def process(cidx):
    print '  Extracting event-pairs for %s...' % detdata_filenames[cidx]
    t0 = time.time()
    byte_positions = byte_positions_list[cidx]
    args = []
    for idx in range(len(byte_positions)): # fill args with tuples of the form (byte_pos, bytes_to_read, cidx). bytes_to_read is -1 for the last byte_pos, in which case read() will read until EOF
        if idx == len(byte_positions) - 1:
            args.append((byte_positions[idx], -1, cidx))
        else:
            args.append((byte_positions[idx], byte_positions[idx + 1] - byte_positions[idx], cidx))
    pool = multiprocessing.Pool(param["performance"]["num_cores"],
        initializer=detection_init)
    output_files = pool.map(detection, args)
    pool.terminate()
    print '    [TIMING] %s:' % (detdata_filenames[cidx]), time.time() - t0
    return output_files


if __name__ == '__main__':

    grand_start_time = time.time()

    param = parse_json(sys.argv[1])
    nstations = len(param["io"]["channel_vars"])
    data_folder = get_data_folder(param)
    out_folder = get_output_folder(param)
    out_fname = get_network_fname(param)

    if not os.path.exists(out_folder):
        os.makedirs(out_folder)

    ########################################################################
    #                  Partition                                          ##
    ########################################################################

    print "1. Partition"
    detdata_filenames = get_pairs_filenames(param)
    p = multiprocessing.Pool(nstations)
    # list of lists of byte positions,
    # each list corresponding to one of detdata_filenames
    byte_positions_list = p.map(partition, detdata_filenames)
    with open('byte_positions_list.dat', 'wb') as f:
        pickle.dump(byte_positions_list, f, protocol=pickle.HIGHEST_PROTOCOL)
    print '[TIMING] partition:', time.time() - grand_start_time

    ########################################################################
    #                  Event-pair detection                               ##
    ########################################################################

    print
    print "2. Extract event-pairs"
    process_start_time = time.time()
    fnames = []
    for i in xrange(nstations):
        fnames.extend(process(i))

    print '[TIMING] event-pair exatraction:', time.time() - process_start_time
    #########################################################################
    ##                         Network detection                           ##
    #########################################################################

    gc.collect()
    print
    print '3. Extract network events...'

    #/ Single station network detection
    if nstations == 1:
        byte_positions = byte_positions_list[0] # get byte_positions corresponding to the single station
        event_dict = defaultdict(list)
        for byte_pos in byte_positions:
            fname = '%s%s_byte_%d_event_pairs.dat' % (data_folder, detdata_filenames[0], byte_pos)
            event_pairs = pickle.load(open(fname, 'rb'))
            for k in event_pairs:
                event_dict[k].extend(event_pairs[k])

        event_start, event_dt, event_stats, pair_list = event_resolution_single(
            event_dict, param["network"]["max_fp"])
        # TODO: Save to prettier formats
        events = {'event_start': event_start, 'event_dt': event_dt,
            'event_stats': event_stats}
        print "  Outputting results to %s*" % out_fname
        with open('%s_%s_events.dat' % (out_fname,
            param["io"]["channel_vars"][0]), "wb") as f:
            pickle.dump(events, f, protocol=pickle.HIGHEST_PROTOCOL)
        if pair_list is not None:
            with open('%s_%s_pairs_list.dat' % (out_fname,
                param["io"]["channel_vars"][0]), "wb") as f:
                pickle.dump(pair_list, f, protocol=pickle.HIGHEST_PROTOCOL)
        exit(1)

    #/ map events to diagonals
    t4 = time.time()

    all_arrs = []
    for file in fnames:
        print "  %s" % file
        arr = np.load(file)
        all_arrs.append(arr)
    all_diags = np.concatenate(all_arrs)
    #/ sort event pairs by diagonal and initial time t1 in bounding box
    inds = np.lexsort([all_diags[:,3], all_diags[:,0]])
    all_diags = all_diags[inds, ...]

    print "  Saving all_diags_dict to all_diags_dict.npy"
    np.save("all_diags_dict.npy", all_diags)
    print '[TIMING] build network index:', time.time() - t4

    #########################################################################
    ##                         pseudo-association                          ##
    #########################################################################
    associator =  NetworkAssociator()
    #/ pseudo-association
    t5 = time.time()
    print
    print '4. Network pseudo-association'
    icount, network_events = associator.associate_network_diags(
        all_diags, nstations = nstations, offset = param["network"]["input_offset"])
    del all_diags

    print "  Saving network event to network_event.dat"
    with open('network_event.dat', "wb") as f:
        pickle.dump(network_events, f, protocol=pickle.HIGHEST_PROTOCOL)
    print '[TIMING] pseudo-association:', time.time() - t5

    ########################################################################
    #         EVENT RESOLUTION - detections                              ##
    ########################################################################
    # network_events = pickle.load(open('network_event.dat', 'rb'))
    # print "Loaded network event"

    gc.collect()
    #/ Get network events
    network_events_final = get_network_events_final_by_station(
        network_events, param["network"]["max_fp"],
        nstations, param["network"]["nsta_thresh"])

    # add all events to list and dedup
    final_eventlist, network_eventlist, nfinal = event_to_list_and_dedup(
        network_events_final, nstations)

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

    final_eventstats_str = output_results(final_eventlist, 
        final_eventstats, out_fname, param["io"]["channel_vars"])

    #/ pickle output:
    mdict = dict()
    mdict['final_eventlist'] = final_eventlist  #ok
    mdict['network_eventlist'] = network_eventlist  #ok
    mdict['final_eventstats'] = final_eventstats
    mdict['final_eventstats_str'] = final_eventstats_str
    with open(out_fname + '.dat', "wb") as f:
        pickle.dump(mdict, f, protocol=pickle.HIGHEST_PROTOCOL)

    print 'GRAND TOTAL TIME:', time.time() - grand_start_time
