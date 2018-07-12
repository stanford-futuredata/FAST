#!/bin/bash

#FILE_DIR=/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/
FILE_DIR=/lfs/1/ceyoon/TimeSeries/BrazilAcre/CZSB

cd ${FILE_DIR}
mkdir temp

for file in Deci*
do
#   mv "$file" "temp/$file.SAC"
   mv "$file" "temp/$file.mseed"
done
