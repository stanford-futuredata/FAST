#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/SaudiFull/
python parse_results.py -d ${BASE_DIR}SA.LNY01/fingerprints/ -p candidate_pairs_LNY01_HHE -i ${BASE_DIR}global_indices/LNY01_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY01/fingerprints/ -p candidate_pairs_LNY01_HHN -i ${BASE_DIR}global_indices/LNY01_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY01/fingerprints/ -p candidate_pairs_LNY01_HHZ -i ${BASE_DIR}global_indices/LNY01_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY02/fingerprints/ -p candidate_pairs_LNY02_HHE -i ${BASE_DIR}global_indices/LNY02_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY02/fingerprints/ -p candidate_pairs_LNY02_HHN -i ${BASE_DIR}global_indices/LNY02_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY02/fingerprints/ -p candidate_pairs_LNY02_HHZ -i ${BASE_DIR}global_indices/LNY02_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY03/fingerprints/ -p candidate_pairs_LNY03_HHE -i ${BASE_DIR}global_indices/LNY03_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY03/fingerprints/ -p candidate_pairs_LNY03_HHN -i ${BASE_DIR}global_indices/LNY03_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY03/fingerprints/ -p candidate_pairs_LNY03_HHZ -i ${BASE_DIR}global_indices/LNY03_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY04/fingerprints/ -p candidate_pairs_LNY04_HHE -i ${BASE_DIR}global_indices/LNY04_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY04/fingerprints/ -p candidate_pairs_LNY04_HHN -i ${BASE_DIR}global_indices/LNY04_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY04/fingerprints/ -p candidate_pairs_LNY04_HHZ -i ${BASE_DIR}global_indices/LNY04_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY05/fingerprints/ -p candidate_pairs_LNY05_HHE -i ${BASE_DIR}global_indices/LNY05_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY05/fingerprints/ -p candidate_pairs_LNY05_HHN -i ${BASE_DIR}global_indices/LNY05_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY05/fingerprints/ -p candidate_pairs_LNY05_HHZ -i ${BASE_DIR}global_indices/LNY05_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY06/fingerprints/ -p candidate_pairs_LNY06_HHE -i ${BASE_DIR}global_indices/LNY06_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY06/fingerprints/ -p candidate_pairs_LNY06_HHN -i ${BASE_DIR}global_indices/LNY06_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY06/fingerprints/ -p candidate_pairs_LNY06_HHZ -i ${BASE_DIR}global_indices/LNY06_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY07/fingerprints/ -p candidate_pairs_LNY07_HHE -i ${BASE_DIR}global_indices/LNY07_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY07/fingerprints/ -p candidate_pairs_LNY07_HHN -i ${BASE_DIR}global_indices/LNY07_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY07/fingerprints/ -p candidate_pairs_LNY07_HHZ -i ${BASE_DIR}global_indices/LNY07_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY08/fingerprints/ -p candidate_pairs_LNY08_HHE -i ${BASE_DIR}global_indices/LNY08_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY08/fingerprints/ -p candidate_pairs_LNY08_HHN -i ${BASE_DIR}global_indices/LNY08_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY08/fingerprints/ -p candidate_pairs_LNY08_HHZ -i ${BASE_DIR}global_indices/LNY08_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY09/fingerprints/ -p candidate_pairs_LNY09_HHE -i ${BASE_DIR}global_indices/LNY09_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY09/fingerprints/ -p candidate_pairs_LNY09_HHN -i ${BASE_DIR}global_indices/LNY09_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY09/fingerprints/ -p candidate_pairs_LNY09_HHZ -i ${BASE_DIR}global_indices/LNY09_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY10/fingerprints/ -p candidate_pairs_LNY10_HHE -i ${BASE_DIR}global_indices/LNY10_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY10/fingerprints/ -p candidate_pairs_LNY10_HHN -i ${BASE_DIR}global_indices/LNY10_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY10/fingerprints/ -p candidate_pairs_LNY10_HHZ -i ${BASE_DIR}global_indices/LNY10_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY11/fingerprints/ -p candidate_pairs_LNY11_HHE -i ${BASE_DIR}global_indices/LNY11_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY11/fingerprints/ -p candidate_pairs_LNY11_HHN -i ${BASE_DIR}global_indices/LNY11_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY11/fingerprints/ -p candidate_pairs_LNY11_HHZ -i ${BASE_DIR}global_indices/LNY11_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY12/fingerprints/ -p candidate_pairs_LNY12_HHE -i ${BASE_DIR}global_indices/LNY12_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY12/fingerprints/ -p candidate_pairs_LNY12_HHN -i ${BASE_DIR}global_indices/LNY12_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY12/fingerprints/ -p candidate_pairs_LNY12_HHZ -i ${BASE_DIR}global_indices/LNY12_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY13/fingerprints/ -p candidate_pairs_LNY13_HHE -i ${BASE_DIR}global_indices/LNY13_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY13/fingerprints/ -p candidate_pairs_LNY13_HHN -i ${BASE_DIR}global_indices/LNY13_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY13/fingerprints/ -p candidate_pairs_LNY13_HHZ -i ${BASE_DIR}global_indices/LNY13_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY14/fingerprints/ -p candidate_pairs_LNY14_HHE -i ${BASE_DIR}global_indices/LNY14_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY14/fingerprints/ -p candidate_pairs_LNY14_HHN -i ${BASE_DIR}global_indices/LNY14_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY14/fingerprints/ -p candidate_pairs_LNY14_HHZ -i ${BASE_DIR}global_indices/LNY14_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY15/fingerprints/ -p candidate_pairs_LNY15_HHE -i ${BASE_DIR}global_indices/LNY15_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY15/fingerprints/ -p candidate_pairs_LNY15_HHN -i ${BASE_DIR}global_indices/LNY15_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY15/fingerprints/ -p candidate_pairs_LNY15_HHZ -i ${BASE_DIR}global_indices/LNY15_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY16/fingerprints/ -p candidate_pairs_LNY16_HHE -i ${BASE_DIR}global_indices/LNY16_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY16/fingerprints/ -p candidate_pairs_LNY16_HHN -i ${BASE_DIR}global_indices/LNY16_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY16/fingerprints/ -p candidate_pairs_LNY16_HHZ -i ${BASE_DIR}global_indices/LNY16_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNY17/fingerprints/ -p candidate_pairs_LNY17_HHE -i ${BASE_DIR}global_indices/LNY17_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY17/fingerprints/ -p candidate_pairs_LNY17_HHN -i ${BASE_DIR}global_indices/LNY17_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNY17/fingerprints/ -p candidate_pairs_LNY17_HHZ -i ${BASE_DIR}global_indices/LNY17_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.LNYS/fingerprints/ -p candidate_pairs_LNYS_HHE -i ${BASE_DIR}global_indices/LNYS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNYS/fingerprints/ -p candidate_pairs_LNYS_HHN -i ${BASE_DIR}global_indices/LNYS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.LNYS/fingerprints/ -p candidate_pairs_LNYS_HHZ -i ${BASE_DIR}global_indices/LNYS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.MURBA/fingerprints/ -p candidate_pairs_MURBA_HHE -i ${BASE_DIR}global_indices/MURBA_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.MURBA/fingerprints/ -p candidate_pairs_MURBA_HHN -i ${BASE_DIR}global_indices/MURBA_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.MURBA/fingerprints/ -p candidate_pairs_MURBA_HHZ -i ${BASE_DIR}global_indices/MURBA_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.NUMJS/fingerprints/ -p candidate_pairs_NUMJS_HHE -i ${BASE_DIR}global_indices/NUMJS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.NUMJS/fingerprints/ -p candidate_pairs_NUMJS_HHN -i ${BASE_DIR}global_indices/NUMJS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.NUMJS/fingerprints/ -p candidate_pairs_NUMJS_HHZ -i ${BASE_DIR}global_indices/NUMJS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.OLAS/fingerprints/ -p candidate_pairs_OLAS_HHE -i ${BASE_DIR}global_indices/OLAS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.OLAS/fingerprints/ -p candidate_pairs_OLAS_HHN -i ${BASE_DIR}global_indices/OLAS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.OLAS/fingerprints/ -p candidate_pairs_OLAS_HHZ -i ${BASE_DIR}global_indices/OLAS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.SUMJS/fingerprints/ -p candidate_pairs_SUMJS_HHE -i ${BASE_DIR}global_indices/SUMJS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.SUMJS/fingerprints/ -p candidate_pairs_SUMJS_HHN -i ${BASE_DIR}global_indices/SUMJS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.SUMJS/fingerprints/ -p candidate_pairs_SUMJS_HHZ -i ${BASE_DIR}global_indices/SUMJS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJS/fingerprints/ -p candidate_pairs_UMJS_HHE -i ${BASE_DIR}global_indices/UMJS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJS/fingerprints/ -p candidate_pairs_UMJS_HHN -i ${BASE_DIR}global_indices/UMJS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJS/fingerprints/ -p candidate_pairs_UMJS_HHZ -i ${BASE_DIR}global_indices/UMJS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ01/fingerprints/ -p candidate_pairs_UMJ01_HHE -i ${BASE_DIR}global_indices/UMJ01_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ01/fingerprints/ -p candidate_pairs_UMJ01_HHN -i ${BASE_DIR}global_indices/UMJ01_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ01/fingerprints/ -p candidate_pairs_UMJ01_HHZ -i ${BASE_DIR}global_indices/UMJ01_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ03/fingerprints/ -p candidate_pairs_UMJ03_HHE -i ${BASE_DIR}global_indices/UMJ03_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ03/fingerprints/ -p candidate_pairs_UMJ03_HHN -i ${BASE_DIR}global_indices/UMJ03_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ03/fingerprints/ -p candidate_pairs_UMJ03_HHZ -i ${BASE_DIR}global_indices/UMJ03_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ04/fingerprints/ -p candidate_pairs_UMJ04_HHE -i ${BASE_DIR}global_indices/UMJ04_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ04/fingerprints/ -p candidate_pairs_UMJ04_HHN -i ${BASE_DIR}global_indices/UMJ04_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ04/fingerprints/ -p candidate_pairs_UMJ04_HHZ -i ${BASE_DIR}global_indices/UMJ04_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ05/fingerprints/ -p candidate_pairs_UMJ05_HHE -i ${BASE_DIR}global_indices/UMJ05_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ05/fingerprints/ -p candidate_pairs_UMJ05_HHN -i ${BASE_DIR}global_indices/UMJ05_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ05/fingerprints/ -p candidate_pairs_UMJ05_HHZ -i ${BASE_DIR}global_indices/UMJ05_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ06/fingerprints/ -p candidate_pairs_UMJ06_HHE -i ${BASE_DIR}global_indices/UMJ06_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ06/fingerprints/ -p candidate_pairs_UMJ06_HHN -i ${BASE_DIR}global_indices/UMJ06_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ06/fingerprints/ -p candidate_pairs_UMJ06_HHZ -i ${BASE_DIR}global_indices/UMJ06_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ07/fingerprints/ -p candidate_pairs_UMJ07_HHE -i ${BASE_DIR}global_indices/UMJ07_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ07/fingerprints/ -p candidate_pairs_UMJ07_HHN -i ${BASE_DIR}global_indices/UMJ07_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ07/fingerprints/ -p candidate_pairs_UMJ07_HHZ -i ${BASE_DIR}global_indices/UMJ07_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ08/fingerprints/ -p candidate_pairs_UMJ08_HHE -i ${BASE_DIR}global_indices/UMJ08_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ08/fingerprints/ -p candidate_pairs_UMJ08_HHN -i ${BASE_DIR}global_indices/UMJ08_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ08/fingerprints/ -p candidate_pairs_UMJ08_HHZ -i ${BASE_DIR}global_indices/UMJ08_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ09/fingerprints/ -p candidate_pairs_UMJ09_HHE -i ${BASE_DIR}global_indices/UMJ09_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ09/fingerprints/ -p candidate_pairs_UMJ09_HHN -i ${BASE_DIR}global_indices/UMJ09_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ09/fingerprints/ -p candidate_pairs_UMJ09_HHZ -i ${BASE_DIR}global_indices/UMJ09_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ10/fingerprints/ -p candidate_pairs_UMJ10_HHE -i ${BASE_DIR}global_indices/UMJ10_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ10/fingerprints/ -p candidate_pairs_UMJ10_HHN -i ${BASE_DIR}global_indices/UMJ10_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ10/fingerprints/ -p candidate_pairs_UMJ10_HHZ -i ${BASE_DIR}global_indices/UMJ10_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ11/fingerprints/ -p candidate_pairs_UMJ11_HHE -i ${BASE_DIR}global_indices/UMJ11_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ11/fingerprints/ -p candidate_pairs_UMJ11_HHN -i ${BASE_DIR}global_indices/UMJ11_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ11/fingerprints/ -p candidate_pairs_UMJ11_HHZ -i ${BASE_DIR}global_indices/UMJ11_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ12/fingerprints/ -p candidate_pairs_UMJ12_HHE -i ${BASE_DIR}global_indices/UMJ12_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ12/fingerprints/ -p candidate_pairs_UMJ12_HHN -i ${BASE_DIR}global_indices/UMJ12_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.UMJ12/fingerprints/ -p candidate_pairs_UMJ12_HHZ -i ${BASE_DIR}global_indices/UMJ12_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.EWJHS/fingerprints/ -p candidate_pairs_EWJHS_HHE -i ${BASE_DIR}global_indices/EWJHS_HHE_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.EWJHS/fingerprints/ -p candidate_pairs_EWJHS_HHN -i ${BASE_DIR}global_indices/EWJHS_HHN_idx_mapping.txt 
python parse_results.py -d ${BASE_DIR}SA.EWJHS/fingerprints/ -p candidate_pairs_EWJHS_HHZ -i ${BASE_DIR}global_indices/EWJHS_HHZ_idx_mapping.txt 

python parse_results.py -d ${BASE_DIR}SA.UMJ02/fingerprints/ -p candidate_pairs_UMJ02_HHE -i ${BASE_DIR}global_indices/UMJ02_HHE_idx_mapping.txt 
