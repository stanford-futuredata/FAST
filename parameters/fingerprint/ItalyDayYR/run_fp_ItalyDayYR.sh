#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED01_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED02_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED03_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED04_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED05_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED06_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED07_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED09_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED10_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED11_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED12_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED14_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED15_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED16_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED17_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED18_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED19_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED20_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED21_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED23_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED24_HHZ.json
python gen_fp.py ../parameters/fingerprint/ItalyDayYR/fp_input_YR_ED25_HHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/ItalyDayYR/global_indices_ItalyDayYR.json
