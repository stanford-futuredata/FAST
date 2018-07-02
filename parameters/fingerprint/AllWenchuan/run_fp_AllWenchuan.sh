#!/bin/bash

# Create fingerprints
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_HSH_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_HSH_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_HSH_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JJS_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JJS_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JJS_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JMG_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JMG_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_JMG_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_MXI_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_MXI_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_MXI_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_PWU_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_PWU_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_PWU_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_QCH_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_QCH_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_QCH_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_SPA_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_SPA_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_SPA_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XCO_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XCO_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XCO_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XJI_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XJI_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_XJI_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YGD_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YGD_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YGD_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YZP_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YZP_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_XX_YZP_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WDT_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WDT_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WDT_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WXT_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WXT_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_GS_WXT_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_LUYA_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_LUYA_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_LUYA_BHZ.json

python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_MIAX_BHE.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_MIAX_BHN.json
python gen_fp.py ../parameters/fingerprint/AllWenchuan/fp_input_SN_MIAX_BHZ.json

# Global index: after all fingerprints are done
python global_index.py ../parameters/fingerprint/AllWenchuan/global_indices_AllWenchuan.json

