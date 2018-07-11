#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Okmok/
python parse_results.py -d ${BASE_DIR}data/waveformsOKAK/fingerprints/ -p candidate_pairs_OKAK_EHZ -i ${BASE_DIR}global_indices/OKAK_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKFG/fingerprints/ -p candidate_pairs_OKFG_BHZ -i ${BASE_DIR}global_indices/OKFG_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsOKFG/fingerprints/ -p candidate_pairs_OKFG_BHN -i ${BASE_DIR}global_indices/OKFG_BHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsOKFG/fingerprints/ -p candidate_pairs_OKFG_BHE -i ${BASE_DIR}global_indices/OKFG_BHE_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKRE/fingerprints/ -p candidate_pairs_OKRE_EHZ -i ${BASE_DIR}global_indices/OKRE_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKSO/fingerprints/ -p candidate_pairs_OKSO_BHZ -i ${BASE_DIR}global_indices/OKSO_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsOKSO/fingerprints/ -p candidate_pairs_OKSO_BHN -i ${BASE_DIR}global_indices/OKSO_BHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsOKSO/fingerprints/ -p candidate_pairs_OKSO_BHE -i ${BASE_DIR}global_indices/OKSO_BHE_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKSP/fingerprints/ -p candidate_pairs_OKSP_EHZ -i ${BASE_DIR}global_indices/OKSP_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKWE/fingerprints/ -p candidate_pairs_OKWE_EHZ -i ${BASE_DIR}global_indices/OKWE_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsOKWR/fingerprints/ -p candidate_pairs_OKWR_EHZ -i ${BASE_DIR}global_indices/OKWR_EHZ_idx_mapping.txt 
