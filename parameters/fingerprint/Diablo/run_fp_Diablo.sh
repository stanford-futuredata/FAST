#!/bin/bash

# Create fingerprints

# dawn12
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DCD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DCD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DCD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_EFD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_EFD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_EFD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_MLD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_MLD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_MLD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_NC_PPB_EHZ.json


# dawn9
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DPD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DPD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_DPD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_EC_EHZ.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_SH_EHZ.json


# dawn7
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LMD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LMD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LMD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LSD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LSD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_LSD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_SHD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_SHD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_SHD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_VPD_EHZ.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_VPD_EHN.json
python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_PG_VPD_EHE.json

python gen_fp.py ../parameters/fingerprint/Diablo/fp_input_NC_PABB_EHZ.json


# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/Diablo/global_indices_Diablo.json
