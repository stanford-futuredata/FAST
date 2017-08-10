######################################################################### 
##                NETWORK DETECTION                                    ##
######################################################################### 
 
######################################################################### 
##             loads necessary libraries                               ##
######################################################################### 

import pickle
import time
import numpy as np
from collections import defaultdict
from itertools import count, islice
try:
    from itertools import izip
except ImportError:
    izip = zip
import multiprocessing
from multiprocessing import Array
from multiprocessing.pool import ThreadPool
import os
from bisect import *

file_parallel = False
parallel = True

######################################################################### 
##               functions                                            ##
######################################################################### 

def diag_coordsV(t1, t2):
    # for case where t1, t2 are vectors
    return np.subtract(t2, t1)

def prune_events(event_dict, min_dets = 0, min_sum = 0, max_width = None):
    for k in list(event_dict):
        ndets = len(event_dict[k])
        detsum = sum([x[2] for x in event_dict[k]])
        if (ndets < min_dets) or (detsum < min_sum):
            del event_dict[k]
        else:
            if max_width:
                dtlist = [x[0] for x in event_dict[k]]
                if max(dtlist) - min(dtlist) > max_width:
                    del event_dict[k]

######################################################################### 
##               EventCloudExtractor                                   ##
######################################################################### 

def index(a, x):
    'Locate the leftmost value exactly equal to x'
    i = bisect_left(a, x)
    if i != len(a) and a[i] == x:
        return i
    raise ValueError

class EventCloudExtractor:
    def __init__(self, dL, dW):
      self.dL     = dL
      self.dW     = dW

    def triplet_to_diags(self, q1, q2, event_ID, pid_prefix = True, dL = None, dt_min = 0, dt_max = None, ivals_thresh = 0, lock = None):
        if dt_max is None:
            dt_max = float('inf')
        if dL is None:
            dL = self.dL
        #/ map data to diagonals
        t1 = time.time()
        diags = defaultdict(list) #/ initialize hash table
        prev_key = dt[q1]
        elems = []
        l = len(pairs) / 3
        for i in range(q1, q2):
            if pairs[i + 2 * l] < ivals_thresh or pairs[i] < dt_min or pairs[i] > dt_max: # the second two conditions aren't applicable to the parallel case since they'd always be false
                continue
            if pairs[i] != prev_key:
                l = len(elems)
                if l > 0:
                    elems.sort(key=lambda x: x[0])
                    elems[0][2] = event_ID
                    if l >= 2:
                        for j in range(1, l):
                            if elems[j][0] - elems[j - 1][0] > dL:
                                if pid_prefix:
                                    pid = event_ID.split('-')[0]
                                    idval = int(event_ID.split('-')[1])
                                    event_ID = pid + '-' + str(idval + 1)
                                else:
                                    event_ID += 1
                            elems[j][2] = event_ID
                    diags[prev_key] = elems
                    elems = []
                    if pid_prefix:
                        pid = event_ID.split('-')[0]
                        idval = int(event_ID.split('-')[1])
                        event_ID = pid + '-' + str(idval + 1)
                    else:
                        event_ID += 1
                prev_key = pairs[i]
            elems.append([pairs[i + l], pairs[i + 2 * l], None])
        # for the remaining stuff accumulated in elems
        l = len(elems)
        if l > 0:
            elems.sort(key=lambda x: x[0])
            elems[0][2] = event_ID
            if l >= 2:
                for j in range(1, l):
                    if elems[j][0] - elems[j - 1][0] > dL:
                        if pid_prefix:
                            pid = event_ID.split('-')[0]
                            idval = int(event_ID.split('-')[1])
                            event_ID = pid + '-' + str(idval + 1)
                        else:
                            event_ID += 1
                    elems[j][2] = event_ID
            diags[prev_key] = elems
        return diags

    def diags_to_event_list(self, diags, dt_min = None, dt_max = None, npass = 3, lock = None):
        t1 = time.time()
        if dt_min is None or dt_max is None:
            dt_min = min(diags.keys())
            dt_max = max(diags.keys())
        for p in range(npass):
            if p % 2 == 0:  #/ forward pass
                t0 = time.time()
                for qidx in range(dt_min, dt_max):
                    diags[qidx], diags[qidx+1] = self.merge_diags(diags[qidx], diags[qidx+1], self.dW)
                # if lock is None:
                #     print '      pass ' + str(p) + ': ' + str( time.time() - t0)
            else:  #/ backward pass
                t0 = time.time()
                for qidx in range(dt_max-1, dt_min-1, -1):
                    diags[qidx+1], diags[qidx] = self.merge_diags(diags[qidx+1], diags[qidx], self.dW)
                # if lock is None:
                #     print '      pass ' + str(p) + ': ' + str( time.time() - t0)
        t0 = time.time()
        event_dict = defaultdict(list)
        for k in diags:
            for t1, sim, eventid in diags[k]:
                event_dict[eventid].append([k,t1,sim])
        # if lock is None:
        #     print '    populating event hash table ' + str( time.time() - t0)
        return event_dict

    def merge_diags(self, diag0, diag1, dW = None):
        if dW is None:
            dW = self.dW
        #event_equivalence = []
        if diag0 and diag1:
            first_idx0, last_idx0 = self._get_event_start_end(diag0) #/ for each event_ID, get first and last index where it appears in diags[j]
            first_t0 = [ diag0[i][0] for i in first_idx0 ]     #/ get first timestamp for each event_ID
            last_t0  = [ diag0[i][0] for i in last_idx0 ]      #/ get last timestamp for each event_ID
            # TODO - call this directly when resetting overlapping events so that if eventID is updated, its taken into account immediately (for multiple overlaps within single pair of adjacent diagonals)
            eventID0 = [ diag0[i][2] for i in first_idx0 ]
            first_idx1, last_idx1 = self._get_event_start_end(diag1)
            first_t1 = [ diag1[i][0] for i in first_idx1 ]     #/ get first timestamp for each event_ID
            last_t1  = [ diag1[i][0] for i in last_idx1 ]      #/ get last timestamp for each event_ID
            # TODO - call this directly when resetting overlapping events so that if eventID is updated, its taken into account immediately (for multiple overlaps within single pair of adjacent diagonals)
            eventID1 = [ diag1[i][2] for i in first_idx1 ]
            #TODO - handles case of nultiple overlaps for same event
            n1 = len(first_t1)
            j = 0
            for i, t0_start, t0_end, id0 in izip(count(), first_t0, last_t0, eventID0):
                while (j < n1) and (t0_start > last_t1[j] + dW): # increment j if event j is before event i
                    j += 1
                if (j < n1) and (t0_start  - dW  <= last_t1[j]) and (first_t1[j] <= t0_end + dW):
                    newEventID =  min(eventID0[i], eventID1[j])
                    eventID0[i] = newEventID  #/ update for next iteration
                    eventID1[j] = newEventID
                    #/ updates eventIDs (in all triplets)
                    for ridx0 in range(first_idx0[i], last_idx0[i] + 1):
                        diag0[ridx0][2] = newEventID
                    for ridx1 in range(first_idx1[j], last_idx1[j] + 1):
                        diag1[ridx1][2] = newEventID
        return diag0, diag1 #, event_equivalence

    def _get_event_start_end(self, diag0):
        n0 = len(diag0)
        event_last_idx  = [ i for i, j, k in izip(count(), diag0[1:], diag0[:-1] ) if j[2] != k[2]] + [n0-1]
        event_first_idx = [0] + [ x+1  for x in event_last_idx[:-1]]
        return event_first_idx, event_last_idx

##########################################################################
###                  Pseudo-Association                                 ##
##########################################################################

class NetworkAssociator:
    def __init__(self, icount = 0):
        self.icount = icount

    def clouds_to_network_diags(self, event_dict, event_dict_keys, include_stats = False):
        all_diags_dict = defaultdict(list)
        dcount = 0
        for cidx, channel in enumerate(event_dict_keys):
            for k in event_dict[channel].keys():
                ddiag, bbox = self._get_ddiag_bbox(event_dict[channel][k])
                if include_stats:
                    event_stats = self._get_event_stats(event_dict[channel][k])
                    all_diags_dict[ddiag].append([bbox, cidx, k, None, event_stats])  #/ boundingBox, stationID, diagonalKey, networkEventID, event_stats : (ndets , vol (sum_sim), peak_sim)
                else:
                    all_diags_dict[ddiag].append([bbox, cidx, k, None])  #/ boundingBox, stationID, diagonalKey, networkEventID
                dcount += 1
        for k in all_diags_dict.keys():
            all_diags_dict[k].sort(key=lambda x: x[0][2])  #/ sort event pairs by initial time t1 in bounding box             
        return all_diags_dict, dcount


    def associate_network_diags(self, all_diags_dict, nstations, offset, q1 = None, q2 = None, return_network_events = True, include_stats = True):
        p = 2*nstations
        icount = self.icount
        # for k in all_diags_dict:
        #     print k, ":", all_diags_dict[k]
        if (q1 is None) or (q2 is None):
            tmpk = all_diags_dict.keys()
            q1 = min(tmpk)
            q2 = max(tmpk) + 1 
        for k in range(q1, q2):
            #/ from this diagonal
            t_init_k0 = [x[0][2] for x in all_diags_dict[k]]    #/ initial time of each bbox along diag k
            t_end_k0  = [x[0][3] for x in all_diags_dict[k]]    #/ end time of each bbox along diag k  
            eid_k0    = [x[3] for x in all_diags_dict[k]]       #/ network eventID
            stid_k0   = [x[1] for x in all_diags_dict[k]]       #/ stationID
            t_init_k1 = [x[0][2] for x in all_diags_dict[k+1]]  #/ initial time of each bbox along diag k 
            t_end_k1  = [x[0][3] for x in all_diags_dict[k+1]]  #/ end time of each bbox along diag k  
            eid_k1    = [x[3] for x in all_diags_dict[k+1]]     #/ network eventID
            stid_k1   = [x[1] for x in all_diags_dict[k+1]]     #/ stationID
            if len(t_init_k0 + t_init_k1) >= 1:
                #/ bookkeeping
                kidx  = [0 for x in all_diags_dict[k]] + [1 for x in all_diags_dict[k+1]]                               #/ which diagonal hash does this event belong to
                oidx = [z for z, x in enumerate(all_diags_dict[k])] + [z for z, x in enumerate(all_diags_dict[k+1])]  #/ index of event within diagonal hash
                #/ resort by t_init
                t_init, t_end, tmp_eid, stid, kidx, oidx = zip(*sorted(zip( t_init_k0+t_init_k1, t_end_k0+t_end_k1, eid_k0+eid_k1, stid_k0+stid_k1, kidx, oidx)))  
                eid = [x for x in tmp_eid] #/ makes eid a list (tmp_eid is a tuple)
                #/ sweeps through event pairs assigned to hash k and k+1            
                for j, t1 in izip(count(), t_end):
                    if (j == len(t_end)-1) or (stid[j] != stid[j+1]):                                                                 #/ skip if same station ID as next entry (don't want to match to itself - skips checking if we already know this would be self-match)
                        dt1 = tuple([t - t1 for t in t_init[j+1:j+p]])
                        # dt1 = t_init[j+1:j+p] - t1
                        if len(dt1) > 0:
                            if dt1[0] <= offset:                                                                                      #/ if at least one other event is close in time
                                glist = [j] + [j+1+q for q, t2 in izip(count(), dt1) if (t2 <= offset) and (stid[j+1+q] != stid[j])]  #/ group if within offset (unless same station - fix?)   
                                if len(glist) > 1:   
                                    elist = [eid[q] for q in glist]   
                                    tmpid = [q for q in elist if q is not None]
                                    if tmpid:  # (case of 2+ pre-existing event labels)
                                        tmpid = min(tmpid)
                                    elif not tmpid: #/ if event already has label (case of 1 pre-existing event label) NOTE: weird numbering issue without elif
                                        tmpid = icount
                                        icount += 1      
                                    for q in glist:
                                        eid[q] = tmpid 
                for tmpidx, tmpk, tmpeid in izip(oidx, kidx, eid): #/ 
                    if tmpk == 0:
                        all_diags_dict[k][tmpidx][3] = tmpeid
                    else:
                        all_diags_dict[k+1][tmpidx][3] = tmpeid           
        
        #/ compiles list of events detected on multiple stations            
        if return_network_events:              
            network_events = defaultdict(list)        
            for k in range(q1, q2):
                for eventcloud in all_diags_dict[k]:
                    if eventcloud[3] is not None:
                        if include_stats:
                            network_events[ eventcloud[3] ].append( ((k, k, eventcloud[0][2], eventcloud[0][3]), eventcloud[1], eventcloud[2], eventcloud[4]) )
                        else:    
                            network_events[ eventcloud[3] ].append( ((k, k, eventcloud[0][2], eventcloud[0][3]), eventcloud[1], eventcloud[2]) )
        else: 
            network_events = None  
            
        self.icount = icount                                                          
        return icount, network_events                                                                                

    def _get_ddiag_bbox(self, event_data, return_bbox = True):
        ddiag = None #/ assigns valid value
        bbox  = None #/ assigns valid value
        dtlist  = [x[0] for x in event_data]
        dtmin   = min(dtlist)
        dtmax   = max(dtlist)
        if dtmin == dtmax: #/ if one diagonal, this is dominant
            ddiag = dtmin
        else:              #/ if multiple diagonals, select one with largest similarity (numpy returns first instance of maximum)
            simlist = [x[2] for x in event_data]  
            ddiag = dtlist[np.argmax(simlist)]     #/ TODO: update rule
        if return_bbox:  #/ compute bounding box, if requested  
            t1list  = [x[1] for x in event_data]
            t1min   = min(t1list)
            t1max   = max(t1list) 
            bbox    = (dtmin, dtmax, t1min, t1max)    
        return ddiag, bbox  
        
    def _get_event_stats(self, event_data):
        tmp = [x[2] for x in event_data]
        return ( len(event_data) , sum(tmp), max(tmp) ) 

#########################################################################
##            Network detection - data & parameters                    ##
#########################################################################

data_folder = './pairs/'
save_str = './results/network_detection'

#channel_vars = ['GVZ_HHZ', 'KHZ_HHZ', 'LTZ_HHZ']
#detdata_filenames = ['9days_NZ_GVZ_HHZ.txt', '9days_NZ_KHZ_HHZ.txt', '9days_NZ_LTZ_HHZ.txt']

channel_vars = ['GVZ_HHZ', 'KHZ_HHZ', 'LTZ_HHZ', 'MQZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
detdata_filenames = ['GVZ_total.txt', 'KHZ_total.txt', 'LTZ_total.txt', 'MQZ_total.txt', 'OXZ_total.txt', 'THZ_total.txt']

nchannels = len(channel_vars)
nstations = len(channel_vars)
max_fp    = 17*86400  #/ largest fingperprint index  (was 'nfp')
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
num_cores = min(multiprocessing.cpu_count(), 2)


######################################################################### 
##                      Helper functions                               ##
#########################################################################                            


#/
def get_event_stats(network_event):
    ndets = sum( [x[3][0] for x in network_event] )
    vol   = sum( [x[3][1] for x in network_event] )
    sta   = np.unique( [x[1] for x in network_event] )
    nsta  = len( sta )
    if len(sta) != len(network_event): #/ multiple detections
        dstart = np.nan + np.ones(max(sta)+1)
        dend   = np.nan + np.ones(max(sta)+1)
        peakval = np.nan + np.ones(max(sta)+1)
        for x in network_event:
            dstart[x[1]] = np.nanmin((x[0][2], dstart[x[1]]))
            dend[x[1]] = np.nanmax((x[0][3], dend[x[1]]))
            peakval[x[1]] = np.nanmax( (x[3][2], peakval[x[1]] ))
        dL = np.nanmax(dend - dstart)
        peaksum = np.nansum(peakval)
    else:
        dL = max([x[0][3] - x[0][2] for x in network_event ]) #/ longest duration event
        peaksum =  sum([x[3][2] for x in network_event])
    #/ max dets for each station
    return ndets, vol, nsta, dL, peaksum

#/ flatten list of lists
def flatten(items, seqtypes=(list, tuple)):
    for i, x in enumerate(items):
        while i < len(items) and isinstance(items[i], seqtypes):
            items[i:i+1] = items[i]
    return items

#/
def get_det_list(ndets, timestamp_to_netid):
    det_start = np.where((ndets[:-1] == 0) & (ndets[1:] > 0))[0] + 1
    det_end   = np.where((ndets[:-1] > 0) & (ndets[1:] == 0))[0] + 1
    det_dt    = det_end - det_start
    det_connect  = list()
    for x, y in izip(det_start, det_dt):
        tmp = list()
        for z in range(x,x+y+1):
            [tmp.append(q) for q in timestamp_to_netid[z]]
        det_connect.append(sorted(list(set(tmp))))
    return det_start, det_dt, det_connect

def partition(dt, partition_size):
    ranges = []
    first_set = False
    counter = 0
    for idx in range(len(dt)):
        counter += 1
        if not first_set:
            first = idx
            first_set = True
        #elif dt[idx] - dt[prev] > 10 and counter >= partition_size:
        elif counter >= partition_size:
            ranges.append((first, prev))
            counter = 0
            first = idx
        prev = idx
    ranges.append((first, idx))
    return ranges

######################################################################### 
##                  Event-pair detection functions                     ##
#########################################################################  

def detection_init(l, dt, idx1, ivals):
    global lock
    lock = l
    global pairs
    dt.extend(idx1)
    dt.extend(ivals)
    pairs = Array('i', dt)

def detection(ranges):
    start = time.time()
    pid = os.getpid()
    clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)
    q1 = ranges[0]
    q2 = ranges[1]
    x = None

    # get events - create hashtable
    t0 = time.time()
    diags = clouds.triplet_to_diags(q1, q2, str(pid) + '-0', ivals_thresh = ivals_thresh, lock = lock)
    #diags = clouds.triplet_to_diags(dt, idx1, ivals, str(pid) + '-0', ivals_thresh = ivals_thresh, lock = lock)
    if parallel:
        lock.acquire()
    print '(%d, %d): time triplet_to_diags:' % (q1, q2), time.time() - t0
    if parallel:
        lock.release()
    #/ extract event-pair clouds
    t1 = time.time()
    curr_event_dict = clouds.diags_to_event_list(diags, npass = 3, lock = lock)
    diags = None
    if parallel:
        lock.acquire()
    print '(%d, %d): time diags_to_event_list:' % (q1, q2), time.time() - t1
    if parallel:
        lock.release()
    #/ prune event-pairs
    prune_events(curr_event_dict, min_dets, min_sum, max_width)
    if parallel:
        lock.acquire()
    print('    time for this batch at process %d:' % pid, time.time() - start)
    if parallel:
        lock.release()
    return curr_event_dict

def process(x):
    global event_ID, dt, idx1, ivals, clouds
    cidx = x[0]
    detdata_filenames = x[1]
    data_folder = x[2]

    # print detdata_filenames[cidx] 
    # print '  Extracting event-pair clouds ...'

    # loads data, converts to (int_idx1, int_dt2 > 0, int_value) format (mapper)
    t0 = time.time()
    print "Start %f" % t0
    load_file = data_folder + detdata_filenames[cidx]
    idx1 = []
    idx2 = []
    ivals = []
    with open(load_file, 'r') as f:
        for index, line in enumerate(f):
            data = line.strip().split(' ')
            idx1.append(int(data[0]))
            idx2.append(int(data[1]))
            ivals.append(int(data[2]))
    dt = diag_coordsV(idx1,idx2)

    # print '    time to load data: ' + str( time.time() - t0)
    # print '    number of detection pairs (total): ' + str( len(idx1) )

    sort_start = time.time()
    #print "Sort start %f" % sort_start
    sorted_tups = sorted(zip(dt, idx1, ivals))
    dt = [tup[0] for tup in sorted_tups]
    idx1 = [tup[1] for tup in sorted_tups]
    ivals = [tup[2] for tup in sorted_tups]
    sorted_tups = None
    print('    sort time:', time.time() - sort_start)
    partition_start = time.time()
    dt_ranges = partition(dt, len(dt) / num_cores)
    print('    partition time:', time.time() - partition_start)

    #clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)

    if parallel:
        #print "Processing start %f" % time.time()
        l = multiprocessing.Lock()
        pool = multiprocessing.Pool(num_cores,
            initializer=detection_init, initargs=(l, dt, idx1, ivals))
        event_dicts = pool.map(detection, dt_ranges)
        pool.close()
        pool.join()
        result = {}
        #print "Processing end %f" % time.time()
        for dictionary in event_dicts:
            result.update(dictionary)
        #print "Merge end %f" % time.time()
    else:
        # get events - create hashtable
        t1 = time.time()
        clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)
        diags = clouds.triplet_to_diags(dt, idx1, ivals, 0, ivals_thresh = ivals_thresh, lock = lock)
        print '    time triplet_to_diags: ' + str( time.time() - t1)
        #/ extract event-pair clouds
        t2 = time.time()
        result = clouds.diags_to_event_list(diags, npass = 3)
        diags = None
        print '    time diags_to_event_list: ' + str( time.time() - t2)
        #/ prune event-pairs
        t3= time.time()
        prune_events(result, min_dets, min_sum, max_width)
        #print '    time prune_events: ' + str( time.time() - t3)
    print('  total time for %s:' % (detdata_filenames[cidx]), time.time() - t0)
    return result

#########################################################################
##                  Event-pair detection                               ##
#########################################################################

if parallel:
    print('PARALLEL')
else:
    print('NON PARALLEL')
if file_parallel:
    print('FILE-PARALLEL')
else:
    print('NON FILE-PARALLEL')

grand_start_time = time.time()

if file_parallel:
    num_cores = min(multiprocessing.cpu_count(), 24)
    pool = multiprocessing.Pool(num_cores)
    event_dict = dict(izip(range(len(channel_vars)), pool.map(process, [(cidx, detdata_filenames, data_folder) for cidx in range(len(channel_vars))])))
else:
    event_dict = dict(izip(range(len(channel_vars)), map(process, [(cidx, detdata_filenames, data_folder) for cidx in range(len(channel_vars))])))

#########################################################################
##                         Network detection                           ##
##         (NOTE: updated to include adjacent diagonal hashes)         ##
#########################################################################

print('Extracting network events...')

associator =  NetworkAssociator()

#/ map events to diagonals
t4 = time.time()
all_diags_dict, dcount = associator.clouds_to_network_diags(event_dict, event_dict_keys = range(0,nstations), include_stats = True)
print(' time to build network index: ' + str( time.time() - t4))

#/ pseudo-association
t5 = time.time()
print('Performing network pseudo-association...')
icount, network_events = associator.associate_network_diags(all_diags_dict, nstations = nstations, offset = 20, include_stats = True)
print(' time pseudo-association: ' + str( time.time() - t5))

#########################################################################
##         EVENT RESOLUTION - detections                              ##
#########################################################################

networkID = network_events.keys()
timestamp_to_netid = dict()
for i in range(nstations):
    timestamp_to_netid[i] = defaultdict(list) #/ keeps track of which network eventIDs are observed at each time

for nid in networkID:
    net_event = network_events[nid]
    if len(np.unique([ x[1] for x in net_event])) >= nsta_thresh: #/ number of unique stations - THIS IS DATASET/TASK SPECIFIC (criteria does not even have to be related to station count)
        stid  = [x[1] for x in net_event]
        t1min = [x[0][2] for x in net_event]
        t1max = [x[0][3] for x in net_event]
        t2min = [x[0][0]+x[0][2] for x in net_event]
        t2max = [x[0][0]+x[0][3] for x in net_event]
        for stid0, t1a, t1b, t2a, t2b in izip(stid, t1min, t1max, t2min, t2max):
            for t in range(t1a,t1b+1):
                timestamp_to_netid[stid0][t].append(nid)
            for t in range(t2a,t2b+1):
                timestamp_to_netid[stid0][t].append(nid)

#/ counts number of detections for each time interval (for each station)
nfp = max_fp
ndets = np.zeros((nstations, nfp))
for stid in range(nstations):
    for fpid in timestamp_to_netid[stid].keys():
        ndets[stid,fpid] = len( timestamp_to_netid[stid][fpid] )

#/ map detection pairs to event times (i.e. resolve events for each station separately)
det_data = []
for i in range(nstations):
    det_data.append(get_det_list(ndets[i,:], timestamp_to_netid[i])) #/ gets list of detections - may need to be updated depending on dataset

#/ map back to network_events_final (i.e. assign detections at each station to the corresponding "network detection"
network_events_final = defaultdict(lambda: defaultdict(list))
for i in range(len(det_data)):
    for j in range(len(det_data[i][0])):
        for nid in det_data[i][2][j]:
            network_events_final[nid][i].append(det_data[i][0][j])

#/ get dt values:
for nid in network_events_final.keys():
    network_events_final[nid]['dt']      = int(np.median([x[0][0] for x in network_events[nid]]))
    network_events_final[nid]['ndets']   = sum([x[3][0] for x in network_events[nid]])
    network_events_final[nid]['vol']     = sum([x[3][1] for x in network_events[nid]])
    network_events_final[nid]['max_sum'] = sum([x[3][2] for x in network_events[nid]])

#/ add all events to list (includes redundancies if event belongs to multiple pairs)
networkIDs = sorted(network_events_final.keys())
out = np.nan + np.ones((2*len(networkIDs), nstations + 1))  
for i, nid in enumerate(networkIDs):
    tmp_dt =  network_events_final[nid]['dt']
    for stid in range(nstations):
        if network_events_final[nid][stid]:
            if  len(network_events_final[nid][stid]) == 2:        
                out[2*i,stid] =  network_events_final[nid][stid][0] 
                out[2*i + 1,stid] = network_events_final[nid][stid][1] 
                out[2*i,nstations] =  nid 
                out[2*i + 1,nstations] =  nid
            elif len(network_events_final[nid][stid]) == 1:  #/ if only one event in "pair" (i.e dt is small - TODO: ensure this case can't happen)
                out[2*i,stid] =  network_events_final[nid][stid][0]
                out[2*i + 1,stid] = network_events_final[nid][stid][0]
                out[2*i,nstations] =  nid
                out[2*i + 1,nstations] =  nid
            else: # if multiple
                tmp_ts = network_events_final[nid][stid]
                sidx = [0, np.argmax([q-p for p, q in zip(tmp_ts[:-1], tmp_ts[1:])]) + 1]
                out[2*i,stid] = np.min(tmp_ts[sidx[0]:sidx[1]])
                out[2*i + 1,stid] = np.min(tmp_ts[sidx[1]:])
                out[2*i,nstations] =  nid 
                out[2*i + 1,nstations] =  nid

## remove duplicates from event-list (find and remove entries that are identical up to missing values (nan)) ##

out2      = out[:, 0:nstations]
netids2   = list( out[:,nstations].astype(int) )

for sta in range(nstations):
    row_sort0 = np.argsort( out2[:,sta] ) 
    out2      = out2[row_sort0,:]
    netids2   = [ netids2[x] for x in row_sort0]    
    n1, n2 = np.shape(out2)
    keep_row = np.zeros(n1, dtype = bool)
    network_eventlist = list()
    tmp_neventlist = list()
    for i in range(n1-1):
        if np.any((out2[i,:] == out2[i+1,:]) & (~np.isnan(out2[i,:]))):  #/ if match or nan
            out2[i+1,:] = np.nanmin((out2[i,:], out2[i+1,:]),axis=0) #/ fill in nans
            tmp_neventlist.append(netids2[i])
        else:
            keep_row[i] = True
            tmp_neventlist.append(netids2[i]) #/ network id
            network_eventlist.append(tmp_neventlist)
            tmp_neventlist = list()
        if i == n1-2: #/ add final event
            keep_row[i+1] = True
            tmp_neventlist.append(netids2[i+1])
            network_eventlist.append(tmp_neventlist) 
            tmp_neventlist = list()
    out2 = out2[keep_row,:]   
    netids2 = network_eventlist 

def list_flatten(S):
    if S == []:
        return S
    if isinstance(S[0], list):
        return flatten(S[0]) + flatten(S[1:])
    return S[:1] + flatten(S[1:])

netids2 = [list_flatten(x) for x in netids2]    #/ to check if any missing

nfinal, n2 = np.shape(out2)
tmp = np.nanargmin(out2,axis=1)
row_sort = np.argsort( out2[np.arange(0, nfinal),tmp] )
final_eventlist = out2[row_sort,:]   
network_eventlist = [ netids2[k] for k in row_sort]

########################################################################################

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

#########################################################################
##                        SAVES RESULTS                                ##
#########################################################################

final_eventstats_str = ['max_duration',
                        'number of event pairs (network)', 
                        'number of event pairs (station)', 
                        'total fingerprint pairs (summed over all event/network pairs)', 
                        'maximum fingerprints pairs for any event-pair (summed over network)',
                        'total similarity of all fingerprint pairs (summed over all event/network pairs)',
                        'maximum similarity of all fingerprint pairs for any-event pair (summed over network)'
                        'maximum peak similarity for any event-pair(summed over network)']   
                        
                            
final_eventstats_header = ['dL', 'nevents', 'nsta', 'tot_ndets', 'max_ndets', 'tot_vol', 'max_vol', 'max_peaksum']


#/ save to text file

np.savetxt(save_str + '_detlist.txt', np.concatenate( (final_eventlist,final_eventstats), axis = 1), fmt='%12.0f', delimiter=' ', newline='\n', header=('    ').join(channel_vars) + '          ' + ('      ').join(final_eventstats_header) )

#/ rank by number of event pairs
rank_by_nevents = np.argsort(final_eventstats[:,1])[::-1]
np.savetxt(save_str + '_detlist_rank_by_nevents.txt', np.concatenate( (final_eventlist[rank_by_nevents,:],final_eventstats[rank_by_nevents,:]), axis = 1), fmt='%12.0f', delimiter=' ', newline='\n', header=('    ').join(channel_vars) + '          ' + ('      ').join(final_eventstats_header) )

#/ rank by detection strength (peaksum)
rank_by_peaksum = np.argsort(final_eventstats[:,7])[::-1]
np.savetxt(save_str + '_detlist_rank_by_peaksum.txt', np.concatenate( (final_eventlist[rank_by_peaksum,:],final_eventstats[rank_by_peaksum,:]), axis = 1), fmt='%12.0f', delimiter=' ', newline='\n', header=('    ').join(channel_vars) + '          ' + ('      ').join(final_eventstats_header) )

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
mdict['nfp'] = nfp       #ok
mdict['dt_minval'] = q1  #ok
mdict['dt_maxval'] = q2  #ok
mdict['ivals_thresh'] = ivals_thresh #ok
mdict['min_dets'] = min_dets         #ok
mdict['min_sum'] = min_sum           #ok
mdict['max_width'] = max_width       #ok
mdict['nsta_thresh'] = nsta_thresh   #ok
mdict['network_events'] = network_events  #ok

with open(save_str + '.dat', "wb") as f:
    pickle.dump(mdict, f)

print('GRAND TOTAL TIME:', time.time() - grand_start_time)

