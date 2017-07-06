import time
import matplotlib.pyplot as plt
import numpy as np

FILE_NAME = "9days_NZ_GVZ_HHZ.txt"
PAIRS_FILE = "./sorted_pairs/" + FILE_NAME

visualizing = False

AXIS_RANGE = 15 # range required for a point to be grouped with another point

NUM_FILE_LINES = 40000 # number of file lines to read, after which the loop stops and processing starts on the available groups extracted

def is_in_range(tup, dictionary):
	for key in dictionary:
		if abs(key[0] - tup[0]) <= AXIS_RANGE and abs(key[1] - tup[1]) <= AXIS_RANGE:
			return key
	return tup # if no key within range found, return given tuple

def avg_tup(group):
	idx1_sum = 0
	idx2_sum = 0
	for tup in group:
		idx1_sum += tup[0]
		idx2_sum += tup[1]
	length = len(group)
	return (float(idx1_sum) / length, float(idx2_sum) / length)

def plot_heatmap(idx1_list, idx2_list, similarity_list, smallest_idx1, largest_idx1, smallest_idx2, largest_idx2, plot_num):
	grid_width = largest_idx1 - smallest_idx1 + 1
	grid_height = largest_idx2 - smallest_idx2 + 1
	grid = np.zeros((grid_width, grid_height))
	for i in xrange(length):
		grid[idx1_list[i] - smallest_idx1][idx2_list[i] - smallest_idx2] = similarity_list[i]
	plt.subplot(2, 2, idx + 1)
	plt.title("Group number " + str(plot_num))
	plt.pcolormesh(grid, cmap='hot')
	plt.colorbar()

def analyze_pairs():
	start = time.clock()
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
				new_key = avg_tup(groups[found_range])
				groups[new_key] = groups.pop(found_range)
			else:
				groups[found_range] = [(idx1, idx2, similarity)]
			if index > NUM_FILE_LINES: # added to terminate, since without this it takes too long
				break
	end = time.clock()
	print NUM_FILE_LINES, end - start
	output = open("./summary_" + FILE_NAME, "w")
	group_lists = sorted(groups.values(), key=lambda x: -len(x))
	for idx in xrange(len(group_lists)):
		curr_group = group_lists[idx]
		idx1_list = [pair[0] for pair in curr_group]
		idx2_list = [pair[1] for pair in curr_group]
		similarity_list = [pair[2] for pair in curr_group]
		smallest_idx1 = min(idx1_list)
		largest_idx1 = max(idx1_list)
		smallest_idx2 = min(idx2_list)
		largest_idx2 = max(idx2_list)
		most_similar_pair = sorted(curr_group, key=lambda x: -x[2])[0]
		output.write("Group number " + str(idx + 1) + " summary\n")
		output.write("Pairs: " + str(curr_group) + "\n")
		output.write("Number of pairs: " + str(len(curr_group)) + "\n")
		output.write("idx1 range: [" + str(smallest_idx1) + ", " + str(largest_idx1) + "]\n")
		output.write("idx2 range: [" + str(smallest_idx2) + ", " + str(largest_idx2) + "]\n")
		output.write("Most similar pair: " + str(most_similar_pair) + "\n")
		output.write("Total similarity (mass): " + str(sum(similarity_list)) + "\n")
		output.write("\n")
		if visualizing:
			plot_heatmap(idx1_list, idx2_list, similarity_list, smallest_idx1, largest_idx1, smallest_idx2, largest_idx2, idx + 1)
	output.close()
	if visualizing:
		plt.show()

analyze_pairs()

