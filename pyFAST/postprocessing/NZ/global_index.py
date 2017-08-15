import datetime
import sys
from dateutil.relativedelta import relativedelta
import linecache

# Interval between neighbouring global indices in seconds
IDX_INTERVAL = 2
INTERVAL = relativedelta(months=+1)
channels = ['HHZ']
fname_format = "bp2to20.NZ.%s.10.%s__%s__%s"
ts_path = 'bp2to20_waveforms%s/timestamps/'
stations = ['LTZ', 'KHZ', 'MQZ', 'OXZ', 'THZ']


def construct_filename(t):
	return fname_format % (station, channel,
		t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")

	min_time = None
	for station in stations:
		for channel in channels:
			fname = (ts_path % station) + 'ts_' + construct_filename(start_time)
			print station, channel, fname
			tmp = datetime.datetime.strptime(linecache.getline(fname, 1).strip(), 
				"%y-%m-%dT%H:%M:%S.%f")
			if min_time is None:
				min_time = tmp
			elif tmp < min_time:
				min_time = tmp

	# Save stats to file
	f = open('global_idx_stats.txt', 'w')
	f.write('%s\n' % min_time.strftime("%Y-%m-%dT%H:%M:%S.%f"))
	f.write('%d\n' % IDX_INTERVAL)
	f.write('%s\n' % start_time.strftime("%Y-%m-%dT%H:%M:%S.%f"))
	f.write('%s\n' % end_time.strftime("%Y-%m-%dT%H:%M:%S.%f"))
	f.close()

	for station in stations:
		for channel in channels:
			print station, channel
			f = open('%s_%s_%s_%s_idx_mapping.txt' % (
				station, channel, sys.argv[1], sys.argv[2]), 'w')
			time = start_time
			while time <= end_time:
				fname = construct_filename(time)
				print fname
				ts_file = open((ts_path % station) + 'ts_' + fname, 'r')
				for line in ts_file.readlines():
					t = datetime.datetime.strptime(line.strip(), 
						"%y-%m-%dT%H:%M:%S.%f")
					idx = round((t - min_time).total_seconds() / IDX_INTERVAL)
					f.write("%d\n" % idx)
				ts_file.close()
				time = time + INTERVAL

			f.close()


