from operator import itemgetter

# modification

FILE_NAME = "9days_NZ_GVZ_HHN.txt"
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
	pairs.sort(key=itemgetter(0, 1))
	output = open("./sorted_pairs/" + FILE_NAME, "w")
	for i in xrange(len(pairs)):
		output.write("%d %d %d\n" % (pairs[i][0], pairs[i][1], pairs[i][2]))
	output.close()

sort_pairs()