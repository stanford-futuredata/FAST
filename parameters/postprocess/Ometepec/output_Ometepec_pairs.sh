#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Ometepec/
python parse_results.py -d ${BASE_DIR}waveformsPNIG/fingerprints/ -p candidate_pairs_PNIG_HHZ -i ${BASE_DIR}global_indices/PNIG_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsPNIG/fingerprints/ -p candidate_pairs_PNIG_HHN -i ${BASE_DIR}global_indices/PNIG_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsPNIG/fingerprints/ -p candidate_pairs_PNIG_HHE -i ${BASE_DIR}global_indices/PNIG_HHE_idx_mapping.txt 
