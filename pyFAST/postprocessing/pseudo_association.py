import numpy as np
import time
from collections import defaultdict
from itertools import izip, count

######################################################################### 
##               functions                                            ##
######################################################################### 
    
def diag_coordsV(t1, t2):
    # for case where t1, t2 are vectors
    return np.subtract(t2, t1), np.add(t1, t2)

def prune_events(event_dict, min_dets = 0, min_sum = 0, max_width = None):
    for k in event_dict.keys():
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
      
    def triplet_to_diags(self, dt, idx1, ivals, dL = None, dt_min = 0, dt_max = None, ivals_thresh = 0, min_eventID = 0):
        if dt_max is None:
            dt_max = float("inf")   
        if dL is None:
            dL = self.dL                           
        #/ map data to diagonals 
        t1 = time.time()
        diags = defaultdict(list) #/ initialize hash table        
        for i, dtval in izip( count(), dt):                                 
            if dtval >= dt_min and dtval <=dt_max and ivals[i] >= ivals_thresh:               
                diags[dtval].append([idx1[i], ivals[i], None]) 
        print '    time to create hash table (key = dt): ' + str( time.time() - t1)       
        #/ sort data in diagonals - set initial event_IDs
        t2 = time.time()
        event_ID = min_eventID
        for kidx, k in enumerate(diags.keys()):
        #for k in range(nfp):
            if diags[k]:
                diags[k].sort(key=lambda x: x[0])             
                diags[k][0][2] = event_ID
                if len(diags[k]) >= 2:
                    for iidx, x1, x0 in izip(count(), diags[k][1:], diags[k][:-1]):  #/ assign detections to same event_ID if timestamps are within <dgapL> of each other
                        if x1[0]  - x0[0] > dL:
                            event_ID += 1
                        x1[2] = event_ID    
                event_ID += 1   
        print '    time to sort diagonals and set initial event IDs: ' + str( time.time() - t2)       
        return diags, event_ID           
                                  
    def diags_to_event_list(self, diags, dt_min, dt_max, npass = 3):
        t1 = time.time()
        for p in range(npass):
            if p % 2 == 0:  #/ forward pass
                t0 = time.time()
                for qidx in range(dt_min, dt_max):       
                    diags[qidx], diags[qidx+1] = self.merge_diags(diags[qidx], diags[qidx+1], self.dW)              
                print '      pass ' + str(p) + ': ' + str( time.time() - t0)  
            else:  #/ backward pass
                t0 = time.time()
                for qidx in range(dt_max-1, dt_min-1, -1):    
                    diags[qidx+1], diags[qidx] = self.merge_diags(diags[qidx+1], diags[qidx], self.dW)              
                print '      pass ' + str(p) + ': ' + str( time.time() - t0)                                 
        t0 = time.time()
        event_dict = defaultdict(list)
        for k in range(dt_min, dt_max+1):
            if diags[k]:
                for t1, sim, eventid in diags[k]:
                    event_dict[eventid].append([k,t1,sim])
        print '    populating event hash table ' + str( time.time() - t0) 
        #print '(total) diags to event list ' + str( time.time() - t1) 
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
                if event_dict[channel][k]:
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
                        dt1 = t_init[j+1:j+p] - t1
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
