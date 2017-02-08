import scipy.io as sio
import h5py
import numpy as np
import sys

if __name__ == '__main__':
	fname = sys.argv[1]
	try:
		mat = sio.loadmat(fname)
	except:
		mat = h5py.File(fname, "r")
	(x, y) = mat['binaryFingerprint'].shape
	fp = np.array(mat['binaryFingerprint'])
	if x < y:
		fp = fp.T
	b = np.packbits(fp)
	b.astype('int8').tofile("fp.bin")
