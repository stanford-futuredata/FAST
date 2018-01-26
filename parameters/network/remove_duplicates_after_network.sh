#!/bin/bash

#cd /lfs/1/ceyoon/TimeSeries/Diablo/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_Filter_4sta_2stathresh_detlist_rank_by_peaksum.txt
#NETWORK_FILE=NetworkDetectionTimes_Filter_5sta_3stathresh_detlist_rank_by_peaksum.txt
#NETWORK_FILE=NetworkDetectionTimes_Filter_6sta_3stathresh_detlist_rank_by_peaksum.txt

cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
NETWORK_FILE=NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/
##NETWORK_FILE=NetworkDetectionTimes_15sta_2stathresh_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt
#NETWORK_FILE=NetworkDetectionTimes_15sta_2stathresh_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/Diablo/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_11sta_2stathresh_mindets3_dgapL10_inputoffset15_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/SaudiMonth/network_detection/
##NETWORK_FILE=NetworkDetectionTimes_19sta_2stathresh_mindets3_dgapL10_inputoffset15_detlist_rank_by_peaksum.txt
#NETWORK_FILE=NetworkDetectionTimes_19sta_2stathresh_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/OBSTest/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_35sta_2stathresh_detlist_rank_by_peaksum.txt
#NETWORK_FILE=NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt

#cd /lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/
#NETWORK_FILE=NetworkDetectionTimes_22sta_2stathresh_detlist_rank_by_peaksum.txt





# Remove exact duplicate pairs (for matching start and end times of each event)
awk '!seen[$1, $2]++' ${NETWORK_FILE} > tmp_no_duplicates.txt

# Sort by start times (first column), then descending order of peaksum similarity (last column) - should not have duplicate start-end pairs
#sort -nk1,1 tmp_no_duplicates.txt > tmp_sorted_no_duplicates.txt
#sort -k1,1n -nrk10,10 tmp_no_duplicates.txt > tmp_sorted_no_duplicates.txt

# Sort by start times (first column), then number of stations, then descending order of peaksum similarity - should not have duplicate start-end pairs
sort -k1,1n -nrk11,11 -nrk10,10 tmp_no_duplicates.txt > tmp_sorted_no_duplicates.txt

# Sort by start times, removing duplicate start times
sort -u -nk1,1 tmp_sorted_no_duplicates.txt > uniquestart_sorted_no_duplicates.txt

#rm tmp_*.txt
