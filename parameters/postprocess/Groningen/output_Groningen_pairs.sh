#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Groningen/
python parse_results.py -d ${BASE_DIR}data/waveformsENM4/fingerprints/ -p candidate_pairs_ENM4_HHZ -i ${BASE_DIR}global_indices/ENM4_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsENM4/fingerprints/ -p candidate_pairs_ENM4_HH2 -i ${BASE_DIR}global_indices/ENM4_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsENM4/fingerprints/ -p candidate_pairs_ENM4_HH1 -i ${BASE_DIR}global_indices/ENM4_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsENV4/fingerprints/ -p candidate_pairs_ENV4_HHZ -i ${BASE_DIR}global_indices/ENV4_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsENV4/fingerprints/ -p candidate_pairs_ENV4_HH2 -i ${BASE_DIR}global_indices/ENV4_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsENV4/fingerprints/ -p candidate_pairs_ENV4_HH1 -i ${BASE_DIR}global_indices/ENV4_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG014/fingerprints/ -p candidate_pairs_G014_HHZ -i ${BASE_DIR}global_indices/G014_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG014/fingerprints/ -p candidate_pairs_G014_HH2 -i ${BASE_DIR}global_indices/G014_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG014/fingerprints/ -p candidate_pairs_G014_HH1 -i ${BASE_DIR}global_indices/G014_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG024/fingerprints/ -p candidate_pairs_G024_HHZ -i ${BASE_DIR}global_indices/G024_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG024/fingerprints/ -p candidate_pairs_G024_HH2 -i ${BASE_DIR}global_indices/G024_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG024/fingerprints/ -p candidate_pairs_G024_HH1 -i ${BASE_DIR}global_indices/G024_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG034/fingerprints/ -p candidate_pairs_G034_HHZ -i ${BASE_DIR}global_indices/G034_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG034/fingerprints/ -p candidate_pairs_G034_HH2 -i ${BASE_DIR}global_indices/G034_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG034/fingerprints/ -p candidate_pairs_G034_HH1 -i ${BASE_DIR}global_indices/G034_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG044/fingerprints/ -p candidate_pairs_G044_HHZ -i ${BASE_DIR}global_indices/G044_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG044/fingerprints/ -p candidate_pairs_G044_HH2 -i ${BASE_DIR}global_indices/G044_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG044/fingerprints/ -p candidate_pairs_G044_HH1 -i ${BASE_DIR}global_indices/G044_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG054/fingerprints/ -p candidate_pairs_G054_HHZ -i ${BASE_DIR}global_indices/G054_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG054/fingerprints/ -p candidate_pairs_G054_HH2 -i ${BASE_DIR}global_indices/G054_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG054/fingerprints/ -p candidate_pairs_G054_HH1 -i ${BASE_DIR}global_indices/G054_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG064/fingerprints/ -p candidate_pairs_G064_HHZ -i ${BASE_DIR}global_indices/G064_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG064/fingerprints/ -p candidate_pairs_G064_HH2 -i ${BASE_DIR}global_indices/G064_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG064/fingerprints/ -p candidate_pairs_G064_HH1 -i ${BASE_DIR}global_indices/G064_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG074/fingerprints/ -p candidate_pairs_G074_HHZ -i ${BASE_DIR}global_indices/G074_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG074/fingerprints/ -p candidate_pairs_G074_HH2 -i ${BASE_DIR}global_indices/G074_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG074/fingerprints/ -p candidate_pairs_G074_HH1 -i ${BASE_DIR}global_indices/G074_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG084/fingerprints/ -p candidate_pairs_G084_HHZ -i ${BASE_DIR}global_indices/G084_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG084/fingerprints/ -p candidate_pairs_G084_HH2 -i ${BASE_DIR}global_indices/G084_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG084/fingerprints/ -p candidate_pairs_G084_HH1 -i ${BASE_DIR}global_indices/G084_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG094/fingerprints/ -p candidate_pairs_G094_HHZ -i ${BASE_DIR}global_indices/G094_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG094/fingerprints/ -p candidate_pairs_G094_HH2 -i ${BASE_DIR}global_indices/G094_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG094/fingerprints/ -p candidate_pairs_G094_HH1 -i ${BASE_DIR}global_indices/G094_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG104/fingerprints/ -p candidate_pairs_G104_HHZ -i ${BASE_DIR}global_indices/G104_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG104/fingerprints/ -p candidate_pairs_G104_HH2 -i ${BASE_DIR}global_indices/G104_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG104/fingerprints/ -p candidate_pairs_G104_HH1 -i ${BASE_DIR}global_indices/G104_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG114/fingerprints/ -p candidate_pairs_G114_HHZ -i ${BASE_DIR}global_indices/G114_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG114/fingerprints/ -p candidate_pairs_G114_HH2 -i ${BASE_DIR}global_indices/G114_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG114/fingerprints/ -p candidate_pairs_G114_HH1 -i ${BASE_DIR}global_indices/G114_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG134/fingerprints/ -p candidate_pairs_G134_HHZ -i ${BASE_DIR}global_indices/G134_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG134/fingerprints/ -p candidate_pairs_G134_HH2 -i ${BASE_DIR}global_indices/G134_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG134/fingerprints/ -p candidate_pairs_G134_HH1 -i ${BASE_DIR}global_indices/G134_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG144/fingerprints/ -p candidate_pairs_G144_HHZ -i ${BASE_DIR}global_indices/G144_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG144/fingerprints/ -p candidate_pairs_G144_HH2 -i ${BASE_DIR}global_indices/G144_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG144/fingerprints/ -p candidate_pairs_G144_HH1 -i ${BASE_DIR}global_indices/G144_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG164/fingerprints/ -p candidate_pairs_G164_HHZ -i ${BASE_DIR}global_indices/G164_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG164/fingerprints/ -p candidate_pairs_G164_HH2 -i ${BASE_DIR}global_indices/G164_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG164/fingerprints/ -p candidate_pairs_G164_HH1 -i ${BASE_DIR}global_indices/G164_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG174/fingerprints/ -p candidate_pairs_G174_HHZ -i ${BASE_DIR}global_indices/G174_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG174/fingerprints/ -p candidate_pairs_G174_HH2 -i ${BASE_DIR}global_indices/G174_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG174/fingerprints/ -p candidate_pairs_G174_HH1 -i ${BASE_DIR}global_indices/G174_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG184/fingerprints/ -p candidate_pairs_G184_HHZ -i ${BASE_DIR}global_indices/G184_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG184/fingerprints/ -p candidate_pairs_G184_HH2 -i ${BASE_DIR}global_indices/G184_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG184/fingerprints/ -p candidate_pairs_G184_HH1 -i ${BASE_DIR}global_indices/G184_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG194/fingerprints/ -p candidate_pairs_G194_HHZ -i ${BASE_DIR}global_indices/G194_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG194/fingerprints/ -p candidate_pairs_G194_HH2 -i ${BASE_DIR}global_indices/G194_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG194/fingerprints/ -p candidate_pairs_G194_HH1 -i ${BASE_DIR}global_indices/G194_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG204/fingerprints/ -p candidate_pairs_G204_HHZ -i ${BASE_DIR}global_indices/G204_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG204/fingerprints/ -p candidate_pairs_G204_HH2 -i ${BASE_DIR}global_indices/G204_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG204/fingerprints/ -p candidate_pairs_G204_HH1 -i ${BASE_DIR}global_indices/G204_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG214/fingerprints/ -p candidate_pairs_G214_HHZ -i ${BASE_DIR}global_indices/G214_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG214/fingerprints/ -p candidate_pairs_G214_HH2 -i ${BASE_DIR}global_indices/G214_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG214/fingerprints/ -p candidate_pairs_G214_HH1 -i ${BASE_DIR}global_indices/G214_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG224/fingerprints/ -p candidate_pairs_G224_HHZ -i ${BASE_DIR}global_indices/G224_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG224/fingerprints/ -p candidate_pairs_G224_HH2 -i ${BASE_DIR}global_indices/G224_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG224/fingerprints/ -p candidate_pairs_G224_HH1 -i ${BASE_DIR}global_indices/G224_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG234/fingerprints/ -p candidate_pairs_G234_HHZ -i ${BASE_DIR}global_indices/G234_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG234/fingerprints/ -p candidate_pairs_G234_HH2 -i ${BASE_DIR}global_indices/G234_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG234/fingerprints/ -p candidate_pairs_G234_HH1 -i ${BASE_DIR}global_indices/G234_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG244/fingerprints/ -p candidate_pairs_G244_HHZ -i ${BASE_DIR}global_indices/G244_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG244/fingerprints/ -p candidate_pairs_G244_HH2 -i ${BASE_DIR}global_indices/G244_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG244/fingerprints/ -p candidate_pairs_G244_HH1 -i ${BASE_DIR}global_indices/G244_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG264/fingerprints/ -p candidate_pairs_G264_HHZ -i ${BASE_DIR}global_indices/G264_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG264/fingerprints/ -p candidate_pairs_G264_HH2 -i ${BASE_DIR}global_indices/G264_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG264/fingerprints/ -p candidate_pairs_G264_HH1 -i ${BASE_DIR}global_indices/G264_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG274/fingerprints/ -p candidate_pairs_G274_HHZ -i ${BASE_DIR}global_indices/G274_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG274/fingerprints/ -p candidate_pairs_G274_HH2 -i ${BASE_DIR}global_indices/G274_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG274/fingerprints/ -p candidate_pairs_G274_HH1 -i ${BASE_DIR}global_indices/G274_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG304/fingerprints/ -p candidate_pairs_G304_HHZ -i ${BASE_DIR}global_indices/G304_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG304/fingerprints/ -p candidate_pairs_G304_HH2 -i ${BASE_DIR}global_indices/G304_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG304/fingerprints/ -p candidate_pairs_G304_HH1 -i ${BASE_DIR}global_indices/G304_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG314/fingerprints/ -p candidate_pairs_G314_HHZ -i ${BASE_DIR}global_indices/G314_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG314/fingerprints/ -p candidate_pairs_G314_HH2 -i ${BASE_DIR}global_indices/G314_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG314/fingerprints/ -p candidate_pairs_G314_HH1 -i ${BASE_DIR}global_indices/G314_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG324/fingerprints/ -p candidate_pairs_G324_HHZ -i ${BASE_DIR}global_indices/G324_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG324/fingerprints/ -p candidate_pairs_G324_HH2 -i ${BASE_DIR}global_indices/G324_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG324/fingerprints/ -p candidate_pairs_G324_HH1 -i ${BASE_DIR}global_indices/G324_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG344/fingerprints/ -p candidate_pairs_G344_HHZ -i ${BASE_DIR}global_indices/G344_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG344/fingerprints/ -p candidate_pairs_G344_HH2 -i ${BASE_DIR}global_indices/G344_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG344/fingerprints/ -p candidate_pairs_G344_HH1 -i ${BASE_DIR}global_indices/G344_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG364/fingerprints/ -p candidate_pairs_G364_HHZ -i ${BASE_DIR}global_indices/G364_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG364/fingerprints/ -p candidate_pairs_G364_HH2 -i ${BASE_DIR}global_indices/G364_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG364/fingerprints/ -p candidate_pairs_G364_HH1 -i ${BASE_DIR}global_indices/G364_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG374/fingerprints/ -p candidate_pairs_G374_HHZ -i ${BASE_DIR}global_indices/G374_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG374/fingerprints/ -p candidate_pairs_G374_HH2 -i ${BASE_DIR}global_indices/G374_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG374/fingerprints/ -p candidate_pairs_G374_HH1 -i ${BASE_DIR}global_indices/G374_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG394/fingerprints/ -p candidate_pairs_G394_HHZ -i ${BASE_DIR}global_indices/G394_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG394/fingerprints/ -p candidate_pairs_G394_HH2 -i ${BASE_DIR}global_indices/G394_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG394/fingerprints/ -p candidate_pairs_G394_HH1 -i ${BASE_DIR}global_indices/G394_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG404/fingerprints/ -p candidate_pairs_G404_HHZ -i ${BASE_DIR}global_indices/G404_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG404/fingerprints/ -p candidate_pairs_G404_HH2 -i ${BASE_DIR}global_indices/G404_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG404/fingerprints/ -p candidate_pairs_G404_HH1 -i ${BASE_DIR}global_indices/G404_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG414/fingerprints/ -p candidate_pairs_G414_HHZ -i ${BASE_DIR}global_indices/G414_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG414/fingerprints/ -p candidate_pairs_G414_HH2 -i ${BASE_DIR}global_indices/G414_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG414/fingerprints/ -p candidate_pairs_G414_HH1 -i ${BASE_DIR}global_indices/G414_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG424/fingerprints/ -p candidate_pairs_G424_HHZ -i ${BASE_DIR}global_indices/G424_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG424/fingerprints/ -p candidate_pairs_G424_HH2 -i ${BASE_DIR}global_indices/G424_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG424/fingerprints/ -p candidate_pairs_G424_HH1 -i ${BASE_DIR}global_indices/G424_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG434/fingerprints/ -p candidate_pairs_G434_HHZ -i ${BASE_DIR}global_indices/G434_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG434/fingerprints/ -p candidate_pairs_G434_HH2 -i ${BASE_DIR}global_indices/G434_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG434/fingerprints/ -p candidate_pairs_G434_HH1 -i ${BASE_DIR}global_indices/G434_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG444/fingerprints/ -p candidate_pairs_G444_HHZ -i ${BASE_DIR}global_indices/G444_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG444/fingerprints/ -p candidate_pairs_G444_HH2 -i ${BASE_DIR}global_indices/G444_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG444/fingerprints/ -p candidate_pairs_G444_HH1 -i ${BASE_DIR}global_indices/G444_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG454/fingerprints/ -p candidate_pairs_G454_HHZ -i ${BASE_DIR}global_indices/G454_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG454/fingerprints/ -p candidate_pairs_G454_HH2 -i ${BASE_DIR}global_indices/G454_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG454/fingerprints/ -p candidate_pairs_G454_HH1 -i ${BASE_DIR}global_indices/G454_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG464/fingerprints/ -p candidate_pairs_G464_HHZ -i ${BASE_DIR}global_indices/G464_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG464/fingerprints/ -p candidate_pairs_G464_HH2 -i ${BASE_DIR}global_indices/G464_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG464/fingerprints/ -p candidate_pairs_G464_HH1 -i ${BASE_DIR}global_indices/G464_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG494/fingerprints/ -p candidate_pairs_G494_HHZ -i ${BASE_DIR}global_indices/G494_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG494/fingerprints/ -p candidate_pairs_G494_HH2 -i ${BASE_DIR}global_indices/G494_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG494/fingerprints/ -p candidate_pairs_G494_HH1 -i ${BASE_DIR}global_indices/G494_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG504/fingerprints/ -p candidate_pairs_G504_HHZ -i ${BASE_DIR}global_indices/G504_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG504/fingerprints/ -p candidate_pairs_G504_HH2 -i ${BASE_DIR}global_indices/G504_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG504/fingerprints/ -p candidate_pairs_G504_HH1 -i ${BASE_DIR}global_indices/G504_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG514/fingerprints/ -p candidate_pairs_G514_HHZ -i ${BASE_DIR}global_indices/G514_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG514/fingerprints/ -p candidate_pairs_G514_HH2 -i ${BASE_DIR}global_indices/G514_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG514/fingerprints/ -p candidate_pairs_G514_HH1 -i ${BASE_DIR}global_indices/G514_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG524/fingerprints/ -p candidate_pairs_G524_HHZ -i ${BASE_DIR}global_indices/G524_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG524/fingerprints/ -p candidate_pairs_G524_HH2 -i ${BASE_DIR}global_indices/G524_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG524/fingerprints/ -p candidate_pairs_G524_HH1 -i ${BASE_DIR}global_indices/G524_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG534/fingerprints/ -p candidate_pairs_G534_HHZ -i ${BASE_DIR}global_indices/G534_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG534/fingerprints/ -p candidate_pairs_G534_HH2 -i ${BASE_DIR}global_indices/G534_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG534/fingerprints/ -p candidate_pairs_G534_HH1 -i ${BASE_DIR}global_indices/G534_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG544/fingerprints/ -p candidate_pairs_G544_HHZ -i ${BASE_DIR}global_indices/G544_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG544/fingerprints/ -p candidate_pairs_G544_HH2 -i ${BASE_DIR}global_indices/G544_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG544/fingerprints/ -p candidate_pairs_G544_HH1 -i ${BASE_DIR}global_indices/G544_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG554/fingerprints/ -p candidate_pairs_G554_HHZ -i ${BASE_DIR}global_indices/G554_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG554/fingerprints/ -p candidate_pairs_G554_HH2 -i ${BASE_DIR}global_indices/G554_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG554/fingerprints/ -p candidate_pairs_G554_HH1 -i ${BASE_DIR}global_indices/G554_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG564/fingerprints/ -p candidate_pairs_G564_HHZ -i ${BASE_DIR}global_indices/G564_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG564/fingerprints/ -p candidate_pairs_G564_HH2 -i ${BASE_DIR}global_indices/G564_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG564/fingerprints/ -p candidate_pairs_G564_HH1 -i ${BASE_DIR}global_indices/G564_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG574/fingerprints/ -p candidate_pairs_G574_HHZ -i ${BASE_DIR}global_indices/G574_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG574/fingerprints/ -p candidate_pairs_G574_HH2 -i ${BASE_DIR}global_indices/G574_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG574/fingerprints/ -p candidate_pairs_G574_HH1 -i ${BASE_DIR}global_indices/G574_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG584/fingerprints/ -p candidate_pairs_G584_HHZ -i ${BASE_DIR}global_indices/G584_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG584/fingerprints/ -p candidate_pairs_G584_HH2 -i ${BASE_DIR}global_indices/G584_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG584/fingerprints/ -p candidate_pairs_G584_HH1 -i ${BASE_DIR}global_indices/G584_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG594/fingerprints/ -p candidate_pairs_G594_HHZ -i ${BASE_DIR}global_indices/G594_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG594/fingerprints/ -p candidate_pairs_G594_HH2 -i ${BASE_DIR}global_indices/G594_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG594/fingerprints/ -p candidate_pairs_G594_HH1 -i ${BASE_DIR}global_indices/G594_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG604/fingerprints/ -p candidate_pairs_G604_HHZ -i ${BASE_DIR}global_indices/G604_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG604/fingerprints/ -p candidate_pairs_G604_HH2 -i ${BASE_DIR}global_indices/G604_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG604/fingerprints/ -p candidate_pairs_G604_HH1 -i ${BASE_DIR}global_indices/G604_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG614/fingerprints/ -p candidate_pairs_G614_HHZ -i ${BASE_DIR}global_indices/G614_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG614/fingerprints/ -p candidate_pairs_G614_HH2 -i ${BASE_DIR}global_indices/G614_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG614/fingerprints/ -p candidate_pairs_G614_HH1 -i ${BASE_DIR}global_indices/G614_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG624/fingerprints/ -p candidate_pairs_G624_HHZ -i ${BASE_DIR}global_indices/G624_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG624/fingerprints/ -p candidate_pairs_G624_HH2 -i ${BASE_DIR}global_indices/G624_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG624/fingerprints/ -p candidate_pairs_G624_HH1 -i ${BASE_DIR}global_indices/G624_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG634/fingerprints/ -p candidate_pairs_G634_HHZ -i ${BASE_DIR}global_indices/G634_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG634/fingerprints/ -p candidate_pairs_G634_HH2 -i ${BASE_DIR}global_indices/G634_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG634/fingerprints/ -p candidate_pairs_G634_HH1 -i ${BASE_DIR}global_indices/G634_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG644/fingerprints/ -p candidate_pairs_G644_HHZ -i ${BASE_DIR}global_indices/G644_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG644/fingerprints/ -p candidate_pairs_G644_HH2 -i ${BASE_DIR}global_indices/G644_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG644/fingerprints/ -p candidate_pairs_G644_HH1 -i ${BASE_DIR}global_indices/G644_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG654/fingerprints/ -p candidate_pairs_G654_HHZ -i ${BASE_DIR}global_indices/G654_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG654/fingerprints/ -p candidate_pairs_G654_HH2 -i ${BASE_DIR}global_indices/G654_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG654/fingerprints/ -p candidate_pairs_G654_HH1 -i ${BASE_DIR}global_indices/G654_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG664/fingerprints/ -p candidate_pairs_G664_HHZ -i ${BASE_DIR}global_indices/G664_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG664/fingerprints/ -p candidate_pairs_G664_HH2 -i ${BASE_DIR}global_indices/G664_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG664/fingerprints/ -p candidate_pairs_G664_HH1 -i ${BASE_DIR}global_indices/G664_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG674/fingerprints/ -p candidate_pairs_G674_HHZ -i ${BASE_DIR}global_indices/G674_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG674/fingerprints/ -p candidate_pairs_G674_HH2 -i ${BASE_DIR}global_indices/G674_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG674/fingerprints/ -p candidate_pairs_G674_HH1 -i ${BASE_DIR}global_indices/G674_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG684/fingerprints/ -p candidate_pairs_G684_HHZ -i ${BASE_DIR}global_indices/G684_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG684/fingerprints/ -p candidate_pairs_G684_HH2 -i ${BASE_DIR}global_indices/G684_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG684/fingerprints/ -p candidate_pairs_G684_HH1 -i ${BASE_DIR}global_indices/G684_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsG694/fingerprints/ -p candidate_pairs_G694_HHZ -i ${BASE_DIR}global_indices/G694_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG694/fingerprints/ -p candidate_pairs_G694_HH2 -i ${BASE_DIR}global_indices/G694_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsG694/fingerprints/ -p candidate_pairs_G694_HH1 -i ${BASE_DIR}global_indices/G694_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsHWF4/fingerprints/ -p candidate_pairs_HWF4_HHZ -i ${BASE_DIR}global_indices/HWF4_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsHWF4/fingerprints/ -p candidate_pairs_HWF4_HH2 -i ${BASE_DIR}global_indices/HWF4_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsHWF4/fingerprints/ -p candidate_pairs_HWF4_HH1 -i ${BASE_DIR}global_indices/HWF4_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsT014/fingerprints/ -p candidate_pairs_T014_HHZ -i ${BASE_DIR}global_indices/T014_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT014/fingerprints/ -p candidate_pairs_T014_HH2 -i ${BASE_DIR}global_indices/T014_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT014/fingerprints/ -p candidate_pairs_T014_HH1 -i ${BASE_DIR}global_indices/T014_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsT034/fingerprints/ -p candidate_pairs_T034_HHZ -i ${BASE_DIR}global_indices/T034_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT034/fingerprints/ -p candidate_pairs_T034_HH2 -i ${BASE_DIR}global_indices/T034_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT034/fingerprints/ -p candidate_pairs_T034_HH1 -i ${BASE_DIR}global_indices/T034_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsT054/fingerprints/ -p candidate_pairs_T054_HHZ -i ${BASE_DIR}global_indices/T054_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT054/fingerprints/ -p candidate_pairs_T054_HH2 -i ${BASE_DIR}global_indices/T054_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsT054/fingerprints/ -p candidate_pairs_T054_HH1 -i ${BASE_DIR}global_indices/T054_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsVLW4/fingerprints/ -p candidate_pairs_VLW4_HHZ -i ${BASE_DIR}global_indices/VLW4_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsVLW4/fingerprints/ -p candidate_pairs_VLW4_HH2 -i ${BASE_DIR}global_indices/VLW4_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsVLW4/fingerprints/ -p candidate_pairs_VLW4_HH1 -i ${BASE_DIR}global_indices/VLW4_HH1_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}data/waveformsZLV4/fingerprints/ -p candidate_pairs_ZLV4_HHZ -i ${BASE_DIR}global_indices/ZLV4_HHZ_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsZLV4/fingerprints/ -p candidate_pairs_ZLV4_HH2 -i ${BASE_DIR}global_indices/ZLV4_HH2_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}data/waveformsZLV4/fingerprints/ -p candidate_pairs_ZLV4_HH1 -i ${BASE_DIR}global_indices/ZLV4_HH1_idx_mapping.txt 

