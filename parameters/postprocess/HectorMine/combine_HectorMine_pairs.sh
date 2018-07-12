#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/HectorMine/
COMBINE_DIR=${BASE_DIR}/inputs_network/
rm -rf ${COMBINE_DIR}
mkdir ${COMBINE_DIR}
cp ${BASE_DIR}waveforms*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_HEC --sort true --parse false -c true -t 6

awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_CDY_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_CDY_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_CPM_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_CPM_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_GTM_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_GTM_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_RMM_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_RMM_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_RMR_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_RMR_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_TPC_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_TPC_combined.txt

echo "Network detection inputs ready at ${COMBINE_DIR}"
