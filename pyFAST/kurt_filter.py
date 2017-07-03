import sys
import os
import datetime
from dateutil.relativedelta import relativedelta
import linecache
from obspy import read
from obspy.core import UTCDateTime
import datetime
from scipy.stats import kurtosis
import csv

INTERVAL = relativedelta(months=+1)
fname_format = "NZ.%s.10.%s__%s__%s.mseed"
ts_path = 'waveformsKHZ/'
station = 'KHZ'
channel = 'HHE'
delta = datetime.timedelta(seconds=120)

def construct_filename(t):
	return fname_format % (station, channel, t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

def get_eq_timestamps(start_time, end_time):
    timestamps = []
    with open("ALL_NewZealand_Earthquake_Catalog.csv", "rb") as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            if "earthquake" in row:
                ts = datetime.datetime.strptime(row[2], "%Y-%m-%dT%H:%M:%S.%fZ")
                if ts >= start_time and ts < end_time:
                    timestamps.append(ts)
    return timestamps

def filter(fname):
	tot = 0
	filtered = 0
	idx = 0
	st = read(ts_path + fname)
	for i in range(len(st)):
		starttime = datetime.datetime.strptime(str(st[i].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
		endtime = datetime.datetime.strptime(str(st[i].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
		s = starttime
		while s < endtime:
			str_starttime = s.strftime('%Y-%m-%dT%H:%M:%S.%f')
			str_endtime = min(s + delta, endtime).strftime('%Y-%m-%dT%H:%M:%S.%f')
			segment = st[i].slice(UTCDateTime(str_starttime), UTCDateTime(str_endtime))
			if kurtosis(segment) < 1:
				filtered += 1
				while idx < len(eqs) and eqs[idx] < s:
					idx += 1
				# If the filtered time period correspond to earthquakes
				if idx < len(eqs) and eqs[idx] > s and eqs[idx] < s + delta:
					false_positives.write('[%s, %s]: %s\n' % (str_starttime, str_endtime, eqs[idx]))
					segment.plot(outfile="plots/%s.png" % str_starttime, format="png")
					print eqs[idx], kurtosis(segment)
					# prev_time = min(s - delta, start_time).strftime('%Y-%m-%dT%H:%M:%S.%f')
					# segment = st[i].slice(UTCDateTime(prev_time),
					# 	UTCDateTime(s.strftime('%Y-%m-%dT%H:%M:%S.%f')))
					# segment.plot(outfile="plots/%s.png" % (prev_time), format="png")
					# print 'Before: %f' % kurtosis(segment)

			tot += 1
			s += delta

	return (filtered, tot)

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	if len(sys.argv) > 3:
		station_channel = sys.argv[3]
	time = start_time

	# Get indexed earthquakes
	eqs = get_eq_timestamps(start_time, end_time)
	eqs.reverse()

	filter_count = open('filter_count.txt', 'w')
	false_positives = open('false_positives.txt', 'w')
	tot_filtered = 0
	tot_time_segments = 0
	while time <= end_time:
		fname = construct_filename(time)
		print fname
		(filtered, tot) = filter(fname)
		print filtered, tot
		tot_filtered += filtered
		tot_time_segments += tot
		filter_count.write('%s: %d %d\n' % (filtered, tot))
		time += INTERVAL

	filter_count.close()
	false_positives.close()

	print tot_filtered, tot_time_segments

