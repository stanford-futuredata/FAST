import numpy as np
import sys
from operator import itemgetter

# modification

if __name__ == '__main__':
	fname = sys.argv[1]
	a = np.fromfile(fname, dtype=np.uint32)
	i = 0
	pairs = []
	while (i < len(a)):
		idx = a[i]
		i += 1
		counts = a[i]
		i += 1
		for j in range(counts / 2):
			pairs.append((idx, a[i + j * 2], a[i + j * 2 + 1]))
		i += counts
	pairs.sort(key=itemgetter(0, 1))
	f = open("result_pairs.txt", "w")
	for i in xrange(len(pairs)):
		f.write("%d %d %d\n" % (pairs[i][0], pairs[i][1], pairs[i][2]))
	f.close()
