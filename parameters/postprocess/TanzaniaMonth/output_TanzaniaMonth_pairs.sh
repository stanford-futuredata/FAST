#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/
python parse_results.py -d ${BASE_DIR}CES02/fingerprints/ -p candidate_pairs_CES02_HNE -i ${BASE_DIR}global_indices/CES02_HNE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES02/fingerprints/ -p candidate_pairs_CES02_HNN -i ${BASE_DIR}global_indices/CES02_HNN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES02/fingerprints/ -p candidate_pairs_CES02_HNZ -i ${BASE_DIR}global_indices/CES02_HNZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}CES06/fingerprints/ -p candidate_pairs_CES06_HNE -i ${BASE_DIR}global_indices/CES06_HNE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES06/fingerprints/ -p candidate_pairs_CES06_HNN -i ${BASE_DIR}global_indices/CES06_HNN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES06/fingerprints/ -p candidate_pairs_CES06_HNZ -i ${BASE_DIR}global_indices/CES06_HNZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}CES08/fingerprints/ -p candidate_pairs_CES08_HNE -i ${BASE_DIR}global_indices/CES08_HNE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES08/fingerprints/ -p candidate_pairs_CES08_HNN -i ${BASE_DIR}global_indices/CES08_HNN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES08/fingerprints/ -p candidate_pairs_CES08_HNZ -i ${BASE_DIR}global_indices/CES08_HNZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}CES09/fingerprints/ -p candidate_pairs_CES09_HNE -i ${BASE_DIR}global_indices/CES09_HNE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES09/fingerprints/ -p candidate_pairs_CES09_HNN -i ${BASE_DIR}global_indices/CES09_HNN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES09/fingerprints/ -p candidate_pairs_CES09_HNZ -i ${BASE_DIR}global_indices/CES09_HNZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}CES04/fingerprints/ -p candidate_pairs_CES04_HNE -i ${BASE_DIR}global_indices/CES04_HNE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES04/fingerprints/ -p candidate_pairs_CES04_HNN -i ${BASE_DIR}global_indices/CES04_HNN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CES04/fingerprints/ -p candidate_pairs_CES04_HNZ -i ${BASE_DIR}global_indices/CES04_HNZ_idx_mapping.txt 

