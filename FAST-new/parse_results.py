import numpy as np
import sys

if __name__ == '__main__':
	fname = sys.argv[1]
	a = np.fromfile(fname, dtype=np.uint32)
	i = 0
	f = open("result_paris.txt", "w")
	while (i < len(a)):
		idx = a[i]
		i += 1
		counts = a[i]
		i += 1
		for j in range(counts / 2):
			f.write("%d %d %d\n" %(idx, a[i + j * 2], a[i + j * 2 +1]))
		i += counts
	f.close()
