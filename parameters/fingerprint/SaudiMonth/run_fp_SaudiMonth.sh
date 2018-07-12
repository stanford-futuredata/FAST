#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY02_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY02_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY02_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY03_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY03_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY03_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY04_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY04_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY04_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY05_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY05_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY05_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY06_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY06_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY06_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY07_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY07_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY07_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY08_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY08_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY08_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY09_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY09_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY09_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY10_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY10_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY10_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY11_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY11_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY11_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY12_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY12_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY12_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY13_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY13_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY13_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY14_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY14_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY14_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY15_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY15_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY15_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY16_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY16_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY16_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY17_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY17_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY17_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNYS_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNYS_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNYS_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_TRAS_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_TRAS_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_TRAS_HHE.json

python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY01_HHZ.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY01_HHN.json
python gen_fp.py ../parameters/fingerprint/SaudiMonth/fp_input_SA_LNY01_HHE.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/SaudiMonth/global_indices_SaudiMonth.json
