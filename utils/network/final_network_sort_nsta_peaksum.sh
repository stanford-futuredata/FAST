#!/bin/bash

# ---------------------------------------------------INPUTS --------------------------------------------
cd ../../data/network_detection/
NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
#NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
# ---------------------------------------------------INPUTS --------------------------------------------

#cd /lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/
#NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/
#NETWORK_FILE=22sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/TanzaniaMonth/network_detection/
#NETWORK_FILE=5sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/SaudiMonth/data/network_detection/
#NETWORK_FILE=19sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/OBSTest/network_detection/
#NETWORK_FILE=35sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/Diablo/network_detection/
#NETWORK_FILE=11sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/Okmok/network_detection/
#NETWORK_FILE=7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt

#cd /lfs/1/ceyoon/TimeSeries/Groningen/network_detection/
#NETWORK_FILE=67sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt
# ---------------------------------------------------INPUTS --------------------------------------------

# Sort in descending order of number of stations (column 11), then descending order of peaksum (column 10)
sort -nrk11,11 -nrk10,10 ${NETWORK_FILE} > sort_nsta_peaksum_${NETWORK_FILE}
