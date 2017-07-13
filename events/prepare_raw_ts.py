import csv
import datetime
from obspy import read, UTCDateTime
import sys
from dateutil.relativedelta import relativedelta
import pandas as pd
import random

station = 'KHZ'
channel = 'HHZ'
normalize = True
INTERVAL = relativedelta(months=+1)
ts_folder = 'waveforms%s/' % station
ts_file_base = 'NZ.%s.10.%s__%s__%s.mseed'
eq_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])
normal_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])

ranges = [[-25, -20], [-20, -15], [-15, -10], [-10, -5], [-5, 0]]

def min_max_normalize(data):
	min_ts = min(data)
	max_ts = max(data)
	normalized = []
	for d in data:
		normalized.append((d - min_ts) / (max_ts - min_ts))
	return normalized

def get_segment(id, event, begin, end, label=1):
	new_sample = pd.DataFrame(columns=['id', 'time', 'x', 'y'])
	for r in ranges:
		start_delta = random.randint(r[0], r[1])
		end_delta = start_delta + 30
		segment = st.slice(starttime=UTCDateTime(event) + start_delta,
			endtime=UTCDateTime(event) + end_delta)
		if len(segment) == 0:
			print event
			return
		# Add to dataframe
		data = segment[0].data
		if normalize:
			data = min_max_normalize(data)
		ts = []
		for i in range(len(data)):
			ts.append(['%s-%d' % (id, start_delta), i + 1, data[i], label])
		new_sample = new_sample.append(pd.DataFrame(ts, columns=['id', 'time', 'x', 'y']))
	return new_sample

def construct_filename(t):
	return ts_file_base % (station, channel, t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

def read_mseed(time):
	fname = construct_filename(time)
	st = read(ts_folder + fname)
	return st

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	station = sys.argv[3]

	time = start_time
	prev_event = time
	st = read_mseed(time)
	f = open('events/timestamps/%s-%s-events.txt' % (station, channel), 'r')
	for line in f.readlines():
		elem = line.split()
		ts = datetime.datetime.strptime(elem[1], "%Y-%m-%dT%H:%M:%S.%fZ")
		if ts < start_time:
			continue
		elif ts >= time + INTERVAL:
			eq_examples.to_csv('%s-%s-%s-eq.csv' % (station, channel, time.strftime('%y-%m')))
			eq_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])
			normal_examples.to_csv('%s-%s-%s-normal.csv' % (station, channel, time.strftime('%y-%m')))
			normal_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])
			time += INTERVAL
			prev_event = time
			if time >= end_time:
				break
			st = read_mseed(time)
		begin = float(elem[2])
		end = float(elem[3])
		inter_event = ts - prev_event
		eq_examples = eq_examples.append(get_segment(elem[0], ts, begin, end))
		if inter_event > datetime.timedelta(seconds=180):
			normal_examples = normal_examples.append(
				get_segment(elem[0] + '_n1',
					prev_event + inter_event / 3, 0, 0, 0))
			normal_examples = normal_examples.append(
				get_segment(elem[0] + '_n2',
					prev_event + inter_event * 2 / 3, 0, 0, 0))
		prev_event = ts


