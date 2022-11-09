#!/bin/bash

rm -rf ../data/inputs_network/
mkdir ../data/inputs_network/
cp ../data/waveforms_mdl_BP/fingerprints/candidate_pairs_*merged.txt ../data/inputs_network/
# python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_* --sort true --parse false -c true -t 6

# SKIPPED NSS2 SWS CLI2 WLA06

python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_TONN --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_BOM --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_CRR --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_DRE --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_FRK --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_IMP --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_NSS2 --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_SWS --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_286 --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_5274 --sort true --parse false -c true -t 6
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_WLA06 --sort true --parse false -c true -t 6

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_TONN_HNZ_merged.txt > ../data/inputs_network/candidate_pairs_TONN_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_TONN_HNN_merged.txt > ../data/inputs_network/candidate_pairs_TONN_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_TONN_HNE_merged.txt > ../data/inputs_network/candidate_pairs_TONN_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_BOM_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_BOM_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_BOM_HHE_merged.txt > ../data/inputs_network/candidate_pairs_BOM_combined.txt

awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CLI2_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_CLI2_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CRR_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_CRR_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CRR_HHN_merged.txt > ../data/inputs_network/candidate_pairs_CRR_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CRR_HHE_merged.txt > ../data/inputs_network/candidate_pairs_CRR_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_DRE_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_DRE_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_DRE_HHN_merged.txt > ../data/inputs_network/candidate_pairs_DRE_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_DRE_HHE_merged.txt > ../data/inputs_network/candidate_pairs_DRE_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_FRK_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_FRK_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_FRK_HHN_merged.txt > ../data/inputs_network/candidate_pairs_FRK_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_FRK_HHE_merged.txt > ../data/inputs_network/candidate_pairs_FRK_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_IMP_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_IMP_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_IMP_HHN_merged.txt > ../data/inputs_network/candidate_pairs_IMP_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_IMP_HHE_merged.txt > ../data/inputs_network/candidate_pairs_IMP_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_NSS2_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_NSS2_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_NSS2_HHN_merged.txt > ../data/inputs_network/candidate_pairs_NSS2_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_NSS2_HHE_merged.txt > ../data/inputs_network/candidate_pairs_NSS2_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_SWS_HHZ_merged.txt > ../data/inputs_network/candidate_pairs_SWS_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_SWS_HHN_merged.txt > ../data/inputs_network/candidate_pairs_SWS_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_SWS_HHE_merged.txt > ../data/inputs_network/candidate_pairs_SWS_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_286_HNZ_merged.txt > ../data/inputs_network/candidate_pairs_286_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_286_HNN_merged.txt > ../data/inputs_network/candidate_pairs_286_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_286_HNE_merged.txt > ../data/inputs_network/candidate_pairs_286_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_5274_HNZ_merged.txt > ../data/inputs_network/candidate_pairs_5274_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_5274_HNN_merged.txt > ../data/inputs_network/candidate_pairs_5274_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_5274_HNE_merged.txt > ../data/inputs_network/candidate_pairs_5274_combined.txt

# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_WLA06_HNZ_merged.txt > ../data/inputs_network/candidate_pairs_WLA06_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_WLA06_HNN_merged.txt > ../data/inputs_network/candidate_pairs_WLA06_combined.txt
# awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_WLA06_HNE_merged.txt > ../data/inputs_network/candidate_pairs_WLA06_combined.txt


echo "Network detection inputs ready at ../data/inputs_network/"
