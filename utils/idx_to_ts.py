import linecache
import sys
import os
import datetime
from dateutil.relativedelta import relativedelta

INTERVAL = relativedelta(months=+1)
fname_format = "ts_bp2to20.NZ.%s.10.%s__%s__%s"
fp_path = 'bp2to20_waveforms%s/fingerprints/'
ts_path = 'bp2to20_waveforms%s/timestamps/'
channel = 'HHZ'

def construct_filename(t):
	return fname_format % (station, channel, t.strftime('%Y%m%dT000000Z'), (t + INTERVAL).strftime('%Y%m%dT000000Z'))

def get_ts(idx):
	nfp = 0
	i = 0
	while i < len(index_count) and nfp + index_count[i][1] < idx:
		nfp += index_count[i][1]
		i += 1
	return linecache.getline(ts_path % station + index_count[i][0],
		(idx - nfp + 1))[:-1]

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	station = sys.argv[3]
	idx_fname = sys.argv[4]

	index_count = []
	time = start_time
	while time <= end_time:
		fname = construct_filename(time)
		# Count number of fingerprints
		num_lines = sum(1 for line in open((ts_path % station) + fname))
		index_count.append([fname, num_lines])
		time += INTERVAL

	print index_count

	fin = open(idx_fname, 'r')
	fout = open('timestamps.txt', 'w')
	for line in fin.readlines():
		idx = int(line.strip())
		fout.write('%s\n' % get_ts(idx))
	fin.close()
	fout.close()

