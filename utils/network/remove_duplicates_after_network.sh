#!/bin/bash

# ---------------------------------------------------INPUTS --------------------------------------------
cd ../../data/network_detection/
NETWORK_FILE=NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt
# ---------------------------------------------------INPUTS --------------------------------------------

#cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt
# ---------------------------------------------------INPUTS --------------------------------------------

# Remove exact duplicate pairs (for matching start and end times of each event)
awk '!seen[$1, $2]++' ${NETWORK_FILE} > tmp_no_duplicates.txt

# Sort by start times (first column), then number of stations, then descending order of peaksum similarity - should not have duplicate start-end pairs
sort -k1,1n -nrk11,11 -nrk10,10 tmp_no_duplicates.txt > tmp_sorted_no_duplicates.txt

# Sort by start times, removing duplicate start times
sort -u -nk1,1 tmp_sorted_no_duplicates.txt > uniquestart_sorted_no_duplicates.txt

rm tmp_*.txt
