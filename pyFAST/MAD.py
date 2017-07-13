from feature_extractor import FeatureExtractor
from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import datetime
import random
from dateutil.relativedelta import relativedelta

INTERVAL = relativedelta(months=+1)
data_folder = 'bp2to20_waveforms%s/'
fname_format = "bp2to20.NZ.%s.10.%s__%s__%s.mseed"
channel = 'HHZ'

Fs = 100
minfreq    = 2.0
maxfreq    = 20.0
spec_length = 6.0
spec_lag    = 0.2
fp_length   = 128
fp_lag      = 120
min_fp_length = fp_length * spec_lag + spec_length
nfreq = 32
ntimes = 64

def construct_filename(t):
	return fname_format % (
		station, channel, t.strftime('%Y%m%dT000000Z'),
		(t + INTERVAL).strftime('%Y%m%dT000000Z'))

def get_start_end_time(st, idx):
	starttime = datetime.datetime.strptime(str(st[idx].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
	endtime = datetime.datetime.strptime(str(st[idx].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
	return (starttime, endtime)

def get_segment(st, starttime, endtime, sample_length):
	delta = int((endtime - starttime).total_seconds() - sample_length)
	start_delta = random.randint(0, delta)
	sample_segment = st.slice(
		UTCDateTime((
			starttime + datetime.timedelta(seconds=start_delta)).strftime('%Y-%m-%dT%H:%M:%S.%f')),
		UTCDateTime((
			starttime + datetime.timedelta(seconds=start_delta + sample_length)).strftime('%Y-%m-%dT%H:%M:%S.%f')))
	return sample_segment


def get_haar_stats(start_time, end_time, sampling_rate=1.0):
	feats = FeatureExtractor(sampling_rate=Fs, window_length=spec_length, 
		window_lag=spec_lag, fingerprint_length=fp_length, fingerprint_lag=fp_lag)

	time = start_time
	sample_haar_images = np.zeros([0, int(nfreq) * int(ntimes)])
	while time < end_time:
		fname = construct_filename(time)
		st = read('%s%s' %((data_folder % station), fname))
		# No sampling
		if sampling_rate == 1:
			for i in range(len(st)):
				starttime, endtime = get_start_end_time(st, i)
				print starttime, endtime
				if endtime - starttime <= datetime.timedelta(seconds=min_fp_length):
					print 'continue'
					continue
				haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(st[i].data)
				sample_haar_images = np.vstack([sample_haar_images, haar_images])
		else:
			sample_length = max((time + INTERVAL - time).total_seconds() * sampling_rate, 
				min_fp_length)
			# Get a random trace that is long enough
			idx = random.randint(0, len(st) - 1)
			starttime, endtime = get_start_end_time(st, idx)
			while starttime + datetime.timedelta(seconds=sample_length) > endtime:
				idx = random.randint(0, len(st) - 1)
				starttime, endtime = get_start_end_time(st, idx)
			# Get time series sample
			segment = get_segment(st[idx], starttime, endtime, sample_length)
			haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(segment.data)
			sample_haar_images = np.vstack([sample_haar_images, haar_images])
		time += INTERVAL

	return feats.compute_haar_stats(sample_haar_images)


if __name__ == '__main__':
	station = sys.argv[1]
	start_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[3], "%y-%m")
	sampling_rate = 1.0
	if len(sys.argv) > 4:
		sampling_rate = float(sys.argv[4])
	median, mad = get_haar_stats(start_time, end_time, sampling_rate)
	f = open('mad%s-%s,%s%s.txt' % (station, channel, start_time, end_time), 'w')
	for i in range(len(median)):
		f.write('%.16f,%.16f\n' %(median[i], mad[i]))
	f.close()