import matplotlib.pyplot as plt
import numpy as np
from Queue import PriorityQueue

PAIRS_FILE = "./sorted_pairs/9days_NZ_GVZ_HHZ.txt"

AXIS_RANGE = 100 # range required for a point to be grouped with another point

NUM_FILE_LINES = 20000 # number of file lines to read, after which the loop stops and processing starts on the available groups extracted

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
			if index > NUM_FILE_LINES: # added to terminate, since without this it takes too long
				break
	output = open("./result_groups/line" + str(NUM_FILE_LINES) + ".txt", "w")
	pq = PriorityQueue()
	for group in groups.values():
		pq.put((-len(group), group))
	for idx in xrange(4):
		length, curr_group = pq.get()
		length = -length
		idx1_list = [pair[0] for pair in curr_group]
		idx2_list = [pair[1] for pair in curr_group]
		similarity_list = [pair[2] for pair in curr_group]
		smallest_idx1 = min(idx1_list)
		largest_idx1 = max(idx1_list)
		smallest_idx2 = min(idx2_list)
		largest_idx2 = max(idx2_list)
		grid_width = largest_idx1 - smallest_idx1 + 1
		grid_height = largest_idx2 - smallest_idx2 + 1
		grid = np.zeros((grid_width, grid_height))
		output.write("Group number " + str(idx + 1) + ":\n")
		for i in xrange(length):
			grid[idx1_list[i] - smallest_idx1][idx2_list[i] - smallest_idx2] = similarity_list[i]
			output.write(str(curr_group[i]) + "\n")
		output.write("\n")
		plt.subplot(2, 2, idx + 1)
		plt.title("Group number " + str(idx + 1))
		plt.pcolormesh(grid, cmap='hot')
		plt.colorbar()
	plt.show()

plot_heatmap()


