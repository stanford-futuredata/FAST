#!/bin/bash

rm -rf ../data/20210605_Calipatria_Data/inputs_network/
mkdir ../data/20210605_Calipatria_Data/inputs_network/
cp ../data/20210605_Calipatria_Data/waveforms*/fingerprints/candidate_pairs_*merged.txt ../data/20210605_Calipatria_Data/inputs_network/


python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_USGCB --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_BC3 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_BOM --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_COA --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_CRR --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_CTC --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_CTW --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_DRE --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_ERR --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_FRK --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_IMP --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_NSS2 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_RXH --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_SLB --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_SLV --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_SNR --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_SWP --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_SWS --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_THM --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_WMD --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_286 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_5056 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_5058 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_5274 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_WLA01 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_WLA03 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_WLA04 --sort true --parse false -c true -t 6

python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/ -p candidate_pairs_WLA06 --sort true --parse false -c true -t 6

awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_CLI2_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_CLI2_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_COK2_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_COK2_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_OCP_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_OCP_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_SAL_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_SAL_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_WWF_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_WWF_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5062_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5062_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5271_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5271_combined.txt
awk '{print $1, $2, 3*$3}' ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5444_EHZ_merged.txt > ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_5444_combined.txt

# Special case WLA: substring of other station names (WLA01, WLA03, WLA04, WLA06) so need to handle WLA in a separate folder
mkdir ../data/20210605_Calipatria_Data/inputs_network/temp/
mv ../data/20210605_Calipatria_Data/inputs_network/candidate_pairs_WLA_*merged.txt ../data/20210605_Calipatria_Data/inputs_network/temp/
python parse_results.py -d ../data/20210605_Calipatria_Data/inputs_network/temp/ -p candidate_pairs_WLA --sort true --parse false -c true -t 6
cd ../data/20210605_Calipatria_Data/inputs_network/temp/
mv candidate_pairs_WLA_* ../
cd ..
rm -r temp/

echo "Network detection inputs ready at ../data/20210605_Calipatria_Data/inputs_network/"
