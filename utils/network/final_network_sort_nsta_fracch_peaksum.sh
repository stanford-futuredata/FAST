#!/bin/bash

# ---------------------------------------------------INPUTS --------------------------------------------
#cd /lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/
#NETWORK_FILE=15sta_2stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt

cd /lfs/1/ceyoon/TimeSeries/SaudiFull/network_detection/
NETWORK_FILE=36sta_3stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt
# ---------------------------------------------------INPUTS --------------------------------------------

# Sort in descending order of number of stations (column 11), then descending order of fraction of available channels (column 13),
# then descending order of peaksum (column 10)
sort -nrk11,11 -nrk13,13 -nrk10,10 ${NETWORK_FILE} > sort_nsta_peaksum_${NETWORK_FILE}
