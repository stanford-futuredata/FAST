import time
import matplotlib.pyplot as plt
import numpy as np
import obspy
from datetime import datetime
from collections import OrderedDict
import linecache
import multiprocessing

# modification

FILE_NAME = "9days_NZ_GVZ_HHN.txt"
PAIRS_FILE = "./sorted_pairs/" + FILE_NAME
IDX_TO_TS = "./idx_to_ts/ts_NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z"
RAW_TS = "./raw_time_series/NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z.mseed"

visualizing = False
time_series = False

AXIS_RANGE = 15 # range required for a point to be grouped with another point
MIN_PARTITION_SIZE = 10000

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

def partition_file():
	ranges = []
	with open(PAIRS_FILE, 'r') as f:
		first_set = False
		counter = 0
		for index, line in enumerate(f):
			counter += 1
			data = line.strip().split(' ')
			if not first_set:
				first = index
				first_set = True
			elif abs(int(data[0]) - prev) > AXIS_RANGE and counter >= MIN_PARTITION_SIZE:
				ranges.append((first, index))
				counter = 0
				first_set = False
			prev = int(data[0])
	if first_set:
		ranges.append((first, index))
	return ranges

def analyze(interval):
	groups = OrderedDict()
	result_groups = []
	for index in xrange(interval[0], interval[1] + 1):
		data = linecache.getline(PAIRS_FILE, index + 1).strip().split(' ')
		idx1 = int(data[0])
		idx2 = int(data[1])
		similarity = int(data[2])
		found_range = is_in_range((idx1, idx2), groups, result_groups)
		if found_range[0]:
			groups[found_range[1]].append((idx1, idx2, similarity))
			new_key = avg_tup(groups[found_range[1]])
			groups[new_key] = groups.pop(found_range[1])
		else:
			groups[found_range[1]] = [(idx1, idx2, similarity)]
	linecache.clearcache()
	result_groups.extend(groups.values())
	lock.acquire()
	for group in result_groups:
		idx1_list = [pair[0] for pair in group]
		idx2_list = [pair[1] for pair in group]
		similarity_list = [pair[2] for pair in group]
		smallest_idx1 = min(idx1_list)
		largest_idx1 = max(idx1_list)
		smallest_idx2 = min(idx2_list)
		largest_idx2 = max(idx2_list)
		most_similar_pair = group[0]
		size = 0
		similarity_sum = 0
		for pair in group:
			size += 1
			similarity_sum += pair[2]
			if pair[2] > most_similar_pair[2]:
				most_similar_pair = pair
		output.write("Pairs: " + str(group) + "\n")
		output.write("Number of pairs: %d\n" % (size))
		output.write("idx1 range: [%d, %d]\n" % (smallest_idx1, largest_idx1))
		output.write("idx2 range: [%d, %d]\n" % (smallest_idx2, largest_idx2))
		output.write("Most similar pair: " + str(most_similar_pair) + "\n")
		output.write("Total similarity (mass): %d\n" % (similarity_sum))
		output.write("\n")
	lock.release()

def init(l, o):
	global lock, output
	lock = l
	output = o

def analyze_pairs():
	div_start = time.clock()
	ranges = partition_file()
	div_end = time.clock()
	print "File partition time:", div_end - div_start
	start = time.time()
	num_cores = multiprocessing.cpu_count()
	print "Num cores:", num_cores
	l = multiprocessing.Lock()
	o = open("./summaries/summary_" + FILE_NAME, 'w')
	pool = multiprocessing.Pool(num_cores, initializer=init, initargs=(l, o,))
	pool.map(analyze, ranges)
	pool.close()
	pool.join()
	for i in xrange(1000):
		o.write("This is a filler\n")
	o.close()
	end = time.time()
	print "Processing and writing time:", end - start

analyze_pairs()

