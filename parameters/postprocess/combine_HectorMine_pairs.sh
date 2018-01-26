#!/bin/bash

python parse_results.py -d /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsHEC/fingerprints/ -p candidate_pairs_HEC --sort true --parse false -c true -t 6

awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCDY/fingerprints/candidate_pairs_CDY_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCDY/fingerprints/candidate_pairs_CDY_combined.txt
awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCPM/fingerprints/candidate_pairs_CPM_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsCPM/fingerprints/candidate_pairs_CPM_combined.txt
awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsGTM/fingerprints/candidate_pairs_GTM_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsGTM/fingerprints/candidate_pairs_GTM_combined.txt
awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMM/fingerprints/candidate_pairs_RMM_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMM/fingerprints/candidate_pairs_RMM_combined.txt
awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMR/fingerprints/candidate_pairs_RMR_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsRMR/fingerprints/candidate_pairs_RMR_combined.txt
awk '{print $1, $2, 3*$3}' /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsTPC/fingerprints/candidate_pairs_TPC_EHZ_merged.txt > /lfs/1/ceyoon/TimeSeries/HectorMine/waveformsTPC/fingerprints/candidate_pairs_TPC_combined.txt
