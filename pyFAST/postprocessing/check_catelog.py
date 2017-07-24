import datetime
import csv

IDX_INTERVAL = 2
min_time = datetime.datetime.strptime('2016-11-22 00:00:15.798391', '%Y-%m-%d %H:%M:%S.%f')
start_time = datetime.datetime(2016, 11, 22)
end_time = datetime.datetime(2016, 12, 1)
results_folder = 'results/'

def get_events():
	events = []
	with open("ALL_NewZealand_Earthquake_Catalog.csv", "rb") as csvfile:
		reader = csv.reader(csvfile, delimiter=',')
		lines = reversed(list(reader))
		for row in lines:
			if 'publicid' in row:
				continue
			ts = datetime.datetime.strptime(row[2], "%Y-%m-%dT%H:%M:%S.%fZ")
			if ts < start_time:
				continue
			elif ts > end_time:
				break
			else:
				events.append(ts)
	return events

# Check whether the current event matches with those in the catalog
def check_event(indices, ts):
	is_event = None
	for i in range(len(indices)):
		fp_start = ts[i] - datetime.timedelta(seconds=16)
		fp_end = ts[i] + datetime.timedelta(seconds=16)
		for e in events:
			if e >= fp_start and e <= fp_end:
				is_event = e
				break
		if is_event is not None:
			break
	if is_event:
		key = e.strftime("%Y-%m-%dT%H:%M:%S")
		if key in found_events:
			found_events[key].extend(indices)
		else:
			found_events[key] = indices
	else:
		new.append(ts)

def output_comparisons_with_catalog():
	f = open(results_folder + 'missed_events.txt', 'w')
	count = 0
	for e in events:
		key = e.strftime("%Y-%m-%dT%H:%M:%S")
		if not key in found_events:
			f.write('%s\n' % key)
			count += 1
	f.close()

	f = open(results_folder + 'found_events.txt', 'w')
	for event in found_events:
		f.write('%s: %s\n' % (event, found_events[event]))
	f.close()

	f = open(results_folder + 'new_events.txt', 'w')
	for entry in new:
		for ts in entry:
			f.write('%s ' % (ts.strftime("%Y-%m-%dT%H:%M:%S")))
		f.write('\n')
	f.close()


if __name__ == '__main__':
	events = get_events()

	# Read and check groups
	new = []
	found_events = {}
	detlist = open(results_folder + 'network_detection_detlist.txt', 'r')
	f = open(results_folder + 'det_time.txt', 'w')
	for i, line in enumerate(detlist.readlines()):
		if i == 0:
			continue
		cells = line.split()
		indices = []
		t = []
		for j in range(6):
			if not 'nan' in cells[j]:
				ts = min_time + datetime.timedelta(seconds=int(cells[j]) * IDX_INTERVAL)
				f.write("%s " % ts.strftime('%Y-%m-%dT%H:%M:%S'))
				indices.append(int(cells[j]))
				t.append(ts)
		check_event(indices, t)
		f.write('\n')
	detlist.close()
	f.close()

	output_comparisons_with_catalog()