#---------------------------------------------------------------------#
# Example script to read binary fingerprint files into numpy matrix   #
# Usage: python read_fingerprint.py < fingerprint_filename >          #
#---------------------------------------------------------------------#

import numpy as np
import sys

# [CHANGE]: Change fp_len to length of each binary fingerprint
fp_len = 4096
bytes_per_fp = fp_len / 8

if __name__ == '__main__':
	fname = sys.argv[1]
	raw = np.fromfile(fname, dtype=np.uint8)
	bits = np.unpackbits(raw)
	nfp = len(raw) / bytes_per_fp
	binaryFingerprints = np.reshape(bits, [nfp, fp_len])