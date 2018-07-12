#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}CES*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_CES02 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_CES06 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_CES08 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_CES09 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_CES04 --sort true --parse false -c true -t 6

echo "Network detection inputs ready at ${COMBINE_DIR}"
