import scipy.io as sio
import h5py
import numpy as np

#mat = h5py.File("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat", "r")
mat = sio.loadmat("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat")
(x, y) = mat['binaryFingerprint'].shape
print x, y
fp = np.array(mat['binaryFingerprint']).T
b = np.packbits(fp)
b.astype('int8').tofile("24hr.bin")
