import numpy as np
import scipy.io as sio
import simhash
from sklearn.metrics.pairwise import cosine_similarity
import operator

k = 3
blocks = 6
hash_len = 32

mat = sio.loadmat("binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat")
(x, y) = mat['binaryFingerprint'].shape
fp = mat['binaryFingerprint'].T
# zero mean
fp = np.add(fp, -800.0 / 4096)


r = np.zeros((hash_len, x))
for i in range(hash_len):
	r[i] = np.random.normal(0, 1, x)

hashes = []
f = open("simhash_keys.txt", "w")
for i in range(y):
	key = 0
	for j in range(hash_len):
		if np.dot(fp[i, :], r[j, :]) >= 0:
			key = key * 2
		else:
			key = key * 2 + 1
	hashes.append(key)
	f.write(str(key) + "\n")
f.close()


matches = simhash.find_all(hashes, blocks, k)
results = {}
for m in matches:
	a, b = m
	x = hashes.index(a)
	y = hashes.index(b)
	if (abs(x - y) <= 5):
		continue
	results[(x, y)] = cosine_similarity(fp[x, :].reshape(1, -1), fp[y, :].reshape(1, -1))[0][0]

f = open("sim_candidate_pairs.txt", "w")
sorted_results = sorted(results.items(), key = operator.itemgetter(1), reverse=True)
for i in sorted_results:
	f.write("%d,%d,%f\n" % (i[0][0], i[0][1], i[1]))
f.close()


