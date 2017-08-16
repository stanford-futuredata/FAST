from obspy import read
import datetime
from obspy.core import UTCDateTime
from dateutil.relativedelta import relativedelta
import sys

INTERVAL = relativedelta(months=+1)
station = 'LTZ'
channel = 'HHZ'
data_path = 'bp2to20_waveforms%s/'
ts_file_base = 'bp2to20.NZ.%s.10.%s__%s01T000000Z__%s01T000000Z.mseed'

def read_events(fname):
	f = open(fname, 'r')
	events = {}
	for line in f.readlines():
		elems = line.split()
		events[elems[0]] = elems[1]
	f.close()
	return events

def plot_ts(event, id):
	segment = st.slice(starttime=UTCDateTime(event), endtime=UTCDateTime(event) + 60)
	segment.plot(outfile="plots/%s.png" % id, format="png")


if __name__ == '__main__':
	ts_file = sys.argv[1]

	prev_ts = None
	f = open(ts_file, 'r')
	i = 0
	for line in f.readlines():
		ts = datetime.datetime.strptime(line.strip(), "%y-%m-%dT%H:%M:%S.%f")
		current_month = ts.strftime('%Y%m')
		next_month = (ts + INTERVAL).strftime('%Y%m')
		if prev_ts is None or current_month != prev_ts:
			st = read((data_path % station) +
				(ts_file_base % (station, channel, current_month, next_month)))
		plot_ts(ts, line)
		prev_ts = current_month

	f.close()
