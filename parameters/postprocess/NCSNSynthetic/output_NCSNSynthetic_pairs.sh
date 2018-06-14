#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/NCSN/CCOB/
python parse_results.py -d ${BASE_DIR}fingerprints/ -p candidate_pairs_CCOB_EHN -i ${BASE_DIR}global_indices/CCOB_EHN_idx_mapping.txt
