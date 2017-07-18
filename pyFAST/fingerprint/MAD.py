from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import random
import params
import datetime
from feature_extractor import FeatureExtractor

def construct_filename(t):
	fname_format = "bp2to20.NZ.%s.10.%s__%s__%s.mseed"
	return fname_format % (
		params.station, params.channel, t.strftime('%Y%m%dT000000Z'),
		(t + params.INTERVAL).strftime('%Y%m%dT000000Z'))

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


def get_haar_stats(start_time, end_time):
	time = start_time
	sample_haar_images = np.zeros([0, int(params.nfreq) * int(params.ntimes)])
	while time < end_time:
		fname = construct_filename(time)
		st = read('%s%s' %((params.data_folder % params.station), fname))
		# No sampling
		if params.sampling_rate == 1:
			for i in range(len(st)):
				starttime, endtime = get_start_end_time(st, i)
				if endtime - starttime <= datetime.timedelta(seconds=params.min_fp_length):
					print 'continue'
					continue
				haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(st[i].data)
				sample_haar_images = np.vstack([sample_haar_images, haar_images])
		# Randomly sample sample_length proportion of data from each input file
		else:
			sample_length = max((time + params.INTERVAL - time).total_seconds() 
				* params.sampling_rate, params.min_fp_length)
			# Get a random trace that is long enough
			idx = random.randint(0, len(st) - 1)
			starttime, endtime = get_start_end_time(st, idx)
			while sample_length >= params.min_fp_length:
				# Get time series sample
				trace_length = (endtime - starttime).total_seconds()
				segment = get_segment(st[idx], starttime, endtime, min(trace_length, sample_length))
				haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(segment.data)
				sample_haar_images = np.vstack([sample_haar_images, haar_images])
				sample_length -= min(sample_length, trace_length)
				idx = random.randint(0, len(st) - 1)
				starttime, endtime = get_start_end_time(st, idx)
		time += params.INTERVAL

	return feats.compute_haar_stats(sample_haar_images)


if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	feats = FeatureExtractor(sampling_rate=params.Fs, window_length=params.spec_length, 
		window_lag=params.spec_lag, fingerprint_length=params.fp_length, 
		fingerprint_lag=params.fp_lag)

	median, mad = get_haar_stats(start_time, end_time)
	# Output MAD stats to file
	f = open('mad%s-%s-%s%s.txt' % (
		params.station, params.channel, sys.argv[1], sys.argv[2]), 'w')
	for i in range(len(median)):
		f.write('%.16f,%.16f\n' %(median[i], mad[i]))
	f.close()