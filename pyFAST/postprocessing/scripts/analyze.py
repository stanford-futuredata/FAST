import time
import matplotlib.pyplot as plt
import numpy as np
import obspy
from datetime import datetime
from collections import OrderedDict
import linecache
import multiprocessing
import os, sys

visualizing = False
time_series = False

AXIS_RANGE = 30 # range required for a point to be grouped with another point
MIN_PARTITION_SIZE = 10000

def is_in_range(tup, dictionary, result_groups):
	for key in dictionary:
		if abs(key[0] - tup[0]) <= AXIS_RANGE and abs(key[1] - tup[1]) <= AXIS_RANGE:
			return (True, key)
		if abs(key[0] - tup[0]) > AXIS_RANGE:
			result_groups.append(dictionary.pop(key))
	return (False, tup) # if no key within range found, return given tuple

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

def process_line(line, groups, result_groups):
	data = line.strip().split(' ')
	idx1 = int(data[0])
	idx2 = int(data[1])
	similarity = int(data[2])
	found_range = is_in_range((idx1, idx2), groups, result_groups)
	if found_range[0]:
		groups[found_range[1]].append((idx1, idx2, similarity))
	else:
		groups[found_range[1]] = [(idx1, idx2, similarity)]

def compute_and_output_stats(group, output):
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

def analyze(interval=None):
	# Making pairs into groups
	groups = OrderedDict()
	result_groups = []
	if interval is None: # Reading the entire pairs file
		with open(PAIRS_FILE, 'r') as f:
			for index, line in enumerate(f):
				process_line(line, groups, result_groups)
	else: # Reading lines between intervals in the pairs file
		for index in xrange(interval[0], interval[1] + 1):
			process_line(linecache.getline(PAIRS_FILE, index + 1), groups, result_groups)
		linecache.clearcache()
	result_groups.extend(groups.values())
	# Compute stats for each group
	if interval is not None:
		lock.acquire()
	for group in result_groups:
		compute_and_output_stats(group, output)
	if interval is not None:
		output.flush()
		lock.release()

def init(l, o):
	global lock, output
	lock = l
	output = o


if __name__ == '__main__':
	FILE_NAME = sys.argv[2] # assign a separate variable FILE_NAME because it will be used in constructing the output filename
	PAIRS_FILE = sys.argv[1] + FILE_NAME
	NUM_PROCESSES = 1
	if len(sys.argv) == 5 and sys.argv[3] == '--p':
		NUM_PROCESSES = int(sys.argv[4])
	start = time.time()
	o = open("../summaries/summary_" + FILE_NAME, 'w')
	if NUM_PROCESSES == 1:
		analyze()
	else: # parallelize
		ranges = partition_file()
		l = multiprocessing.Lock()
		pool = multiprocessing.Pool(NUM_PROCESSES, initializer=init, initargs=(l, o,))
		pool.map(analyze, ranges)
		pool.close()
		pool.join()
	o.close()
	end = time.time()
	print "Processing and writing time:", end - start


