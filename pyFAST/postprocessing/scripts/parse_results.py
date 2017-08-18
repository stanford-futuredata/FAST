import numpy as np
import sys
from operator import itemgetter
import os
from tqdm import *

# Read input file 128MB per chunk
MB_TO_BYTES = 1024 * 1024
chunk_in_bytes = 128 * MB_TO_BYTES

if __name__ == '__main__':
	fname = sys.argv[1]
	nvotes = None
	if len(sys.argv) > 2:
		nvotes = int(sys.argv[2])

	# File size in bytes
	file_size = os.path.getsize(fname)
	offset = 0
	prev_offset = 0
	f = open(fname, 'r')
	pairs_file = open("%s_pairs.txt" % fname, 'w')

	# Read binary file in chunks
	pbar = tqdm(total=file_size / MB_TO_BYTES, unit="MB")
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
			# Read extra bytes
			if i + counts > len(a):
				read_size = (i + counts - len(a)) * 4
				buf = f.read(read_size)
				delta_offset += read_size
				a = np.concatenate([a, np.frombuffer(buf, dtype=np.uint32)])
			for j in range(counts / 2):
				# Only add things that are above specified thresholds
				if nvotes is None or a[i + j * 2 + 1] >= nvotes:
					lines.append('%d %d %d\n' %(idx, a[i + j * 2], a[i + j * 2 + 1]))
			i += counts

		pairs_file.writelines(lines)
		delta_offset += min(chunk_in_bytes, file_size - offset)
		offset += delta_offset
		pbar.update((delta_offset / MB_TO_BYTES))

	pbar.close()
	pairs_file.close()
	f.close()

