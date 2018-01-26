#!/bin/bash

#cd /lfs/1/ceyoon/TimeSeries/Diablo/network_detection/
#NETWORK_FILE=5sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt
#NETWORK_FILE=6sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/
#NETWORK_FILE=15sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/Diablo/network_detection/
#NETWORK_FILE=11sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/SaudiMonth/network_detection/
#NETWORK_FILE=19sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/OBSTest/network_detection/
#NETWORK_FILE=35sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
#NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/
#NETWORK_FILE=22sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt




# Sort in descending order of number of stations (column 11), then descending order of peaksum (column 10)
sort -nrk11,11 -nrk10,10 ${NETWORK_FILE} > sort_nsta_peaksum_${NETWORK_FILE}

# Sort in descending order of peaksum (column 10), then descending order of number of stations (column 11)
#sort -nrk10,10 -nrk11,11 ${NETWORK_FILE} > sort_nsta_peaksum_${NETWORK_FILE}
