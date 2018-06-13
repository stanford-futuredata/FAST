#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/HectorMine/
python parse_results.py -d ${BASE_DIR}waveformsCDY/fingerprints/ -p candidate_pairs_CDY_EHZ -i ${BASE_DIR}global_indices/CDY_EHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsRMM/fingerprints/ -p candidate_pairs_RMM_EHZ -i ${BASE_DIR}global_indices/RMM_EHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsCPM/fingerprints/ -p candidate_pairs_CPM_EHZ -i ${BASE_DIR}global_indices/CPM_EHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHE -i ${BASE_DIR}global_indices/HEC_BHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHN -i ${BASE_DIR}global_indices/HEC_BHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHZ -i ${BASE_DIR}global_indices/HEC_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsGTM/fingerprints/ -p candidate_pairs_GTM_EHZ -i ${BASE_DIR}global_indices/GTM_EHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsRMR/fingerprints/ -p candidate_pairs_RMR_EHZ -i ${BASE_DIR}global_indices/RMR_EHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsTPC/fingerprints/ -p candidate_pairs_TPC_EHZ -i ${BASE_DIR}global_indices/TPC_EHZ_idx_mapping.txt 
