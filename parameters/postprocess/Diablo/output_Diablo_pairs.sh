#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Diablo/

# dawn12
python parse_results.py -d ${BASE_DIR}waveformsDCD/fingerprints/ -p candidate_pairs_DCD_EHE -i ${BASE_DIR}global_indices/DCD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsDCD/fingerprints/ -p candidate_pairs_DCD_EHN -i ${BASE_DIR}global_indices/DCD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsDCD/fingerprints/ -p candidate_pairs_DCD_EHZ -i ${BASE_DIR}global_indices/DCD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsEFD/fingerprints/ -p candidate_pairs_EFD_EHE -i ${BASE_DIR}global_indices/EFD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsEFD/fingerprints/ -p candidate_pairs_EFD_EHN -i ${BASE_DIR}global_indices/EFD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsEFD/fingerprints/ -p candidate_pairs_EFD_EHZ -i ${BASE_DIR}global_indices/EFD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsMLD/fingerprints/ -p candidate_pairs_MLD_EHE -i ${BASE_DIR}global_indices/MLD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsMLD/fingerprints/ -p candidate_pairs_MLD_EHN -i ${BASE_DIR}global_indices/MLD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsMLD/fingerprints/ -p candidate_pairs_MLD_EHZ -i ${BASE_DIR}global_indices/MLD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsPPB/fingerprints/ -p candidate_pairs_PPB_EHZ -i ${BASE_DIR}global_indices/PPB_EHZ_idx_mapping.txt 


# dawn9
python parse_results.py -d ${BASE_DIR}waveformsDPD/fingerprints/ -p candidate_pairs_DPD_EHE -i ${BASE_DIR}global_indices/DPD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsDPD/fingerprints/ -p candidate_pairs_DPD_EHN -i ${BASE_DIR}global_indices/DPD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsDPD/fingerprints/ -p candidate_pairs_DPD_EHZ -i ${BASE_DIR}global_indices/DPD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsEC/fingerprints/ -p candidate_pairs_EC_EHZ -i ${BASE_DIR}global_indices/EC_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsSH/fingerprints/ -p candidate_pairs_SH_EHZ -i ${BASE_DIR}global_indices/SH_EHZ_idx_mapping.txt 


# dawn7
python parse_results.py -d ${BASE_DIR}waveformsLMD/fingerprints/ -p candidate_pairs_LMD_EHE -i ${BASE_DIR}global_indices/LMD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLMD/fingerprints/ -p candidate_pairs_LMD_EHN -i ${BASE_DIR}global_indices/LMD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLMD/fingerprints/ -p candidate_pairs_LMD_EHZ -i ${BASE_DIR}global_indices/LMD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsLSD/fingerprints/ -p candidate_pairs_LSD_EHE -i ${BASE_DIR}global_indices/LSD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLSD/fingerprints/ -p candidate_pairs_LSD_EHN -i ${BASE_DIR}global_indices/LSD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsLSD/fingerprints/ -p candidate_pairs_LSD_EHZ -i ${BASE_DIR}global_indices/LSD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsSHD/fingerprints/ -p candidate_pairs_SHD_EHE -i ${BASE_DIR}global_indices/SHD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSHD/fingerprints/ -p candidate_pairs_SHD_EHN -i ${BASE_DIR}global_indices/SHD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsSHD/fingerprints/ -p candidate_pairs_SHD_EHZ -i ${BASE_DIR}global_indices/SHD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsVPD/fingerprints/ -p candidate_pairs_VPD_EHE -i ${BASE_DIR}global_indices/VPD_EHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsVPD/fingerprints/ -p candidate_pairs_VPD_EHN -i ${BASE_DIR}global_indices/VPD_EHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}waveformsVPD/fingerprints/ -p candidate_pairs_VPD_EHZ -i ${BASE_DIR}global_indices/VPD_EHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}waveformsPABB/fingerprints/ -p candidate_pairs_PABB_EHZ -i ${BASE_DIR}global_indices/PABB_EHZ_idx_mapping.txt 
