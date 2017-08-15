import numpy as np
import sys
from operator import itemgetter

def get_global_index_map(idx_fname):
	f = open(idx_fname, 'r')
	idx_map = {}
	for i, line in enumerate(f.readlines()):
		idx_map[i] = int(line.strip())
	f.close()
	return idx_map

if __name__ == '__main__':
	fname = sys.argv[1]
	# Optionally map the fingerprint index for each station to a global index
	if len(sys.argv) > 2:
		idx_map = get_global_index_map(sys.argv[2])

	a = np.fromfile(fname, dtype=np.uint32)
	i = 0
	f = open("%s_pairs.txt" % (fname), 'w')
	while (i < len(a)):
		idx = a[i]
		i += 1
		counts = a[i]
		i += 1
		for j in range(counts / 2):
			if len(sys.argv) > 2:
				f.write("%d %d %d\n" % (
					idx_map[idx], idx_map[a[i + j * 2]], a[i + j * 2 + 1]))
			else:
				f.write("%d %d %d\n" % (
					idx, a[i + j * 2], a[i + j * 2 + 1]))
		i += counts
	f.close()
