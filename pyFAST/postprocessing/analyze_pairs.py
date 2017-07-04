import matplotlib.pyplot as plt
import numpy as np

PAIRS_FILE = "./sorted_pairs/9days_NZ_GVZ_HHZ.txt"

AXIS_RANGE = 100

def is_in_range(tup, dictionary):
	for key in dictionary:
		if abs(key[0] - tup[0]) <= AXIS_RANGE and abs(key[1] - tup[1]) <= AXIS_RANGE:
			return key
	return tup # if no key within range found, return given tuple

def plot_heatmap():
	groups = {}
	with open(PAIRS_FILE, 'r') as f:
		for index, line in enumerate(f):
			data = line.strip().split(' ')
			idx1 = int(data[0])
			idx2 = int(data[1])
			similarity = int(data[2])
			found_range = is_in_range((idx1, idx2), groups)
			if found_range in groups:
				groups[found_range].append((idx1, idx2, similarity))
			else:
				groups[found_range] = [(idx1, idx2, similarity)]
			if max([len(group) for group in groups.values()]) > 30: # added to terminate, since without this it takes too long
				break
	largest_group_len = max([len(group) for group in groups.values()])
	for group in groups.values():
		if len(group) == largest_group_len:
			largest_group = group
			break
	idx1_list = [pair[0] for pair in largest_group]
	idx2_list = [pair[1] for pair in largest_group]
	similarity_list = [pair[2] for pair in largest_group]
	smallest_idx1 = min(idx1_list)
	largest_idx1 = max(idx1_list)
	smallest_idx2 = min(idx2_list)
	largest_idx2 = max(idx2_list)
	print smallest_idx1, largest_idx1, smallest_idx2, largest_idx2
	grid_width = largest_idx1 - smallest_idx1 + 1
	grid_height = largest_idx2 - smallest_idx2 + 1
	grid = np.zeros((grid_width, grid_height))
	for i in xrange(largest_group_len):
		grid[idx1_list[i] - smallest_idx1][idx2_list[i] - smallest_idx2] = similarity_list[i]
	for i in xrange(grid_height):
		for j in xrange(grid_width):
			if grid[j][i] > 0:
				print i, j, str(grid[j][i])
	plt.pcolormesh(grid, cmap='hot')
	plt.axis([smallest_idx1, largest_idx1, smallest_idx2, largest_idx2])
	plt.colorbar()
	plt.show()

plot_heatmap()


