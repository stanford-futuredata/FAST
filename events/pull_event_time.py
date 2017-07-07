import urllib2
import xmltodict
import csv
import datetime
from obspy import read, UTCDateTime
import sys
from dateutil.relativedelta import relativedelta
import pandas as pd

stations = ['THZ', 'KHZ', 'LTZ', 'GVZ', 'OXZ', 'MQZ']
channels = ['HHE', 'HHN', 'HHZ']
INTERVAL = relativedelta(months=+1)

def get_info(id):
	print id
	file = urllib2.urlopen('http://quakeml.geonet.org.nz/quakeml/1.2/%s' % id )
	data = file.read()
	file.close()

	data = xmltodict.parse(data)
	data = data['q:quakeml']['eventParameters']['event']
	if 'stationMagnitude' in data and 'amplitude' in data:
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
					if i >= len(timeInfo):
						break
					t = timeInfo['timeWindow']
				event = t['reference']
				begin = float(t['begin'])
				end = float(t['end'])
				f = open('%s-%s-events.txt' % (station, channel), 'a')
				f.write('%s %s %f %f\n' %(id, event, begin, end))
				f.close()
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
			f = open('%s-%s-events.txt' % (station, channel), 'a')
			f.write('%s %s %f %f\n' %(id, event, begin, end))
			f.close()

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%Y-%m-%dT%H:%M:%S.%fZ")

	with open("ALL_NewZealand_Earthquake_Catalog.csv", "rb") as csvfile:
		reader = csv.reader(csvfile, delimiter=',')
		lines = reversed(list(reader))
		for row in lines:
			if 'publicid' in row:
				continue
			ts = datetime.datetime.strptime(row[2], "%Y-%m-%dT%H:%M:%S.%fZ")
			if ts < start_time:
				continue
			if "earthquake" in row:
				get_info(row[0])




