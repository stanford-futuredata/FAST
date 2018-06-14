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
STATION=${1:-CCOB}
CHANNEL=${2:-EHN}

BASE_DIR=/lfs/1/ceyoon/TimeSeries/NCSN/${STATION}
DATA_DIR=${BASE_DIR}/fingerprints/
echo $DATA_DIR

#NDIM=4096
#NFP=43181
FPDIM_FILE=${BASE_DIR}/${STATION}_${CHANNEL}.json
NDIM=`cat "${FPDIM_FILE}" | jq '.ndim'`
NFP=`cat "${FPDIM_FILE}" | jq '.nfp'`
echo $STATION
echo $CHANNEL
echo "NFP="$NFP
echo "NDIM="$NDIM

NTBLS=100
NHASH=5
NREPEAT=5
NVOTES=4
NTHREAD=8
NUM_PART=1
echo "NTBLS="$NTBLS
echo "NHASH="$NHASH
echo "NREPEAT="$NREPEAT
echo "NVOTES="$NVOTES
echo "NTHREAD="$NTHREAD
echo "NUM_PART="$NUM_PART

#./main --input_fp_file=$DATA_DIR/fp_synthetic.12hr.24.36.amp0.02.NC.${STATION}.${CHANNEL}.D.bp4to10.deci5 \
#./main --input_fp_file=$DATA_DIR/fp_synthetic.12hr.24.36.amp0.01.NC.${STATION}.${CHANNEL}.D.bp4to10.deci5 \
#./main --input_fp_file=$DATA_DIR/fp_synthetic.12hr.24.36.amp0.04.NC.${STATION}.${CHANNEL}.D.bp4to10.deci5 \
#./main --input_fp_file=$DATA_DIR/fp_synthetic.12hr.24.36.amp0.05.NC.${STATION}.${CHANNEL}.D.bp4to10.deci5 \
./main --input_fp_file=$DATA_DIR/fp_synthetic.12hr.24.36.amp0.03.NC.${STATION}.${CHANNEL}.D.bp4to10.deci5 \
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
