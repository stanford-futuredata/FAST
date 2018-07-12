#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/AllWenchuan/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}/after/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.HSH --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.JJS --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.JMG --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.MXI --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.PWU --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.QCH --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.SPA --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.XCO --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.XJI --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.YGD --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_XX.YZP --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_GS.WDT --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_GS.WXT --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_SN.LUYA --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_SN.MIAX --sort true --parse false -c true -t 6

echo "Network detection inputs ready at ${COMBINE_DIR}"
