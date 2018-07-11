#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKAK_EHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKFG_BHE.json
python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKFG_BHN.json
python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKFG_BHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKRE_EHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKSO_BHE.json
python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKSO_BHN.json
python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKSO_BHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKSP_EHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKWE_EHZ.json

python gen_fp.py ../parameters/fingerprint/Okmok/fp_input_AVO_OKWR_EHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/Okmok/global_indices_Okmok.json
