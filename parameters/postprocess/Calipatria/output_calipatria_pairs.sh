#!/bin/bash

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsUSGCB/fingerprints/ -p candidate_pairs_USGCB_HNE -i ../data/global_indices/USGCB_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsUSGCB/fingerprints/ -p candidate_pairs_USGCB_HNN -i ../data/global_indices/USGCB_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsUSGCB/fingerprints/ -p candidate_pairs_USGCB_HNZ -i ../data/global_indices/USGCB_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBC3/fingerprints/ -p candidate_pairs_BC3_HHZ -i ../data/global_indices/BC3_HHZ_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBC3/fingerprints/ -p candidate_pairs_BC3_HHN -i ../data/global_indices/BC3_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBC3/fingerprints/ -p candidate_pairs_BC3_HHE -i ../data/global_indices/BC3_HHE_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBOM/fingerprints/ -p candidate_pairs_BOM_HHZ -i ../data/global_indices/BOM_HHZ_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBOM/fingerprints/ -p candidate_pairs_BOM_HHN -i ../data/global_indices/BOM_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsBOM/fingerprints/ -p candidate_pairs_BOM_HHE -i ../data/global_indices/BOM_HHE_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCLI2/fingerprints/ -p candidate_pairs_CLI2_EHZ -i ../data/global_indices/CLI2_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCOA/fingerprints/ -p candidate_pairs_COA_HHZ -i ../data/global_indices/COA_HHZ_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCOA/fingerprints/ -p candidate_pairs_COA_HHN -i ../data/global_indices/COA_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCOA/fingerprints/ -p candidate_pairs_COA_HHE -i ../data/global_indices/COA_HHE_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCOK2/fingerprints/ -p candidate_pairs_COK2_EHZ -i ../data/global_indices/COK2_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCRR/fingerprints/ -p candidate_pairs_CRR_HHE -i ../data/global_indices/CRR_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCRR/fingerprints/ -p candidate_pairs_CRR_HHN -i ../data/global_indices/CRR_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCRR/fingerprints/ -p candidate_pairs_CRR_HHZ -i ../data/global_indices/CRR_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTC/fingerprints/ -p candidate_pairs_CTC_HHE -i ../data/global_indices/CTC_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTC/fingerprints/ -p candidate_pairs_CTC_HHN -i ../data/global_indices/CTC_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTC/fingerprints/ -p candidate_pairs_CTC_HHZ -i ../data/global_indices/CTC_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTW/fingerprints/ -p candidate_pairs_CTW_HHE -i ../data/global_indices/CTW_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTW/fingerprints/ -p candidate_pairs_CTW_HHN -i ../data/global_indices/CTW_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsCTW/fingerprints/ -p candidate_pairs_CTW_HHZ -i ../data/global_indices/CTW_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsDRE/fingerprints/ -p candidate_pairs_DRE_HHE -i ../data/global_indices/DRE_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsDRE/fingerprints/ -p candidate_pairs_DRE_HHN -i ../data/global_indices/DRE_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsDRE/fingerprints/ -p candidate_pairs_DRE_HHZ -i ../data/global_indices/DRE_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsERR/fingerprints/ -p candidate_pairs_ERR_HHE -i ../data/global_indices/ERR_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsERR/fingerprints/ -p candidate_pairs_ERR_HHN -i ../data/global_indices/ERR_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsERR/fingerprints/ -p candidate_pairs_ERR_HHZ -i ../data/global_indices/ERR_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsFRK/fingerprints/ -p candidate_pairs_FRK_HHE -i ../data/global_indices/FRK_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsFRK/fingerprints/ -p candidate_pairs_FRK_HHN -i ../data/global_indices/FRK_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsFRK/fingerprints/ -p candidate_pairs_FRK_HHZ -i ../data/global_indices/FRK_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsIMP/fingerprints/ -p candidate_pairs_IMP_HHE -i ../data/global_indices/IMP_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsIMP/fingerprints/ -p candidate_pairs_IMP_HHN -i ../data/global_indices/IMP_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsIMP/fingerprints/ -p candidate_pairs_IMP_HHZ -i ../data/global_indices/IMP_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsNSS2/fingerprints/ -p candidate_pairs_NSS2_HHE -i ../data/global_indices/NSS2_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsNSS2/fingerprints/ -p candidate_pairs_NSS2_HHN -i ../data/global_indices/NSS2_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsNSS2/fingerprints/ -p candidate_pairs_NSS2_HHZ -i ../data/global_indices/NSS2_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsOCP/fingerprints/ -p candidate_pairs_OCP_EHZ -i ../data/global_indices/OCP_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsRXH/fingerprints/ -p candidate_pairs_RXH_HHE -i ../data/global_indices/RXH_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsRXH/fingerprints/ -p candidate_pairs_RXH_HHN -i ../data/global_indices/RXH_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsRXH/fingerprints/ -p candidate_pairs_RXH_HHZ -i ../data/global_indices/RXH_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSAL/fingerprints/ -p candidate_pairs_SAL_EHZ -i ../data/global_indices/SAL_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLB/fingerprints/ -p candidate_pairs_SLB_HHE -i ../data/global_indices/SLB_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLB/fingerprints/ -p candidate_pairs_SLB_HHN -i ../data/global_indices/SLB_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLB/fingerprints/ -p candidate_pairs_SLB_HHZ -i ../data/global_indices/SLB_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLV/fingerprints/ -p candidate_pairs_SLV_HHE -i ../data/global_indices/SLV_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLV/fingerprints/ -p candidate_pairs_SLV_HHN -i ../data/global_indices/SLV_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSLV/fingerprints/ -p candidate_pairs_SLV_HHZ -i ../data/global_indices/SLV_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSNR/fingerprints/ -p candidate_pairs_SNR_HHE -i ../data/global_indices/SNR_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSNR/fingerprints/ -p candidate_pairs_SNR_HHN -i ../data/global_indices/SNR_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSNR/fingerprints/ -p candidate_pairs_SNR_HHZ -i ../data/global_indices/SNR_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWP/fingerprints/ -p candidate_pairs_SWP_HHE -i ../data/global_indices/SWP_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWP/fingerprints/ -p candidate_pairs_SWP_HHN -i ../data/global_indices/SWP_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWP/fingerprints/ -p candidate_pairs_SWP_HHZ -i ../data/global_indices/SWP_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWS/fingerprints/ -p candidate_pairs_SWS_HHE -i ../data/global_indices/SWS_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWS/fingerprints/ -p candidate_pairs_SWS_HHN -i ../data/global_indices/SWS_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsSWS/fingerprints/ -p candidate_pairs_SWS_HHZ -i ../data/global_indices/SWS_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsTHM/fingerprints/ -p candidate_pairs_THM_HHE -i ../data/global_indices/THM_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsTHM/fingerprints/ -p candidate_pairs_THM_HHN -i ../data/global_indices/THM_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsTHM/fingerprints/ -p candidate_pairs_THM_HHZ -i ../data/global_indices/THM_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWMD/fingerprints/ -p candidate_pairs_WMD_HHE -i ../data/global_indices/WMD_HHE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWMD/fingerprints/ -p candidate_pairs_WMD_HHN -i ../data/global_indices/WMD_HHN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWMD/fingerprints/ -p candidate_pairs_WMD_HHZ -i ../data/global_indices/WMD_HHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWWF/fingerprints/ -p candidate_pairs_WWF_EHZ -i ../data/global_indices/WWF_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms286/fingerprints/ -p candidate_pairs_286_HNE -i ../data/global_indices/286_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms286/fingerprints/ -p candidate_pairs_286_HNN -i ../data/global_indices/286_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms286/fingerprints/ -p candidate_pairs_286_HNZ -i ../data/global_indices/286_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5056/fingerprints/ -p candidate_pairs_5056_HNE -i ../data/global_indices/5056_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5056/fingerprints/ -p candidate_pairs_5056_HNN -i ../data/global_indices/5056_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5056/fingerprints/ -p candidate_pairs_5056_HNZ -i ../data/global_indices/5056_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5058/fingerprints/ -p candidate_pairs_5058_HNE -i ../data/global_indices/5058_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5058/fingerprints/ -p candidate_pairs_5058_HNN -i ../data/global_indices/5058_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5058/fingerprints/ -p candidate_pairs_5058_HNZ -i ../data/global_indices/5058_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5062/fingerprints/ -p candidate_pairs_5062_EHZ -i ../data/global_indices/5062_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5271/fingerprints/ -p candidate_pairs_5271_EHZ -i ../data/global_indices/5271_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5274/fingerprints/ -p candidate_pairs_5274_HNE -i ../data/global_indices/5274_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5274/fingerprints/ -p candidate_pairs_5274_HNN -i ../data/global_indices/5274_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5274/fingerprints/ -p candidate_pairs_5274_HNZ -i ../data/global_indices/5274_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveforms5444/fingerprints/ -p candidate_pairs_5444_EHZ -i ../data/global_indices/5444_EHZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA/fingerprints/ -p candidate_pairs_WLA_HNE -i ../data/global_indices/WLA_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA/fingerprints/ -p candidate_pairs_WLA_HNN -i ../data/global_indices/WLA_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA/fingerprints/ -p candidate_pairs_WLA_HNZ -i ../data/global_indices/WLA_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA01/fingerprints/ -p candidate_pairs_WLA01_HNE -i ../data/global_indices/WLA01_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA01/fingerprints/ -p candidate_pairs_WLA01_HNN -i ../data/global_indices/WLA01_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA01/fingerprints/ -p candidate_pairs_WLA01_HNZ -i ../data/global_indices/WLA01_HNZ_idx_mapping.txt 
#
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA03/fingerprints/ -p candidate_pairs_WLA03_HNE -i ../data/global_indices/WLA03_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA03/fingerprints/ -p candidate_pairs_WLA03_HNN -i ../data/global_indices/WLA03_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA03/fingerprints/ -p candidate_pairs_WLA03_HNZ -i ../data/global_indices/WLA03_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA04/fingerprints/ -p candidate_pairs_WLA04_HNE -i ../data/global_indices/WLA04_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA04/fingerprints/ -p candidate_pairs_WLA04_HNN -i ../data/global_indices/WLA04_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA04/fingerprints/ -p candidate_pairs_WLA04_HNZ -i ../data/global_indices/WLA04_HNZ_idx_mapping.txt 

python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA06/fingerprints/ -p candidate_pairs_WLA06_HNE -i ../data/global_indices/WLA06_HNE_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA06/fingerprints/ -p candidate_pairs_WLA06_HNN -i ../data/global_indices/WLA06_HNN_idx_mapping.txt 
python parse_results.py -d ../data/20210605_Calipatria_Data/waveformsWLA06/fingerprints/ -p candidate_pairs_WLA06_HNZ -i ../data/global_indices/WLA06_HNZ_idx_mapping.txt 
 
