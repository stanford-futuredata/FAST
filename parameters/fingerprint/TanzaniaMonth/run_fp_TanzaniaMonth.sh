#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES02_HNZ.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES02_HNN.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES02_HNE.json

python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES06_HNZ.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES06_HNN.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES06_HNE.json

python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES08_HNZ.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES08_HNN.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES08_HNE.json

python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES09_HNZ.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES09_HNN.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES09_HNE.json

python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES04_HNZ.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES04_HNN.json
python gen_fp.py ../parameters/fingerprint/TanzaniaMonth/fp_input_TZ_CES04_HNE.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/TanzaniaMonth/global_indices_TanzaniaMonth.json

