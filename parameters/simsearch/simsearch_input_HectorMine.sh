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


##STATION=CDY
#STATION=RMM
#CHANNEL=EHZ
#NFP=74793
#IN_STR=''

#STATION=CPM
#CHANNEL=EHZ
#NFP=74796
#IN_STR='.hp1'

#STATION=HEC
##CHANNEL=BHE
##NFP=74798
##CHANNEL=BHN
#CHANNEL=BHZ
#NFP=74792
#IN_STR='.hp2'

#STATION=GTM
#CHANNEL=EHZ
#NFP=74796
#IN_STR='.bp1to6'

#STATION=RMR
#CHANNEL=EHZ
#NFP=74795
#IN_STR='.bp1to6'

STATION=TPC
CHANNEL=EHZ
NFP=74793
IN_STR='.bp1to5'


DATA_DIR=../data/waveforms${STATION}/fingerprints
echo $STATION
echo $CHANNEL
echo "NFP="$NFP
echo $DATA_DIR

NTBLS=100
NHASH=4
NDIM=2048
NREPEAT=5
NVOTES=2
NTHREAD=8
NUM_PART=1
echo "NTBLS="$NTBLS
echo "NHASH="$NHASH
echo "NDIM="$NDIM
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

