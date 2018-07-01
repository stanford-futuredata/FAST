#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/OBSTest/
python parse_results.py -d ${BASE_DIR}waveformsOBS01/fingerprints/ -p candidate_pairs_OBS01_SXZ -i ${BASE_DIR}global_indices/OBS01_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS01/fingerprints/ -p candidate_pairs_OBS01_SXH -i ${BASE_DIR}global_indices/OBS01_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS02/fingerprints/ -p candidate_pairs_OBS02_SXZ -i ${BASE_DIR}global_indices/OBS02_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS02/fingerprints/ -p candidate_pairs_OBS02_SXH -i ${BASE_DIR}global_indices/OBS02_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS03/fingerprints/ -p candidate_pairs_OBS03_BXZ -i ${BASE_DIR}global_indices/OBS03_BXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS03/fingerprints/ -p candidate_pairs_OBS03_LXH -i ${BASE_DIR}global_indices/OBS03_LXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS05/fingerprints/ -p candidate_pairs_OBS05_SXZ -i ${BASE_DIR}global_indices/OBS05_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS05/fingerprints/ -p candidate_pairs_OBS05_SXH -i ${BASE_DIR}global_indices/OBS05_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS06/fingerprints/ -p candidate_pairs_OBS06_BXZ -i ${BASE_DIR}global_indices/OBS06_BXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS06/fingerprints/ -p candidate_pairs_OBS06_LXH -i ${BASE_DIR}global_indices/OBS06_LXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS07/fingerprints/ -p candidate_pairs_OBS07_BHZ -i ${BASE_DIR}global_indices/OBS07_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS07/fingerprints/ -p candidate_pairs_OBS07_LDH -i ${BASE_DIR}global_indices/OBS07_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS08/fingerprints/ -p candidate_pairs_OBS08_BHZ -i ${BASE_DIR}global_indices/OBS08_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS08/fingerprints/ -p candidate_pairs_OBS08_LDH -i ${BASE_DIR}global_indices/OBS08_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS10/fingerprints/ -p candidate_pairs_OBS10_BHZ -i ${BASE_DIR}global_indices/OBS10_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS10/fingerprints/ -p candidate_pairs_OBS10_LDH -i ${BASE_DIR}global_indices/OBS10_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS11/fingerprints/ -p candidate_pairs_OBS11_BHZ -i ${BASE_DIR}global_indices/OBS11_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS11/fingerprints/ -p candidate_pairs_OBS11_LDH -i ${BASE_DIR}global_indices/OBS11_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS13/fingerprints/ -p candidate_pairs_OBS13_BHZ -i ${BASE_DIR}global_indices/OBS13_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS13/fingerprints/ -p candidate_pairs_OBS13_LDH -i ${BASE_DIR}global_indices/OBS13_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS15/fingerprints/ -p candidate_pairs_OBS15_BHZ -i ${BASE_DIR}global_indices/OBS15_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS15/fingerprints/ -p candidate_pairs_OBS15_LDH -i ${BASE_DIR}global_indices/OBS15_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS17/fingerprints/ -p candidate_pairs_OBS17_BHZ -i ${BASE_DIR}global_indices/OBS17_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS17/fingerprints/ -p candidate_pairs_OBS17_LDH -i ${BASE_DIR}global_indices/OBS17_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS18/fingerprints/ -p candidate_pairs_OBS18_BHZ -i ${BASE_DIR}global_indices/OBS18_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS18/fingerprints/ -p candidate_pairs_OBS18_LDH -i ${BASE_DIR}global_indices/OBS18_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS19/fingerprints/ -p candidate_pairs_OBS19_BHZ -i ${BASE_DIR}global_indices/OBS19_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS19/fingerprints/ -p candidate_pairs_OBS19_LDH -i ${BASE_DIR}global_indices/OBS19_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS20/fingerprints/ -p candidate_pairs_OBS20_BHZ -i ${BASE_DIR}global_indices/OBS20_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS20/fingerprints/ -p candidate_pairs_OBS20_LDH -i ${BASE_DIR}global_indices/OBS20_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS21/fingerprints/ -p candidate_pairs_OBS21_BHZ -i ${BASE_DIR}global_indices/OBS21_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS21/fingerprints/ -p candidate_pairs_OBS21_LDH -i ${BASE_DIR}global_indices/OBS21_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS22/fingerprints/ -p candidate_pairs_OBS22_BHZ -i ${BASE_DIR}global_indices/OBS22_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS22/fingerprints/ -p candidate_pairs_OBS22_LDH -i ${BASE_DIR}global_indices/OBS22_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS23/fingerprints/ -p candidate_pairs_OBS23_BHZ -i ${BASE_DIR}global_indices/OBS23_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS23/fingerprints/ -p candidate_pairs_OBS23_LDH -i ${BASE_DIR}global_indices/OBS23_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS24/fingerprints/ -p candidate_pairs_OBS24_BHZ -i ${BASE_DIR}global_indices/OBS24_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS24/fingerprints/ -p candidate_pairs_OBS24_LDH -i ${BASE_DIR}global_indices/OBS24_LDH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS26/fingerprints/ -p candidate_pairs_OBS26_SXZ -i ${BASE_DIR}global_indices/OBS26_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS26/fingerprints/ -p candidate_pairs_OBS26_SXH -i ${BASE_DIR}global_indices/OBS26_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS27/fingerprints/ -p candidate_pairs_OBS27_SXZ -i ${BASE_DIR}global_indices/OBS27_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS27/fingerprints/ -p candidate_pairs_OBS27_SXH -i ${BASE_DIR}global_indices/OBS27_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS28/fingerprints/ -p candidate_pairs_OBS28_BXZ -i ${BASE_DIR}global_indices/OBS28_BXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS28/fingerprints/ -p candidate_pairs_OBS28_LXH -i ${BASE_DIR}global_indices/OBS28_LXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS29/fingerprints/ -p candidate_pairs_OBS29_SXZ -i ${BASE_DIR}global_indices/OBS29_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS29/fingerprints/ -p candidate_pairs_OBS29_SXH -i ${BASE_DIR}global_indices/OBS29_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS30/fingerprints/ -p candidate_pairs_OBS30_SXZ -i ${BASE_DIR}global_indices/OBS30_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS30/fingerprints/ -p candidate_pairs_OBS30_SXH -i ${BASE_DIR}global_indices/OBS30_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS31/fingerprints/ -p candidate_pairs_OBS31_SXZ -i ${BASE_DIR}global_indices/OBS31_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS31/fingerprints/ -p candidate_pairs_OBS31_SXH -i ${BASE_DIR}global_indices/OBS31_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS32/fingerprints/ -p candidate_pairs_OBS32_BXZ -i ${BASE_DIR}global_indices/OBS32_BXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS32/fingerprints/ -p candidate_pairs_OBS32_LXH -i ${BASE_DIR}global_indices/OBS32_LXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS33/fingerprints/ -p candidate_pairs_OBS33_SXZ -i ${BASE_DIR}global_indices/OBS33_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS33/fingerprints/ -p candidate_pairs_OBS33_SXH -i ${BASE_DIR}global_indices/OBS33_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsOBS34/fingerprints/ -p candidate_pairs_OBS34_SXZ -i ${BASE_DIR}global_indices/OBS34_SXZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsOBS34/fingerprints/ -p candidate_pairs_OBS34_SXH -i ${BASE_DIR}global_indices/OBS34_SXH_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsCIA/fingerprints/ -p candidate_pairs_CIA_BHZ -i ${BASE_DIR}global_indices/CIA_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSBI/fingerprints/ -p candidate_pairs_SBI_BHZ -i ${BASE_DIR}global_indices/SBI_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSCI2/fingerprints/ -p candidate_pairs_SCI2_BHZ -i ${BASE_DIR}global_indices/SCI2_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSCZ2/fingerprints/ -p candidate_pairs_SCZ2_BHZ -i ${BASE_DIR}global_indices/SCZ2_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSMI/fingerprints/ -p candidate_pairs_SMI_BHZ -i ${BASE_DIR}global_indices/SMI_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSNCC/fingerprints/ -p candidate_pairs_SNCC_BHZ -i ${BASE_DIR}global_indices/SNCC_BHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSRI/fingerprints/ -p candidate_pairs_SRI_BHZ -i ${BASE_DIR}global_indices/SRI_BHZ_idx_mapping.txt 
