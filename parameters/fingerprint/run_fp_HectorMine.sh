#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_CPM_EHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_GTM_EHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_HEC_BHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_HEC_BHN.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_HEC_BHE.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_RMM_EHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_RMR_EHZ.json
python gen_fp.py ../parameters/fingerprint/fp_input_CI_TPC_EHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/global_indices.json
