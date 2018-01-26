#!/bin/bash

python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCDY/fingerprints/ -p candidate_pairs_CDY_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/CDY_EHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMM/fingerprints/ -p candidate_pairs_RMM_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/RMM_EHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCPM/fingerprints/ -p candidate_pairs_CPM_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/CPM_EHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHE -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/HEC_BHE_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHN -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/HEC_BHN_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsHEC/fingerprints/ -p candidate_pairs_HEC_BHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/HEC_BHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsGTM/fingerprints/ -p candidate_pairs_GTM_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/GTM_EHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMR/fingerprints/ -p candidate_pairs_RMR_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/RMR_EHZ_idx_mapping.txt 
python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsTPC/fingerprints/ -p candidate_pairs_TPC_EHZ -i /lfs/1/ceyoon/TimeSeries/HectorMine/global_indices/TPC_EHZ_idx_mapping.txt 
