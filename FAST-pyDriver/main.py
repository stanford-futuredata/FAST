from cyInterface import *
import scipy.io as sio
import numpy as np
from matplotlib import pyplot as plt

def plot_detection_indices(filename):
	f = open(filename, "r")
	for line in f.readlines():
		nums = line.strip().split(",")
		if len(nums) == 2:
			key = int(nums[0])
			count = int(nums[1])
			plt.plot(key / y, count, 'bo')
			plt.plot(key % y, count, 'go')
		else:
			plt.plot(int(nums[0]), int(nums[2]), 'bo')
			plt.plot(int(nums[1]), int(nums[2]), 'go')
	f.close()
	plt.savefig("detection.png", format="png")

# Load fingerprints
mat = sio.loadmat("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat")
(x, y) = mat['binaryFingerprint'].shape
fp = mat['binaryFingerprint'].T.reshape(x * y)

hash_and_search("24hr", fp, x, y)

plot_detection_indices("simpairs-map.txt")

