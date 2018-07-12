#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/Ometepec/fp_input_IG_PNIG_HHE.json
python gen_fp.py ../parameters/fingerprint/Ometepec/fp_input_IG_PNIG_HHN.json
python gen_fp.py ../parameters/fingerprint/Ometepec/fp_input_IG_PNIG_HHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/Ometepec/global_indices_Ometepec.json
