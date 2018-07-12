#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/BrazilAcre/
python parse_results.py -d ${BASE_DIR}CZSB/fingerprints/ -p candidate_pairs_CZSB_HHZ -i ${BASE_DIR}global_indices/CZSB_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CZSB/fingerprints/ -p candidate_pairs_CZSB_HHN -i ${BASE_DIR}global_indices/CZSB_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}CZSB/fingerprints/ -p candidate_pairs_CZSB_HHE -i ${BASE_DIR}global_indices/CZSB_HHE_idx_mapping.txt 
