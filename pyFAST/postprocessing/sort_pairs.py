from orderedset import OrderedSet

FILE_NAME = "9days_NZ_GVZ_HHZ.txt"
PAIRS_FILE = "./result_pairs/" + FILE_NAME

def sort_pairs():
	pairs = []
	with open(PAIRS_FILE, 'r') as f:
 		for index, line in enumerate(f):
 			data = line.strip().split(' ')
			idx1 = int(data[0])
			idx2 = int(data[1])
			similarity = int(data[2])
			pairs.append((idx1, idx2, similarity))
	pairs = sorted(pairs, key=lambda x: x[0])
	idx1_set = OrderedSet([pair[0] for pair in pairs])
	rest = [] # list of lists of 2-tuples (idx2, similarity) so that those lists can be sorted individually, separated and grouped by the corresponding idx1
	index = 0
	for idx1 in idx1_set:
		curr_rest_list = [] # list of 2-tuples (idx2, similarity)
		while pairs[index][0] == idx1:
			curr_rest_list.append((pairs[index][1], pairs[index][2]))
			index += 1
			if index >= len(pairs):
				break
		rest.append(curr_rest_list)
	sorted_rest = [sorted(rest[i], key=lambda x: x[0]) for i in xrange(len(rest))]
	flat_list = [two_tuple for curr_rest_list in sorted_rest for two_tuple in curr_rest_list]
	output = open("./sorted_pairs/" + FILE_NAME, "w")
	for i in xrange(len(pairs)):
		output.write(str(pairs[i][0]) + " " + str(flat_list[i][0]) + " " + str(flat_list[i][1]) + "\n")

sort_pairs()