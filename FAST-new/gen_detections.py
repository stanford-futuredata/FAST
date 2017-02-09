import operator

slop = 5

f = open("sim_candidate_pairs.txt")
sim = {}
for line in f.readlines():
	nums = line.split(",")
	if not int(nums[0]) in sim:
		sim[int(nums[0])] = float(nums[2])
	if not int(nums[1]) in sim:
		sim[int(nums[1])] = float(nums[2])
	else:
		sim[int(nums[0])] = max(sim[int(nums[0])], float(nums[2]))
		sim[int(nums[1])] = max(sim[int(nums[1])], float(nums[2]))
f.close()


f = open("simhash_candidate_pairs.txt", "w")
d = open("NCSN_indices_match.txt", "r")
for line in d.readlines():
	nums = line.split(" ")
	x = int(nums[0])
	if x in sim:
		f.write(line.strip() + " " + str(sim[x]) + "\n")
	else:
		max_sim = 0
		offset = 0
		for i in range(1, slop + 1):
			if x - i in sim:
				if sim[x - i] > max_sim:
					offset = -i
					max_sim = sim[x - i]
			elif x + i in sim:
				if sim[x + i] > max_sim:
					offset = i
					max_sim = sim[x + i]

		if offset == 0:
			f.write("Missing: " + line.strip() + "\n")
		else:
			f.write("%d: %s %f\n" % (offset, line.strip(), max_sim))

d.close()

f.write("\nSorted results:\n")
sorted_results = sorted(sim.items(), key = operator.itemgetter(1), reverse=True)
for i in sorted_results:
	f.write(str(i) + "\n")
f.close()

