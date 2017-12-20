import numpy as np
import time
from collections import defaultdict
from itertools import izip, count

######################################################################### 
##               functions                                            ##
######################################################################### 

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

class EventCloudExtractor:
    def __init__(self, dL, dW):
      self.dL     = dL
      self.dW     = dW

    def _assign_event_id(self, elems, eventID, dL, pid_prefix):
        elems[0][2] = '%s-%d' % (pid_prefix, eventID)
        if len(elems) >= 2:
            for j in xrange(1, len(elems)):
                if elems[j][0] - elems[j - 1][0] > dL:
                    eventID += 1
                elems[j][2] = '%s-%d' % (pid_prefix, eventID)
        return elems, eventID

    def p_triplet_to_diags(self, fname, byte_pos, bytes_to_read, pid_prefix = None,
                           dL = None, dt_min = 0, dt_max = None, ivals_thresh = 0):
        if dt_max is None:
            dt_max = float('inf')
        if dL is None:
            dL = self.dL
        #/ map data to diagonals
        t1 = time.time()
        diags = defaultdict(list) #/ initialize hash table

        eventID = 0
        prev_key = None
        elems = []
        with open(fname, 'r') as f:
            f.seek(byte_pos)
            lines = f.read(bytes_to_read).strip().split('\n')
            for line in lines:
                tmp = line.split() # no need to strip() since that's already done above
                ivals = int(tmp[2])
                if ivals < ivals_thresh:
                    continue
                dt = int(tmp[0])
                idx2 = int(tmp[1])
                idx1 = idx2 - dt

                if dt != prev_key:
                    if len(elems) > 0:
                        assigned_elems, assigned_eventID = self._assign_event_id(
                            elems, eventID, dL, pid_prefix)
                        diags[prev_key] = assigned_elems
                        elems = []
                        eventID = assigned_eventID + 1
                    prev_key = dt
                elems.append([idx1, ivals, None])

        if len(elems) > 0:
            assigned_elems, assigned_eventID = self._assign_event_id(
                elems, eventID, dL, pid_prefix)
            diags[prev_key] = assigned_elems

        return diags

    def diags_to_event_list(self, diags, dt_min = None, dt_max = None, npass = 2):
        if dt_min is None or dt_max is None: # non parallel case
            dt_min = min(diags.keys())
            dt_max = max(diags.keys())
        else:
            dt_min = pairs[dt_min]
            dt_max = pairs[dt_max]
        for p in xrange(npass):
            if p % 2 == 0: #/ forward pass
                t0 = time.time()
                for qidx in xrange(dt_min, dt_max):
                    diags[qidx], diags[qidx+1] = self.merge_diags(diags[qidx], diags[qidx+1], self.dW)
            else: #/ backward pass
                t0 = time.time()
                for qidx in xrange(dt_max-1, dt_min-1, -1):
                    diags[qidx+1], diags[qidx] = self.merge_diags(diags[qidx+1], diags[qidx], self.dW)
        event_dict = defaultdict(list)
        for k in diags:
            for t1, sim, eventid in diags[k]:
                event_dict[eventid].append([k,t1,sim])
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
                    for ridx0 in xrange(first_idx0[i], last_idx0[i] + 1):
                        diag0[ridx0][2] = newEventID
                    for ridx1 in xrange(first_idx1[j], last_idx1[j] + 1):
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

    def clouds_to_network_diags_one_channel(self, event_dict, cidx):
        diags_dict = defaultdict(list)
        for k in event_dict:
            ddiag, bbox = self._get_ddiag_bbox(event_dict[k])
            event_stats = self._get_event_stats(event_dict[k])
            diags_dict[ddiag].append([bbox, cidx, k, None, event_stats])  #/ boundingBox, stationID, diagonalKey, networkEventID, event_stats : (ndets , vol (sum_sim), peak_sim)
        return diags_dict

    def associate_network_diags(self, all_diags, nstations, offset):
        p = 2 * nstations
        icount = self.icount
        diags = all_diags[:, 0]
        q1 = min(diags)
        q2 = max(diags) + 1
        slicing_points = list(np.where(np.diff(diags) > 0)[0])
        map_to_indices = {}
        prev_idx = -1
        for idx in slicing_points:
            map_to_indices[diags[idx]] = range(prev_idx + 1, idx + 1)
            prev_idx = idx
        map_to_indices[diags[-1]] = range(prev_idx + 1, len(diags))
        network_events = defaultdict(list)
        for k in xrange(q1, q2):
            if k in map_to_indices:
                k_indices = map_to_indices[k]
                diags_k = all_diags[k_indices]
            else:
                k_indices = []
                diags_k = np.zeros([0, 11], dtype=np.int32)
            if k + 1 in map_to_indices:
                kp1_indices = map_to_indices[k + 1]
                diags_kp1 = all_diags[kp1_indices]
            else:
                kp1_indices = []
                diags_kp1 = np.zeros([0, 11], dtype=np.int32)
            #/ from this diagonal
            t_init_k0 = list(diags_k[:, 3])    #/ initial time of each bbox along diag k
            t_end_k0  = list(diags_k[:, 4])   #/ end time of each bbox along diag k
            eid_k0    = list(diags_k[:, 7])       #/ network eventID
            stid_k0   = list(diags_k[:, 5])       #/ stationID
            t_init_k1 = list(diags_kp1[:, 3])  #/ initial time of each bbox along diag k
            t_end_k1  = list(diags_kp1[:, 4])  #/ end time of each bbox along diag k
            eid_k1    = list(diags_kp1[:, 7])     #/ network eventID
            stid_k1   = list(diags_kp1[:, 5])     #/ stationID

            if len(t_init_k0 + t_init_k1) >= 1:
                #/ bookkeeping
                kidx  = [0 for x in diags_k] + [1 for x in diags_kp1]                               #/ which diagonal hash does this event belong to
                oidx = [z for z, x in enumerate(diags_k)] + [z for z, x in enumerate(diags_kp1)]  #/ index of event within diagonal hash
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
                                    tmpid = [q for q in elist if q >= 0]
                                    if len(tmpid) > 0:  # (case of 2+ pre-existing event labels)
                                        tmpid = min(tmpid)
                                    else: #/ if event already has label (case of 1 pre-existing event label) NOTE: weird numbering issue without elif
                                        tmpid = icount
                                        icount += 1
                                    for q in glist:
                                        eid[q] = tmpid

                for tmpidx, tmpk, tmpeid in izip(oidx, kidx, eid): #/
                    if tmpk == 0:
                        all_diags[k_indices[0] + tmpidx][7] = tmpeid
                        #all_diags_dict[k][tmpidx][3] = tmpeid
                    else:
                        all_diags[kp1_indices[0] + tmpidx][7] = tmpeid
                        #all_diags_dict[k+1][tmpidx][3] = tmpeid

        #/ compiles list of events detected on multiple stations
        network_events = defaultdict(list)
        for k in xrange(q1, q2):
            if k in map_to_indices:
                diags_k = all_diags[map_to_indices[k]]
            else:
                diags_k = []
            for eventcloud in diags_k:
                if eventcloud[7] >= 0:
                    network_events[ eventcloud[7] ].append( ((k, k, eventcloud[3], eventcloud[4]),
                        eventcloud[5], eventcloud[6], (eventcloud[8], eventcloud[9], eventcloud[10])) )

        self.icount = icount
        return icount, network_events

    def _get_ddiag_bbox(self, event_data):
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
        #/ compute bounding box
        t1list  = [x[1] for x in event_data]
        t1min   = min(t1list)
        t1max   = max(t1list)
        bbox    = (dtmin, dtmax, t1min, t1max)
        return ddiag, bbox

    def _get_event_stats(self, event_data):
        tmp = [x[2] for x in event_data]
        return ( len(event_data) , sum(tmp), max(tmp) )
