import time
from collections import OrderedDict
import linecache
import multiprocessing
import os, sys

AXIS_RANGE = 30 # range required for a point to be grouped with another point
MIN_PARTITION_SIZE = 10000

"""
Loops through all keys currently in dictionary and compares them with the given pair tuple. Returns (True, found_key) if it found a key within range
of the given pair. Otherwise, returns (False, given_tuple).
"""
def is_in_range(tup, dictionary, result_groups):
	for key in dictionary:
		if abs(key[0] - tup[0]) <= AXIS_RANGE and abs(key[1] - tup[1]) <= AXIS_RANGE:
			return (True, key)
		if abs(key[0] - tup[0]) > AXIS_RANGE:
			result_groups.append(dictionary.pop(key))
	return (False, tup) # if no key within range found, return given tuple

"""
Partition the pairs file into a list of non-overlapping intervals that are later passed to analyze(), for the parallel case.
"""
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

"""
Processes a line with the format 'idx1 idx2 similarity'. Checks if the new pair is within AXIS_RANGE of previous groups; if so, adds it
to the relevant group; otherwise, creates new group for that pair.
"""
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

"""
Compute stats and write the summary to the output file.
"""
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
	for pair in group: # in this loop, I also manually compute the length of the group, the similarity sum, and the most similar pair, in order to avoid using len, sum, and max later and save computation
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

"""
Takes pairs and groups them, and puts the groups in result_groups. It then writes the stats of each group to the output file.
In the non-parallel case, which is the default case where interval == None, the whole input pairs file is processed and written
to the output file. result_groups is also sorted by group length. In the parallel case, only the lines between the given interval
(inclusive) are processed.
"""
def analyze(interval=None):
	groups = OrderedDict() # Dictionary where key is the first pair added in this range and value is the list of pairs in this range
	result_groups = [] # This is populated in is_in_range() inside process_line(). As soon as an idx1 is not within range, the group is removed from the dictionary and into this list
	if interval is None: # Reading the entire pairs file
		with open(PAIRS_FILE, 'r') as f:
			for index, line in enumerate(f):
				process_line(line, groups, result_groups)
	else: # Reading lines between intervals in the pairs file
		for index in xrange(interval[0], interval[1] + 1):
			process_line(linecache.getline(PAIRS_FILE, index + 1), groups, result_groups)
		linecache.clearcache()
	result_groups.extend(groups.values()) # extend the list by the remaining groups that haven't gone out of range
	if interval is None:
		result_groups.sort(key=lambda x: -len(x)) # sort if non-parallel version, since it's the whole file so sorting makes sense
	# Compute stats for each group
	if interval is not None: # acquire the lock if interval isn't None, which means this is the parallel version
		lock.acquire()
		o_file = output # output is used for parallel, and defined in the initializer of multiprocessing.Pool
	else:
		o_file = o # o is defined in the global namespace
	for group in result_groups:
		compute_and_output_stats(group, o_file)
	if interval is not None:
		o_file.flush() # flush the output file to make sure no characters are stuck in the internal buffer before being written to file
		lock.release()

"""
Initializer function for multiprocessing.Pool. Makes lock and output global so that they can be used across processes.
"""
def init(l, o):
	global lock, output
	lock = l
	output = o


if __name__ == '__main__':
	FILE_NAME = sys.argv[2] # assign a separate variable FILE_NAME because it will be used in constructing the output filename
	PAIRS_FILE = sys.argv[1] + FILE_NAME
	NUM_PROCESSES = 1
	if len(sys.argv) == 5 and sys.argv[3] == '--p': # if the --p parameter is given
		NUM_PROCESSES = int(sys.argv[4])
	start = time.time()
	o = open("../summaries/summary_" + FILE_NAME, 'w') # output file location; change as necessary
	if NUM_PROCESSES == 1: # non-parallel
		analyze()
	else: # parallelize
		ranges = partition_file() # partitions file into non-overlapping intervals that each process works on separately
		l = multiprocessing.Lock() # lock for when the process is writing to file
		pool = multiprocessing.Pool(NUM_PROCESSES, initializer=init, initargs=(l, o,)) # the lock and output are necessarily passed through initializer to be inherited (otherwise it's an error)
		pool.map(analyze, ranges)
		pool.close()
		pool.join()
	o.close()
	end = time.time()
	print "Processing and writing time:", end - start

