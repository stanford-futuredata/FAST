from obspy import read, UTCDateTime
import datetime

stations = ['GVZ', 'LTZ', 'KHZ', 'MQZ', 'OXZ', 'THZ']
ts_file_base = "time_series/NZ.%s.10.HHZ__20161122T000000Z__20161201T000000Z.mseed"

def find_min_max(ts):
	event_times = []
	for t in ts:
		event_times.append(datetime.datetime.strptime(t, '%Y-%m-%dT%H:%M:%S'))
	return min(event_times).strftime('%Y-%m-%dT%H:%M:%S'), max(event_times).strftime('%Y-%m-%dT%H:%M:%S')

def plot_event(idx, ts):
	min_ts, max_ts = find_min_max(ts) 
	segment = st.slice(UTCDateTime(min_ts) - 16, UTCDateTime(max_ts) + 16)
	segment.plot(outfile='plots/new/new_%d.png' % idx, equal_scale=False, size=(1000, 600))

def plot_ts(idx, ts):
	segment = st.slice(UTCDateTime(ts) - 16, UTCDateTime(ts) + 16)
	segment.plot(outfile='plots/found/%d.png' % idx, equal_scale=False, size=(1000, 600))

if __name__ == '__main__':
	st = read(ts_file_base % stations[0])
	for i in range(1, len(stations)):
		st += read(ts_file_base % stations[i])

	# Plot new events
	# f = open('results/new_events.txt', 'r')
	# for idx, line in enumerate(f.readlines()):
	# 	ts = line.split()
	# 	plot_event(idx, ts)
	# f.close()

	# Plot missed events
	# f = open('results/missed_events.txt', 'r')
	# for idx, line in enumerate(f.readlines()):
	# 	plot_ts(idx, line.strip())
	# f.close()

	# Plot found events
	f = open('results/found_events.txt', 'r')
	for idx, line in enumerate(f.readlines()):
		plot_ts(idx, line.split('[')[0][:-2])
	f.close()