from matplotlib import pyplot as plt
import scipy.io as sio
from sklearn.metrics import jaccard_similarity_score

mat = sio.loadmat("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat")
(x, y) = mat['binaryFingerprint'].shape
fp = mat['binaryFingerprint'].T

f = open("candidate_pairs.txt", "r")
for line in f.readlines():
	nums = line.split(",")
	x = int(nums[0])
	y = int(nums[1])
	count = int(nums[2])
	if count >= 10:
		plt.plot(jaccard_similarity_score(fp[x, :], fp[y, :]), count / 100.0, 'bo')
f.close()
plt.xlabel("Jaccard Similarity")
plt.ylabel("Votes")
plt.savefig("Jaccard_FAST.png", format="png")
