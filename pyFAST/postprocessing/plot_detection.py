from obspy import read, UTCDateTime
import datetime
from dateutil.relativedelta import relativedelta
import sys

stations = ['KHZ', 'MQZ', 'OXZ', 'THZ', 'LTZ']
channel = 'HHZ'
data_path = '../data/bp2to20_waveforms%s/'
fname_format = "bp2to20.NZ.%s.10.%s__%s__%s.mseed"
INTERVAL = relativedelta(months=+1)
results_folder = '10-4_results'

def construct_filename(t, station, channel):
	return fname_format % (station, channel,
		t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

def find_min_max(ts):
	event_times = []
	for t in ts:
		event_times.append(datetime.datetime.strptime(t, '%Y-%m-%dT%H:%M:%S'))
	return min(event_times).strftime('%Y-%m-%dT%H:%M:%S'), max(event_times).strftime('%Y-%m-%dT%H:%M:%S')

def plot_event(idx, ts):
	min_ts, max_ts = find_min_max(ts) 
	segment = st.slice(UTCDateTime(min_ts) - 16, UTCDateTime(max_ts) + 16)
	segment.plot(outfile='plots/new_%d.png' % idx, equal_scale=False, size=(1000, 600))

def plot_ts(idx, ts):
	segment = st.slice(UTCDateTime(ts) - 16, UTCDateTime(ts) + 16)
	segment.plot(outfile='plots/found/%d.png' % idx, equal_scale=False, size=(1000, 600))

def read_new_mseed(curr_time):
	fname = construct_filename(curr_time, stations[0], channel)
	st = read((data_path % stations[0]) + fname)
	for i in range(1, len(stations)):
		fname = construct_filename(curr_time, stations[i], channel)
		st += read((data_path % stations[i]) + fname)
	return st

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")

	time = start_time
	st = read_new_mseed(time)

	# Plot new events
	f = open('%s/new_events.txt' % results_folder, 'r')
	for idx, line in enumerate(f.readlines()):
		ts = line.split()
		datetime_ts = datetime.datetime.strptime(ts[0], "%Y-%m-%dT%H:%M:%S")
		prev_time = time
		while time + INTERVAL < datetime_ts and time < end_time:
			time += INTERVAL
		if time != prev_time:
			print time
			st = read_new_mseed(time)
		plot_event(idx, ts)
	f.close()

	# Plot missed events
	# f = open('results/missed_events.txt', 'r')
	# for idx, line in enumerate(f.readlines()):
	# 	plot_ts(idx, line.strip())
	# f.close()

	# Plot found events
	# f = open('results/found_events.txt', 'r')
	# for idx, line in enumerate(f.readlines()):
	# 	plot_ts(idx, line.split('[')[0][:-2])
	# f.close()