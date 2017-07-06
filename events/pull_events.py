import urllib2
import xmltodict
import csv
import datetime
from obspy import read, UTCDateTime
import sys
from dateutil.relativedelta import relativedelta
import pandas as pd

#stations = ['THZ', 'KHZ', 'LTZ', 'GVZ', 'OXZ', 'MQZ']
#channels = ['HHE', 'HHN', 'HHZ']
stations = ['KHZ']
channels = ['HHZ']
INTERVAL = relativedelta(months=+1)
ts_folder = 'waveformsKHZ/'
ts_file_base = 'NZ.%s.10.%s__%s__%s.mseed'
eq_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])

def get_info(id):
	print id
	file = urllib2.urlopen('http://quakeml.geonet.org.nz/quakeml/1.2/%s' % id )
	data = file.read()
	file.close()

	data = xmltodict.parse(data)
	data = data['q:quakeml']['eventParameters']['event']
	if 'stationMagnitude' in data:
		stationInfo = data['stationMagnitude']
		timeInfo = data['amplitude']
		for i in range(len(stationInfo)):
			try:
				s = stationInfo[i]['waveformID']
			except:
				s = stationInfo['waveformID']
			if s['@stationCode'] in stations and s['@channelCode'] in channels:
				station = s['@stationCode']
				channel = s['@channelCode']
				try:
					t = timeInfo[i]['timeWindow']
				except:
					t = timeInfo['timeWindow']
				event = t['reference']
				begin = float(t['begin'])
				end = float(t['end'])
				plot_fp(id, station, channel, event, begin, end)
				return

	stationInfo = data['pick']
	for i in range(len(stationInfo)):
		s = stationInfo[i]['waveformID']
		if s['@stationCode'] in stations and s['@channelCode'] in channels:
			station = s['@stationCode']
			channel = s['@channelCode']
			event = stationInfo[i]['time']['value']
			begin = 0
			end = 0
			plot_fp(id, station, channel, event, begin, end)


def plot_fp(id, station, channel, event, begin, end):
	global eq_examples
	segment = st.slice(starttime=UTCDateTime(event) - 15,
		endtime=UTCDateTime(event) + 15)
	if len(segment) == 0:
		print event
		return
	# Add to dataframe
	ts = []
	for i in range(len(segment[0].data)):
		ts.append([id, i + 1, segment[0].data[i], 1])
	new_sample = pd.DataFrame(ts, columns=['id', 'time', 'x', 'y'])
	eq_examples = eq_examples.append(new_sample)
	#segment.plot(outfile="plots/%s.png" % id, format="png")

def construct_filename(t, station='KHZ', channel='HHZ'):
	return ts_file_base % (station, channel, t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

def read_mseed(time):
	fname = construct_filename(time)
	st = read(ts_folder + fname)
	st.filter("bandpass", freqmin=2, freqmax=20)
	return st

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")

	time = start_time
	st = read_mseed(time)
	with open("ALL_NewZealand_Earthquake_Catalog.csv", "rb") as csvfile:
		reader = csv.reader(csvfile, delimiter=',')
		lines = reversed(list(reader))
		for row in lines:
			if 'publicid' in row:
				continue
			ts = datetime.datetime.strptime(row[2], "%Y-%m-%dT%H:%M:%S.%fZ")
			if ts < start_time:
				continue
			if ts >= time + INTERVAL:
				eq_examples.to_csv('%s.csv' % time.strftime('%Y-%m'))
				eq_examples = pd.DataFrame(columns=['id', 'time', 'x', 'y'])
				print eq_examples
				time += INTERVAL
				if time >= end_time:
					break
				st = read_mseed(time)
			if "earthquake" in row:
				get_info(row[0])




