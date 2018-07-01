#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/OBSTest/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}waveforms*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS01 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS02 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS03 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS05 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS06 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS07 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS08 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS10 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS11 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS13 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS15 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS17 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS18 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS19 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS20 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS21 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS22 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS23 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS24 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS26 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS27 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS28 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS29 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS30 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS31 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS32 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS33 --sort true --parse false -c true -t 4
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_OBS34 --sort true --parse false -c true -t 4

# Single channel stations
cd ${COMBINE_DIR}
awk '{print $1, $2, 2*$3}' candidate_pairs_CIA_BHZ_merged.txt > candidate_pairs_CIA_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SBI_BHZ_merged.txt > candidate_pairs_SBI_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SCI2_BHZ_merged.txt > candidate_pairs_SCI2_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SCZ2_BHZ_merged.txt > candidate_pairs_SCZ2_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SMI_BHZ_merged.txt > candidate_pairs_SMI_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SNCC_BHZ_merged.txt > candidate_pairs_SNCC_combined.txt
awk '{print $1, $2, 2*$3}' candidate_pairs_SRI_BHZ_merged.txt > candidate_pairs_SRI_combined.txt
