#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/BrazilAcre/fp_input_BR_CZSB_HHE.json
python gen_fp.py ../parameters/fingerprint/BrazilAcre/fp_input_BR_CZSB_HHN.json
python gen_fp.py ../parameters/fingerprint/BrazilAcre/fp_input_BR_CZSB_HHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/BrazilAcre/global_indices_BrazilAcre.json
