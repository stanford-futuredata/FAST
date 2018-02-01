#!/bin/bash

python parse_results.py -d ../data/waveformsCDY/fingerprints/ -p candidate_pairs_CDY_EHZ -i ../data/global_indices/CDY_EHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsRMM/fingerprints/ -p candidate_pairs_RMM_EHZ -i ../data/global_indices/RMM_EHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsCPM/fingerprints/ -p candidate_pairs_CPM_EHZ -i ../data/global_indices/CPM_EHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHE -i ../data/global_indices/HEC_BHE_idx_mapping.txt 
python parse_results.py -d ../data/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHN -i ../data/global_indices/HEC_BHN_idx_mapping.txt 
python parse_results.py -d ../data/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHZ -i ../data/global_indices/HEC_BHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsGTM/fingerprints/ -p candidate_pairs_GTM_EHZ -i ../data/global_indices/GTM_EHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsRMR/fingerprints/ -p candidate_pairs_RMR_EHZ -i ../data/global_indices/RMR_EHZ_idx_mapping.txt 
python parse_results.py -d ../data/waveformsTPC/fingerprints/ -p candidate_pairs_TPC_EHZ -i ../data/global_indices/TPC_EHZ_idx_mapping.txt 
