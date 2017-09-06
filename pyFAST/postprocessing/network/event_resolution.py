import numpy as np
from collections import defaultdict
try:
    from itertools import izip
except ImportError:
    izip = zip

######################################################################### 
##                      Helper functions                               ##
#########################################################################

def _get_det_list(ndets, timestamp_to_netid):
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

#/ flatten list of lists
def flatten(items, seqtypes=(list, tuple)):
    for i, x in enumerate(items):
        while i < len(items) and isinstance(items[i], seqtypes):
            items[i:i+1] = items[i]
    return items

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

#########################################################################

def prune_network_events(network_events, nsta_thresh):
    '''
    eliminates network events based on station threshold criterion
    '''
    networkID = network_events.keys()
    for nid in networkID:
        if len(np.unique([ x[1] for x in network_events[nid]])) < nsta_thresh:
            del network_events[nid]


#########################################################################

'''
In this version <ndets> is updated to contain a binary variable indicating whether
each time stamp is included in some event-pair, rather than a count of the number
of event-pairs. <timestamp_to_netids> has been updated so that each ID is assigned 
to only two time stamps (the initial time stamp for each event in the pair),
rather than for every timestamp associated with the event-pair
'''
def get_network_events_final(network_events, max_fp, nstations, nsta_thresh):
    networkID = network_events.keys()
    timestamp_to_netid = dict()
    for i in xrange(nstations):
        timestamp_to_netid[i] = defaultdict(list) #/ keeps track of which network eventIDs are observed at each time

    ndets = np.zeros((nstations, max_fp),dtype=bool)

    for nid in networkID:
        net_event = network_events[nid]
        if len(np.unique([ x[1] for x in net_event])) >= nsta_thresh: #/ number of unique stations - THIS IS DATASET/TASK SPECIFIC (criteria does not even have to be related to station count)
            stid  = [x[1] for x in net_event]
            t1min = [x[0][2] for x in net_event]
            t1max = [x[0][3] for x in net_event]
            t2min = [x[0][2] + x[0][0] for x in net_event]
            t2max = [x[0][3] + x[0][0] for x in net_event]
            for stid0, t1a, t1b, t2a, t2b in izip(stid, t1min, t1max, t2min, t2max):
                ndets[stid0][t1a:(t1b+1)] = True
                ndets[stid0][t2a:(t2b+1)] = True
                timestamp_to_netid[stid0][t1a].append(nid)
                timestamp_to_netid[stid0][t2a].append(nid)

    #/ counts number of detections for each time interval (for each station)
    network_events_final = defaultdict(lambda: defaultdict(list))
    for stid in xrange(nstations):
         det_data = _get_det_list(ndets[stid,:], timestamp_to_netid[stid]) #/ gets list of detections - may need to be updated depending on dataset
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

    return network_events_final

#########################################################################

'''
In this version <ndets> is updated to contain a binary variable indicating whether each
time stamp is included in some event-pair, rather than a count of the number of event-pairs.
<timestamp_to_netids> has been updated so that only each ID is assigned to only two time
stamps (the initial time stamp for each event in the pair), rather than for every timestamp
associated with the event-pair.
----
To further reduce size of <ndets> and  <timestamp_to_netids> for networks with large number
of stations, events are resolved separately for each station (within for-loop)
---
Additionally, instead of condition for inclusion embedded within event-resolution loop,
a separate function call removes network events that will not be included in final detection
list to improve modularity of post-processing
'''
def get_network_events_final_by_station(network_events, max_fp, nstations, nsta_thresh):
    prune_network_events(network_events, nsta_thresh)

    networkID = network_events.keys()
    network_events_final = defaultdict(lambda: defaultdict(list))

    for stid in xrange(nstations):
        timestamp_to_netid= defaultdict(list) #/ keeps track of which network eventIDs are observed at each time
        ndets = np.zeros(max_fp,dtype=bool)
        for nid in networkID:
            net_event = network_events[nid]
            tmpstid  = [x[1] for x in net_event]
            t1min = [x[0][2] for x in net_event]
            t1max = [x[0][3] for x in net_event]
            t2min = [x[0][2] + x[0][0] for x in net_event]
            t2max = [x[0][3] + x[0][0] for x in net_event]
            for stid0, t1a, t1b, t2a, t2b in izip(tmpstid, t1min, t1max, t2min, t2max):
                if stid0 == stid:
                    ndets[t1a:(t1b+1)] = True
                    ndets[t2a:(t2b+1)] = True
                    timestamp_to_netid[t1a].append(nid)
                    timestamp_to_netid[t2a].append(nid)

        #/ counts number of detections for each time interval (for each station)
        det_data = _get_det_list(ndets, timestamp_to_netid) #/ gets list of detections - may need to be updated depending on dataset
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

    return network_events_final

########################################################################################

def event_to_list_and_dedup(network_events_final, nstations):
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

    return final_eventlist, network_eventlist, nfinal


#########################################################################
##                        SAVES RESULTS                                ##
#########################################################################
def output_results(final_eventlist, final_eventstats, save_str, channel_vars):
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

    return final_eventstats_str
