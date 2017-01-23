from cyInterface import *
import scipy.io as sio
import numpy as np


# Load fingerprints
mat = sio.loadmat("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat")
(x, y) = mat['binaryFingerprint'].shape
fp = mat['binaryFingerprint'].reshape(x * y)

load("24hr.txt", fp, x, y)

