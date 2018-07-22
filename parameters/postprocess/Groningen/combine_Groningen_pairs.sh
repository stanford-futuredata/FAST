#!/bin/bash

BASE_DIR=/lfs/1/ceyoon/TimeSeries/Groningen/
COMBINE_DIR=${BASE_DIR}/inputs_network/
#rm -rf ${COMBINE_DIR}
#mkdir ${COMBINE_DIR}
#cp ${BASE_DIR}waveforms*/fingerprints/candidate_pairs_*merged.txt ${COMBINE_DIR}

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G014 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G044 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G034 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G064 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G094 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G104 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G144 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G194 --sort true --parse false -c true -t 6

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G084 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G324 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G454 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G554 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G594 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G604 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G644 --sort true --parse false -c true -t 6

python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_ENM4 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_ENV4 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G024 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G054 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G074 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G114 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G134 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G164 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G174 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G184 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G204 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G214 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G224 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G234 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G244 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G264 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G274 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G304 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G314 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G344 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G364 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G374 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G394 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G404 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G414 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G424 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G434 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G444 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G464 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G494 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G504 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G514 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G524 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G534 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G544 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G564 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G574 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G584 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G614 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G624 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G634 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G654 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G664 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G674 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G684 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_G694 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_HWF4 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_T014 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_T034 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_T054 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_VLW4 --sort true --parse false -c true -t 6
python parse_results.py -d ${COMBINE_DIR} -p candidate_pairs_ZLV4 --sort true --parse false -c true -t 6

echo "Network detection inputs ready at ${COMBINE_DIR}"
