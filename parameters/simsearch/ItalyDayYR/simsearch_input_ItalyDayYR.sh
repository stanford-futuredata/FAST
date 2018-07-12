#!/bin/bash

# Name the job in Grid Engine
#$ -N simsearch

#tell grid engine to use current directory
#$ -cwd

# Set Email Address where notifications are to be sent, you need to use your Stanford email address.
#$ -M ceyoon@stanford.edu

# Tell Grid Engine to notify job owner if job 'b'egins, 'e'nds, 's'uspended is 'a'borted, or 'n'o mail
#$ -m besa

# Tel Grid Engine to join normal output and error output into one file
#$ -j y

echo "Entered at command line, Station: $1"
echo "Entered at command line, Channel: $2"

# Default values
STATION=${1:-ED01}
CHANNEL=${2:-HHZ}

BASE_DIR=/lfs/1/ceyoon/TimeSeries/ItalyDay/day303
DATA_DIR=${BASE_DIR}/fingerprints/
echo $DATA_DIR

FPDIM_FILE=${BASE_DIR}/${STATION}_${CHANNEL}.json
NDIM=`cat "${FPDIM_FILE}" | jq '.ndim'`
NFP=`cat "${FPDIM_FILE}" | jq '.nfp'`
echo $STATION
echo $CHANNEL
echo "NFP="$NFP
echo "NDIM="$NDIM

NTBLS=100
NHASH=4
NREPEAT=5
NVOTES=2
NTHREAD=16
NUM_PART=1
echo "NTBLS="$NTBLS
echo "NHASH="$NHASH
echo "NREPEAT="$NREPEAT
echo "NVOTES="$NVOTES
echo "NTHREAD="$NTHREAD
echo "NUM_PART="$NUM_PART

./main --input_fp_file=$DATA_DIR/${STATION}.${CHANNEL}.fp \
       --output_minhash_sigs_file=$DATA_DIR/mh_${STATION}_${CHANNEL}.bin \
       --output_pairs_file=$DATA_DIR/candidate_pairs_${STATION}_${CHANNEL}.txt \
       --ntbls $NTBLS \
       --nhash $NHASH \
       --ncols $NFP \
       --mrows $NDIM \
       --near_repeats $NREPEAT \
       --nvotes $NVOTES \
       --ncores $NTHREAD \
       --num_partitions $NUM_PART
echo "**********************************************************************************"
