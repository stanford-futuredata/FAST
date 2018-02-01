#!/bin/bash

rm -rf ../data/inputs_network/
mkdir ../data/inputs_network/
cp ../data/waveforms*/fingerprints/candidate_pairs_*merged.txt ../data/inputs_network/
python parse_results.py -d ../data/inputs_network/ -p candidate_pairs_HEC --sort true --parse false -c true -t 6

awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CDY_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_CDY_combined.txt
awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_CPM_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_CPM_combined.txt
awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_GTM_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_GTM_combined.txt
awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_RMM_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_RMM_combined.txt
awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_RMR_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_RMR_combined.txt
awk '{print $1, $2, 3*$3}' ../data/inputs_network/candidate_pairs_TPC_EHZ_merged.txt > ../data/inputs_network/candidate_pairs_TPC_combined.txt

echo "Network detection inputs ready at ../data/inputs_network/"
