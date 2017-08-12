import numpy as np
import sys

fp_len = 4096
bytes_per_fp = fp_len / 8

if __name__ == '__main__':
	fname = sys.argv[1]
	raw = np.fromfile(fname, dtype=np.uint8)
	bits = np.unpackbits(raw)
	nfp = len(raw) / bytes_per_fp
	binaryFingerprints = np.reshape(bits, [nfp, fp_len])