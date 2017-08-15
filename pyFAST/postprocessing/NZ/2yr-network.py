#########################################################################
##                NETWORK DETECTION - Iquique 17 days                  ##
#########################################################################

#########################################################################
##             loads necessary libraries                               ##
#########################################################################

import pickle
import h5py
import time
import numpy as np
from collections import defaultdict
from itertools import izip, count, islice

from pseudo_association import diag_coordsV, prune_events, EventCloudExtractor, NetworkAssociator


#########################################################################
##            Network detection - data & parameters                    ##
#########################################################################

# data_folder = '/Users/Kari/Documents/Python/Seismology/network_detection/Iquique/from_cees/search/'
# save_str    = 'results/network_detection-min4sta_AlltoSome_MADK400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_04B'

# channel_vars = ['PATCX..BHZ', 'PSGCX..BHZ', 'PB01..BHZ', 'PB08..BHZ', 'PB11..BHZ']
# detdata_filenames = ['detdata_AlltoSome_MAD_K400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_CX.PATCX..BHZ_2to8_prefilter.hdf5',
#                      'detdata_AlltoSome_MAD_K400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_CX.PSGCX..BHZ_2to8_prefilter.hdf5',
#                      'detdata_AlltoSome_MAD_K400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_CX.PB01..BHZ_1to8_prefilter.hdf5',
#                      'detdata_AlltoSome_MAD_K400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_CX.PB08..BHZ_2to8_prefilter.hdf5',
#                      'detdata_AlltoSome_MAD_K400_nvotes3_nfuncs5_ntbls100_2014-03-15_17days_CX.PB11..BHZ_2to8_prefilter.hdf5']

data_folder = './8-2/'
save_str = './results/network_detection'

# channel_vars = ['GVZ_HHZ', 'GVZ_HHN', 'GVZ_HHE',
#     'KHZ_HHZ', 'KHZ_HHN', 'KHZ_HHE',
#     'LTZ_HHZ', 'LTZ_HHN', 'LTZ_HHE',
#     'THZ_HHZ', 'THZ_HHN', 'THZ_HHE',
#     'OXZ_HHZ', 'OXZ_HHN', 'OXZ_HHE',
#     'MQZ_HHZ', 'MQZ_HHN', 'MQZ_HHE']
# detdata_filenames = ['GVZ_HHZ_pairs.txt', 'GVZ_HHN_pairs.txt', 'GVZ_HHE_pairs.txt',
#     'KHZ_HHZ_pairs.txt', 'KHZ_HHN_pairs.txt', 'KHZ_HHE_pairs.txt',
#     'LTZ_HHZ_pairs.txt', 'LTZ_HHN_pairs.txt', 'LTZ_HHE_pairs.txt',
#     'THZ_HHZ_pairs.txt', 'THZ_HHN_pairs.txt', 'THZ_HHE_pairs.txt',
#     'OXZ_HHZ_pairs.txt', 'OXZ_HHN_pairs.txt', 'OXZ_HHE_pairs.txt',
#     'MQZ_HHZ_pairs.txt', 'MQZ_HHN_pairs.txt', 'MQZ_HHE_pairs.txt']

channel_vars = ['KHZ', 'MQZ', 'OXZ', 'THZ']#, 'LTZ']

detdata_filenames = ['KHZ-HHZ-10,11-82_pairs.txt', 'MQZ-HHZ-10,11-82_pairs.txt', 'OXZ-HHZ-10,11-82_pairs.txt',
    'THZ-HHZ-10,11-82_pairs.txt']#, 'LTZ-HHZ-10,11-104_pairs.txt']

nchannels = 1
nstations = 4
max_fp    = 31535995  #/ largest fingperprint index  (was 'nfp')
dt_fp     = 1.0      #/ time lag between fingerprints
dgapL     = 15       #/ = 30  #/ largest gap between detections along a single diagonal
dgapW     = 3        #/ largest gap between detections adjacent diagonals
ivals_thresh = 2

#/ specifies which chunck of data (dt range) to process
q1 = 30
q2 = 86400

# only detections within 24 of each other
min_dets = 5
min_sum  = 6*min_dets
max_width = 8

#/ number of station detections to be included in event list
nsta_thresh = 2

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

# #/ flatten list of lists
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

# #########################################################################
# ##                  Event-pair detection                               ##
# #########################################################################

clouds = EventCloudExtractor(dL = dgapL, dW = dgapW)
event_dict = dict((x, {}) for x in channel_vars)

for cidx, channel in enumerate(channel_vars):

    print detdata_filenames[cidx]
    print '  Extracting event-pair clouds ...'

    # loads data, converts to (int_idx1, int_dt2 > 0, int_value) format (mapper)
    t0 = time.time()
    load_file = data_folder + detdata_filenames[cidx]
    # f = h5py.File(load_file,  "r")
    idx1 = []
    idx2 = []
    ivals = []
    with open(load_file, 'r') as f:
        for index, line in enumerate(f):
            data = line.strip().split(' ')
            idx1.append(int(data[1]))
            idx2.append(int(data[0]))
            ivals.append(int(data[2]))
    # idx1  = f['pair_i'].value.flatten() #/ idx1 is 1-dimensional array containing first time index in detection pair
    # idx2  = f['pair_j'].value.flatten() #/ idx2 is 1-dimensional array containing second time index in detection pair
    # ivals = f['pair_k'].value.flatten() #/ ivals is 1-dimensional array containing similarity value of detection pair, converted to integer value
    # f.close()
    dt, _ = diag_coordsV(idx1,idx2)
    print '    time to load data: ' + str( time.time() - t0)
    print '    number of detection pairs (total): ' + str( len(idx1) )
    #print '    number of detection pairs (this batch): ' + str( sum((dt >= q1) & (dt <= q2)) )
    print '    number of detection pairs (this batch): ' + str(sum(dt))

    # get events - create hashtable
    t1 = time.time()
    #diags, max_eventID = clouds.triplet_to_diags(dt, idx1, ivals, dt_min = q1, dt_max = q2, ivals_thresh = ivals_thresh, min_eventID = 0)
    diags, max_eventID = clouds.triplet_to_diags(dt, idx1, ivals, ivals_thresh = ivals_thresh, min_eventID = 0)
    print '    time triplet_to_diags: ' + str( time.time() - t1)
    dt = None
    idx1 = None
    ivals = None

    #/ extract event-pair clouds
    t2 = time.time()
    #event_dict[cidx] = clouds.diags_to_event_list(diags, dt_min = q1, dt_max = q2,  npass = 3)
    event_dict[cidx] = clouds.diags_to_event_list(diags, npass = 3)
    diags = None
    print '    time diags_to_event_list: ' + str( time.time() - t2)

    #/ prune event-pairs
    t3= time.time()
    prune_events(event_dict[cidx], min_dets, min_sum, max_width)
    print '    time prune_events: ' + str( time.time() - t3)
    print '  total time: ' + str( time.time() - t0)

    with open(save_str + '_%s' % cidx, "wb") as f:
        pickle.dump(event_dict[cidx], f)


# #########################################################################
# ##                         Network detection                           ##
# ##         (NOTE: updated to include adjacent diagonal hashes)         ##
# #########################################################################

print 'Extracting network events...'

associator =  NetworkAssociator()

#/ map events to diagonals
t4 = time.time()
all_diags_dict, dcount = associator.clouds_to_network_diags(event_dict, event_dict_keys = range(0,nstations), include_stats = True)
print ' time to build network index: ' + str( time.time() - t4)

#/ pseudo-association
t5 = time.time()
print 'Performing network pseudo-association...'
#icount, network_events = associator.associate_network_diags(all_diags_dict, nstations = 3, offset = 20, q1 = q1, q2 = q2, include_stats = True)
icount, network_events = associator.associate_network_diags(all_diags_dict, nstations = nstations, offset = 20, include_stats = True)
print ' time pseudo-association: ' + str( time.time() - t5)

with open(save_str + '_events.dat', "wb") as f:
    pickle.dump(network_events, f)

# network_events = pickle.load(open(save_str + '_events.dat', 'rb'))
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
                try:
                    timestamp_to_netid[stid0][t].append(nid)
                except:
                    print stid0, t, nid
            for t in range(t2a,t2b+1):
                try:
                    timestamp_to_netid[stid0][t].append(nid)
                except:
                    print stid0, t, nid

#/ counts number of detections for each time interval (for each station)
nfp = max_fp
ndets = np.zeros((nstations, nfp))
for stid in range(nstations):
    for fpid in timestamp_to_netid[stid].keys():
        ndets[stid,fpid] = len( timestamp_to_netid[stid][fpid] )

#/ map detection pairs to event times (i.e. resolve events for each station separately)
det0_start, det0_dL, det0_connect = get_det_list(ndets[0,:], timestamp_to_netid[0])   #/ gets list of detections - may need to be updated depending on dataset
det1_start, det1_dL, det1_connect = get_det_list(ndets[1,:], timestamp_to_netid[1])
det2_start, det2_dL, det2_connect = get_det_list(ndets[2,:], timestamp_to_netid[2])
det3_start, det3_dL, det3_connect = get_det_list(ndets[3,:], timestamp_to_netid[3])
#det4_start, det4_dL, det4_connect = get_det_list(ndets[4,:], timestamp_to_netid[4])
#det5_start, det5_dL, det5_connect = get_det_list(ndets[5,:], timestamp_to_netid[5])

#/ map back to network_events_final (i.e. assign detections at each station to the corresponding "network detection"
network_events_final = defaultdict(lambda: defaultdict(list))
#/ print
for x,y,z in izip(det0_start, det0_dL, det0_connect):
    #print 0, x, y, z
    for nid in z:
        network_events_final[nid][0].append(x)
for x,y,z in izip(det1_start, det1_dL, det1_connect):
    #print 1, x, y, z
    for nid in z:
        network_events_final[nid][1].append(x)
for x,y,z in izip(det2_start, det2_dL, det2_connect):
    #print 2, x, y, z
    for nid in z:
        network_events_final[nid][2].append(x)
for x,y,z in izip(det3_start, det3_dL, det3_connect):
    #print 3, x, y, z
    for nid in z:
        network_events_final[nid][3].append(x)
# for x,y,z in izip(det4_start, det4_dL, det4_connect):
#     #print 4, x, y, z
#     for nid in z:
#         network_events_final[nid][4].append(x)
# for x,y,z in izip(det5_start, det5_dL, det5_connect):
#     #print 5, x, y, z
#     for nid in z:
#         network_events_final[nid][5].append(x)
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
        if np.all((out2[i,:]  == out2[i+1,:]) | np.isnan(out2[i,:]) | np.isnan(out2[i+1,:])) & np.any(out2[i,:] == out2[i+1,:]):  #/ if match or nan
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




