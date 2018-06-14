#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/NCSNSynthetic/fp_input_NCSN_CCOB_EHN_synthetic.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/NCSNSynthetic/global_indices_NCSN_CCOB_EHN_synthetic.json
