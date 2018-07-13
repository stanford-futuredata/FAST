#!/bin/bash

# ---------------------------------------------------INPUTS --------------------------------------------
#cd /lfs/1/ceyoon/TimeSeries/BrazilAcre/network_detection/
#NETWORK_FILE=1sta_1stathresh_CZSB_events.txt

cd /lfs/1/ceyoon/TimeSeries/Ometepec/network_detection/
NETWORK_FILE=1sta_1stathresh_PNIG_events.txt
# ---------------------------------------------------INPUTS --------------------------------------------

# Single station detection
# Sort in descending order of peaksum (column 4)
tail -n +2 ${NETWORK_FILE} > tmp.txt
sort -nrk4,4 tmp.txt > sort_peaksum_${NETWORK_FILE}
rm tmp.txt
