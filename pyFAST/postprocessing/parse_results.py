import numpy as np
import sys
from operator import itemgetter
import os
from tqdm import *

# Read input file 128MB per chunk
MB_TO_BYTES = 1024 * 1024
chunk_in_bytes = 128 * MB_TO_BYTES


def get_global_index_map(idx_fname):
	f = open(idx_fname, 'r')
	idx_map = {}
	for i, line in enumerate(f.readlines()):
		idx_map[i] = int(line.strip())
	f.close()
	return idx_map

if __name__ == '__main__':
	fname = sys.argv[1]
	nvotes = None
	# Optionally map the fingerprint index for each station to a global index
	if len(sys.argv) > 2:
		idx_map = get_global_index_map(sys.argv[2])
		if len(sys.argv) > 3:
			nvotes = int(sys.argv[3])

	# File size in bytes
	file_size = os.path.getsize(fname)
	offset = 0
	global_idx = None
	f = open(fname, 'r')
	pairs_file = open("%s_pairs.txt" % fname, 'w')
	pbar = tqdm(total=file_size / MB_TO_BYTES, unit="MB")

	# Read binary file in chunks
	while offset < file_size:
		read_size = min(chunk_in_bytes, file_size - offset)
		buf = f.read(read_size)
		delta_offset = 0
		a = np.frombuffer(buf, dtype=np.uint32)
		i = 0
		lines = []
		while (i < len(a)):
			idx = a[i]
			i += 1
			counts = a[i]
			i += 1
			if len(sys.argv) > 2:
				global_idx = idx_map[idx]
			# Read extra bytes
			if i + counts > len(a):
				read_size = (i + counts - len(a)) * 4
				buf = f.read(read_size)
				delta_offset += read_size
				a = np.concatenate([a, np.frombuffer(buf, dtype=np.uint32)])
			for j in range(counts / 2):
				# Only add things that are above specified thresholds
				if nvotes is None or a[i + j * 2 + 1] >= nvotes:
					# Map station fingerprint index to global index
					if len(sys.argv) > 2:
						lines.append('%d %d %d\n' %(
							global_idx - idx_map[a[i + j * 2]], global_idx, a[i + j * 2 + 1]))
					# Use station index
					else:
						lines.append('%d %d %d\n' %(idx - a[i + j * 2], idx, a[i + j * 2 + 1]))
			i += counts

		pairs_file.writelines(lines)
		delta_offset += min(chunk_in_bytes, file_size - offset)
		offset += delta_offset
		pbar.update((delta_offset / MB_TO_BYTES))

	pbar.close()
	pairs_file.close()
	f.close()

