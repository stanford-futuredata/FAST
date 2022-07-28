# **Output**  

## Network Detection Outputs  

* Event resolution: final step after pseudo-association
    * Pairs of similar fingerprints --> list of event detections  
* Network Detection Output (text file with labeled columns)
    * Example (ranked in descending order of ‘peaksum’): `7sta_2stathresh_detlist_rank_by_peaksum.txt`  
    * First (num_sta = number of stations) columns: starting fingerprint index at each station (time information) 
        *  Outputs “nan” if not observed at a particular station
    * `dL`: Maximum length (samples) along diagonal, overall event-pairs containing this event  
    * `nevents`: Number of other events ‘linked’ to (similar to) this event  
    * `nsta`: Number of stations over which other events are similar to this event  
    * `tot_ndets`: Total number of fingerprint-pairs (pixels) containing this event, overall event-pair clusters, over all stations  
    * `max_ndets`: Maximum number of fingerprint-pairs (pixels) containing this event, over all event-pair clusters, over all stations
    * `tot_vol`: Totalsum (or ‘volume’ )of all similarity values (added overall stations), over all event-pairs containing this event  
    * `max_vol`: Maximum sum (or ‘volume’) of all similarity values (added overall stations), over all event-pairs containing this event  
    * `max_peaksum`: Maximum similarity value (added overall stations), overall event-pairs containing this event  