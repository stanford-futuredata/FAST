##!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Diablo/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}SA.*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_DCD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_EFD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_MLD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_DPD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_LMD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_LSD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_SHD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_VPD --sort true --parse false -c true -t 6
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_PABB_EHZ_merged.txt > ${COMBINE_DIR}candidate_pairs_PABB_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_PPB_EHZ_merged.txt  > ${COMBINE_DIR}candidate_pairs_PPB_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_SH_EHZ_merged.txt   > ${COMBINE_DIR}candidate_pairs_SH_combined.txt
awk '{print $1, $2, 3*$3}' ${COMBINE_DIR}candidate_pairs_EC_EHZ_merged.txt   > ${COMBINE_DIR}candidate_pairs_EC_combined.txt

echo "Network detection inputs ready at ${COMBINE_DIR}"
