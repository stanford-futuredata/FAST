#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/
python parse_results.py -d ${BASE_DIR}waveformsLNY02/fingerprints/ -p candidate_pairs_LNY02_HHE -i ${BASE_DIR}global_indices/LNY02_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY02/fingerprints/ -p candidate_pairs_LNY02_HHN -i ${BASE_DIR}global_indices/LNY02_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY02/fingerprints/ -p candidate_pairs_LNY02_HHZ -i ${BASE_DIR}global_indices/LNY02_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY03/fingerprints/ -p candidate_pairs_LNY03_HHE -i ${BASE_DIR}global_indices/LNY03_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY03/fingerprints/ -p candidate_pairs_LNY03_HHN -i ${BASE_DIR}global_indices/LNY03_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY03/fingerprints/ -p candidate_pairs_LNY03_HHZ -i ${BASE_DIR}global_indices/LNY03_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY04/fingerprints/ -p candidate_pairs_LNY04_HHE -i ${BASE_DIR}global_indices/LNY04_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY04/fingerprints/ -p candidate_pairs_LNY04_HHN -i ${BASE_DIR}global_indices/LNY04_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY04/fingerprints/ -p candidate_pairs_LNY04_HHZ -i ${BASE_DIR}global_indices/LNY04_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY05/fingerprints/ -p candidate_pairs_LNY05_HHE -i ${BASE_DIR}global_indices/LNY05_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY05/fingerprints/ -p candidate_pairs_LNY05_HHN -i ${BASE_DIR}global_indices/LNY05_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY05/fingerprints/ -p candidate_pairs_LNY05_HHZ -i ${BASE_DIR}global_indices/LNY05_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY06/fingerprints/ -p candidate_pairs_LNY06_HHE -i ${BASE_DIR}global_indices/LNY06_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY06/fingerprints/ -p candidate_pairs_LNY06_HHN -i ${BASE_DIR}global_indices/LNY06_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY06/fingerprints/ -p candidate_pairs_LNY06_HHZ -i ${BASE_DIR}global_indices/LNY06_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY07/fingerprints/ -p candidate_pairs_LNY07_HHE -i ${BASE_DIR}global_indices/LNY07_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY07/fingerprints/ -p candidate_pairs_LNY07_HHN -i ${BASE_DIR}global_indices/LNY07_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY07/fingerprints/ -p candidate_pairs_LNY07_HHZ -i ${BASE_DIR}global_indices/LNY07_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY08/fingerprints/ -p candidate_pairs_LNY08_HHE -i ${BASE_DIR}global_indices/LNY08_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY08/fingerprints/ -p candidate_pairs_LNY08_HHN -i ${BASE_DIR}global_indices/LNY08_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY08/fingerprints/ -p candidate_pairs_LNY08_HHZ -i ${BASE_DIR}global_indices/LNY08_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY09/fingerprints/ -p candidate_pairs_LNY09_HHE -i ${BASE_DIR}global_indices/LNY09_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY09/fingerprints/ -p candidate_pairs_LNY09_HHN -i ${BASE_DIR}global_indices/LNY09_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY09/fingerprints/ -p candidate_pairs_LNY09_HHZ -i ${BASE_DIR}global_indices/LNY09_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY10/fingerprints/ -p candidate_pairs_LNY10_HHE -i ${BASE_DIR}global_indices/LNY10_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY10/fingerprints/ -p candidate_pairs_LNY10_HHN -i ${BASE_DIR}global_indices/LNY10_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY10/fingerprints/ -p candidate_pairs_LNY10_HHZ -i ${BASE_DIR}global_indices/LNY10_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY11/fingerprints/ -p candidate_pairs_LNY11_HHE -i ${BASE_DIR}global_indices/LNY11_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY11/fingerprints/ -p candidate_pairs_LNY11_HHN -i ${BASE_DIR}global_indices/LNY11_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY11/fingerprints/ -p candidate_pairs_LNY11_HHZ -i ${BASE_DIR}global_indices/LNY11_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY12/fingerprints/ -p candidate_pairs_LNY12_HHE -i ${BASE_DIR}global_indices/LNY12_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY12/fingerprints/ -p candidate_pairs_LNY12_HHN -i ${BASE_DIR}global_indices/LNY12_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY12/fingerprints/ -p candidate_pairs_LNY12_HHZ -i ${BASE_DIR}global_indices/LNY12_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY13/fingerprints/ -p candidate_pairs_LNY13_HHE -i ${BASE_DIR}global_indices/LNY13_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY13/fingerprints/ -p candidate_pairs_LNY13_HHN -i ${BASE_DIR}global_indices/LNY13_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY13/fingerprints/ -p candidate_pairs_LNY13_HHZ -i ${BASE_DIR}global_indices/LNY13_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY14/fingerprints/ -p candidate_pairs_LNY14_HHE -i ${BASE_DIR}global_indices/LNY14_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY14/fingerprints/ -p candidate_pairs_LNY14_HHN -i ${BASE_DIR}global_indices/LNY14_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY14/fingerprints/ -p candidate_pairs_LNY14_HHZ -i ${BASE_DIR}global_indices/LNY14_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY15/fingerprints/ -p candidate_pairs_LNY15_HHE -i ${BASE_DIR}global_indices/LNY15_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY15/fingerprints/ -p candidate_pairs_LNY15_HHN -i ${BASE_DIR}global_indices/LNY15_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY15/fingerprints/ -p candidate_pairs_LNY15_HHZ -i ${BASE_DIR}global_indices/LNY15_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY16/fingerprints/ -p candidate_pairs_LNY16_HHE -i ${BASE_DIR}global_indices/LNY16_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY16/fingerprints/ -p candidate_pairs_LNY16_HHN -i ${BASE_DIR}global_indices/LNY16_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY16/fingerprints/ -p candidate_pairs_LNY16_HHZ -i ${BASE_DIR}global_indices/LNY16_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY17/fingerprints/ -p candidate_pairs_LNY17_HHE -i ${BASE_DIR}global_indices/LNY17_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY17/fingerprints/ -p candidate_pairs_LNY17_HHN -i ${BASE_DIR}global_indices/LNY17_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY17/fingerprints/ -p candidate_pairs_LNY17_HHZ -i ${BASE_DIR}global_indices/LNY17_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNYS/fingerprints/ -p candidate_pairs_LNYS_HHE -i ${BASE_DIR}global_indices/LNYS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNYS/fingerprints/ -p candidate_pairs_LNYS_HHN -i ${BASE_DIR}global_indices/LNYS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNYS/fingerprints/ -p candidate_pairs_LNYS_HHZ -i ${BASE_DIR}global_indices/LNYS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsTRAS/fingerprints/ -p candidate_pairs_TRAS_HHE -i ${BASE_DIR}global_indices/TRAS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsTRAS/fingerprints/ -p candidate_pairs_TRAS_HHN -i ${BASE_DIR}global_indices/TRAS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsTRAS/fingerprints/ -p candidate_pairs_TRAS_HHZ -i ${BASE_DIR}global_indices/TRAS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLNY01/fingerprints/ -p candidate_pairs_LNY01_HHE -i ${BASE_DIR}global_indices/LNY01_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY01/fingerprints/ -p candidate_pairs_LNY01_HHN -i ${BASE_DIR}global_indices/LNY01_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLNY01/fingerprints/ -p candidate_pairs_LNY01_HHZ -i ${BASE_DIR}global_indices/LNY01_HHZ_idx_mapping.txt 

