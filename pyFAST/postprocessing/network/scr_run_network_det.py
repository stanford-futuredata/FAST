######################################################################### 
##                NETWORK DETECTION                                    ##
######################################################################### 

######################################################################### 
##             loads necessary libraries                               ##
######################################################################### 

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
from pseudo_association import *
from IPython import embed

file_parallel = False
parallel = True


#########################################################################
##            Network detection - data & parameters                    ##
#########################################################################

data_folder = './9days_sorted/'
save_str = './results/network_detection'

#channel_vars = ['GVZ_HHZ', 'KHZ_HHZ', 'LTZ_HHZ']
#detdata_filenames = ['9days_NZ_GVZ_HHZ.txt', '9days_NZ_KHZ_HHZ.txt', '9days_NZ_LTZ_HHZ.txt']

channel_vars = ['KHZ', 'GVZ', 'LTZ', 'MQZ', 'OXZ', 'THZ']
detdata_filenames = ['KHZ_sorted_total.txt', 'GVZ_sorted_total.txt', 'LTZ_sorted_total.txt', 
    'MQZ_sorted_total.txt', 'OXZ_sorted_total.txt', 'THZ_sorted_total.txt']

# channel_vars = ['KHZ_HHZ', 'GVZ_HHZ', 'LTZ_HHZ', 'MQZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
# detdata_filenames = ['KHZ_total.txt', 'GVZ_total.txt', 'LTZ_total.txt', 'MQZ_total.txt', 'OXZ_total.txt', 'THZ_total.txt']

#channel_vars = ['KHZ_HHZ', 'MQZ_HHZ', 'OXZ_HHZ', 'THZ_HHZ']
#detdata_filenames = ['KHZ-HHZ-10,11-104_pairs.txt', 'MQZ-HHZ-10,11-104_pairs.txt', 'OXZ-HHZ-10,11-104_pairs.txt', 'THZ-HHZ-10,11-104_pairs.txt']

nchannels = len(channel_vars)
nstations = len(channel_vars)
max_fp    = 17 * 86400  #/ largest fingperprint index  (was 'nfp')
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
nsta_thresh = 3

# number of cores for parallelism
num_cores = min(multiprocessing.cpu_count(), 24)


######################################################################### 
##                      Helper functions                               ##
#########################################################################

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

def get_det_list(ndets, timestamp_to_netid):
    det_start = np.where((ndets[:-1] == 0) & (ndets[1:] > 0))[0] + 1
    det_end   = np.where((ndets[:-1] > 0) & (ndets[1:] == 0))[0] + 1
    det_dt    = det_end - det_start
    det_connect  = list()
    for x, y in izip(det_start, det_dt):
        tmp = list()
        for z in xrange(x,x+y+1):
            [tmp.append(q) for q in timestamp_to_netid[z]]
        det_connect.append(sorted(list(set(tmp))))
    return det_start, det_dt, det_connect

######################################################################### 
##                  Event-pair detection functions                     ##
#########################################################################  

def detection_init(l):
    global lock, process_counter
    lock = l
    process_counter = multiprocessing.Value('i', 0)

def detection(file):
    global process_counter
    with process_counter.get_lock():
        process_counter.value += 1
    start = time.time()
    pid = os.getpid()
    clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)
    # get events - create hashtable
    diags = clouds.p_triplet_to_diags(file, pid_prefix = str(pid + process_counter.value * 1000), 
            ivals_thresh = ivals_thresh, lock = lock)
    #/ extract event-pair clouds
    curr_event_dict = clouds.diags_to_event_list(diags, npass = 3, lock = lock)
    diags = None
    #/ prune event-pairs
    prune_events(curr_event_dict, min_dets, min_sum, max_width)
    print '    Time taken for %s:' % file, time.time() - start
    return curr_event_dict

def process(cidx):
    print detdata_filenames[cidx]
    print '  Extracting event-pair clouds ...'
    t0 = time.time()
    l = multiprocessing.Lock()
    pool = multiprocessing.Pool(num_cores, initializer=detection_init, initargs=(l,))
    files = [data_folder + f for f in os.listdir("./9days_sorted/") if f.startswith(detdata_filenames[cidx].split('.')[0])]
    event_dicts = pool.map(detection, files)
    pool.terminate()
    result_dict = {}
    for dictionary in event_dicts:
        result_dict.update(dictionary)
    print time.time()
    print '  total time for %s:' % (detdata_filenames[cidx]), time.time() - t0
    return result_dict

# # # #########################################################################
# # # ##                  Event-pair detection                               ##
# # # #########################################################################

if parallel:
    print('PARALLEL')
else:
    print('NON PARALLEL')
if file_parallel:
    print('FILE-PARALLEL')
else:
    print('NON FILE-PARALLEL')

grand_start_time = time.time()

event_dict = dict(izip(xrange(len(channel_vars)), map(process, [cidx for cidx in xrange(len(channel_vars))])))

print "Saving event_dict to event_dict.dat"
with open('event_dict.dat', "wb") as f:
     pickle.dump(event_dict, f)

# # # #########################################################################
# # # ##                         Network detection                           ##
# # # ##         (NOTE: updated to include adjacent diagonal hashes)         ##
# # # #########################################################################

print 'Extracting network events...'

associator =  NetworkAssociator()

#/ map events to diagonals
t4 = time.time()
all_diags_dict, dcount = associator.clouds_to_network_diags(event_dict, event_dict_keys = range(0,nstations), include_stats = True)
print ' time to build network index:', time.time() - t4

#/ pseudo-association
t5 = time.time()
print 'Performing network pseudo-association...'
icount, network_events = associator.associate_network_diags(all_diags_dict, nstations = nstations, offset = 20, include_stats = True)
print ' time pseudo-association:', time.time() - t5


#########################################################################
##         EVENT RESOLUTION - detections                              ##
#########################################################################
print "Saving network event to network_event.dat"
with open('network_event.dat', "wb") as f:
    pickle.dump(network_events, f)

networkID = network_events.keys()
timestamp_to_netid = dict()
for i in xrange(nstations):
    timestamp_to_netid[i] = defaultdict(list) #/ keeps track of which network eventIDs are observed at each time

for nid in networkID:
    net_event = network_events[nid]
    if len(np.unique([ x[1] for x in net_event])) >= nsta_thresh: #/ number of unique stations - THIS IS DATASET/TASK SPECIFIC (criteria does not even have to be related to station count)
        stid  = [x[1] for x in net_event]
        t1min = [x[0][2] for x in net_event]
        t1max = [x[0][3] for x in net_event]
        t2min = [x[0][2] - x[0][0] for x in net_event]
        t2max = [x[0][3] - x[0][0] for x in net_event]
        for stid0, t1a, t1b, t2a, t2b in izip(stid, t1min, t1max, t2min, t2max):
            for t in xrange(t1a, t1b + 1):
                timestamp_to_netid[stid0][t].append(nid)
            for t in xrange(t2a, t2b + 1):
                timestamp_to_netid[stid0][t].append(nid)

#/ counts number of detections for each time interval (for each station)
nfp = max_fp
network_events_final = defaultdict(lambda: defaultdict(list))
for stid in xrange(nstations):
    ndets = np.zeros(nfp)
    for fpid in timestamp_to_netid[stid]:
        ndets[fpid] = len( timestamp_to_netid[stid][fpid])
    #/ map detection pairs to event times (i.e. resolve events for each station separately)
    det_data = get_det_list(ndets, timestamp_to_netid[stid]) #/ gets list of detections - may need to be updated depending on dataset

    #/ map back to network_events_final (i.e. assign detections at each station to the corresponding "network detection"
    for j in xrange(len(det_data[0])):
        for nid in det_data[2][j]:
            network_events_final[nid][stid].append(det_data[0][j])

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
    for stid in xrange(nstations):
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

for sta in xrange(nstations):
    row_sort0 = np.argsort( out2[:,sta] )
    out2      = out2[row_sort0,:]
    netids2   = [ netids2[x] for x in row_sort0]
    n1, n2 = np.shape(out2)
    keep_row = np.zeros(n1, dtype = bool)
    network_eventlist = list()
    tmp_neventlist = list()
    for i in xrange(n1-1):
        if np.all((out2[i,:] == out2[i+1,:]) | np.isnan(out2[i,:]) | np.isnan(out2[i+1,:] ) ) & np.any(out2[i,:] == out2[i+1,:]):  #/ if match or nan
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

print 'GRAND TOTAL TIME:', time.time() - grand_start_time
