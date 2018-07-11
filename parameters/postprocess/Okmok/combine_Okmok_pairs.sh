#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Okmok/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}waveforms*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OKFG --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OKSO --sort true --parse false -c true -t 6
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_OKAK_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_OKAK_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_OKRE_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_OKRE_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_OKSP_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_OKSP_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_OKWE_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_OKWE_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_OKWR_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_OKWR_combined.txt

echo "Network detection inputs ready at ${COMBINE_DIR}"
