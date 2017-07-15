import time
import matplotlib.pyplot as plt
import numpy as np
import obspy
from datetime import datetime
from collections import OrderedDict

# modification

FILE_NAME = "9days_NZ_GVZ_HHZ.txt"
PAIRS_FILE = "./sorted_pairs/" + FILE_NAME
IDX_TO_TS = "./idx_to_ts/ts_NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z"
RAW_TS = "./raw_time_series/NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z.mseed"

timing = True

AXIS_RANGE = 30 # range required for a point to be grouped with another point

def is_in_range(tup, dictionary, result_groups):
	for key in dictionary:
		if abs(key[0] - tup[0]) <= AXIS_RANGE and abs(key[1] - tup[1]) <= AXIS_RANGE:
			return (True, key)
		if abs(key[0] - tup[0]) > AXIS_RANGE:
			result_groups.append(dictionary.pop(key))
	return (False, tup) # if no key within range found, return given tuple

def avg_tup(group):
	idx1_sum = 0
	idx2_sum = 0
	for tup in group:
		idx1_sum += tup[0]
		idx2_sum += tup[1]
	length = len(group)
	return (float(idx1_sum) / length, float(idx2_sum) / length)

def plot_heatmap(idx1_list, idx2_list, similarity_list, smallest_idx1, largest_idx1, smallest_idx2, largest_idx2):
	grid_width = largest_idx1 - smallest_idx1 + 1
	grid_height = largest_idx2 - smallest_idx2 + 1
	grid = np.zeros((grid_width, grid_height))
	length = len(idx1_list)
	for i in xrange(length):
		grid[idx1_list[i] - smallest_idx1][idx2_list[i] - smallest_idx2] = similarity_list[i]
	plt.pcolormesh(grid, cmap='hot')
	plt.colorbar()
	plt.show()

def plot_time_series(smallest_idx1, smallest_idx2, largest_idx1, largest_idx2):
	timestamps = []
	with open(IDX_TO_TS, 'r') as f:
		for index, line in enumerate(f):
			timestamp = line.strip()
			timestamps.append(timestamp)
	date_format = "%y-%m-%dT%H:%M:%S.%f"
	start_utc_idx1 = obspy.UTCDateTime(datetime.strptime(timestamps[smallest_idx1], date_format))
	end_utc_idx1 = obspy.UTCDateTime(datetime.strptime(timestamps[largest_idx1], date_format)) + 20
	start_utc_idx2 = obspy.UTCDateTime(datetime.strptime(timestamps[smallest_idx2], date_format))
	end_utc_idx2 = obspy.UTCDateTime(datetime.strptime(timestamps[largest_idx2], date_format)) + 20
	st1 = obspy.read(RAW_TS, starttime=start_utc_idx1, endtime=end_utc_idx1)
	st2 = obspy.read(RAW_TS, starttime=start_utc_idx2, endtime=end_utc_idx2)
	st1.plot()
	st2.plot()

def analyze_pairs():
	if timing:
		start = time.clock()
	groups = OrderedDict()
	result_groups = []
	with open(PAIRS_FILE, 'r') as f:
		for index, line in enumerate(f):
			data = line.strip().split(' ')
			idx1 = int(data[0])
			idx2 = int(data[1])
			similarity = int(data[2])
			found_range = is_in_range((idx1, idx2), groups, result_groups)
			if found_range[0]:
				groups[found_range[1]].append((idx1, idx2, similarity))
			else:
				groups[found_range[1]] = [(idx1, idx2, similarity)]
	result_groups.extend(groups.values())
	if timing:
		end = time.clock()
		print "File traversal time:", end - start
	output = open("./summaries/summary_" + FILE_NAME, 'w')
	if timing:
		sort_start = time.clock()
	result_groups = sorted(result_groups, key=lambda x: -len(x))
	if timing:
		sort_end = time.clock()
		print "Sort time:", sort_end - sort_start
		loop_start = time.clock()
	for idx in xrange(len(result_groups)):
		curr_group = result_groups[idx]
		idx1_list = [pair[0] for pair in curr_group]
		idx2_list = [pair[1] for pair in curr_group]
		similarity_list = [pair[2] for pair in curr_group]
		smallest_idx1 = min(idx1_list)
		largest_idx1 = max(idx1_list)
		smallest_idx2 = min(idx2_list)
		largest_idx2 = max(idx2_list)
		most_similar_pair = curr_group[0]
		size = 0
		similarity_sum = 0
		for pair in curr_group:
			size += 1
			similarity_sum += pair[2]
			if pair[2] > most_similar_pair[2]:
				most_similar_pair = pair
		output.write("Group number %d summary\n" % (idx + 1))
		output.write("Pairs: " + str(curr_group) + "\n")
		output.write("Number of pairs: %d\n" % (size))
		output.write("idx1 range: [%d, %d]\n" % (smallest_idx1, largest_idx1))
		output.write("idx2 range: [%d, %d]\n" % (smallest_idx2, largest_idx2))
		output.write("Most similar pair: " + str(most_similar_pair) + "\n")
		output.write("Total similarity (mass): %d\n" % (similarity_sum))
		output.write("\n")
	output.close()
	if timing:
		loop_end = time.clock()
		print "Loop time:", loop_end - loop_start

analyze_pairs()

