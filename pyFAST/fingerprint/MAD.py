from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import random
import datetime
from util import *

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
	p = params['fingerprint']
	min_fp_length = get_min_fp_length(params)
	sample_haar_images = np.zeros([0, 
		int(p['nfreq']) * int(p['ntimes'])])
	files = get_data_files(params)
	for fname in files:
		st = read(params['data']['folder'] + fname)
		# No sampling
		if p['mad_sampling_rate'] == 1:
			for i in range(len(st)):
				starttime, endtime = get_start_end_time(st, i)
				if endtime - starttime <= datetime.timedelta(seconds=min_fp_length):
					print 'continue'
					continue
				haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(st[i].data)
				sample_haar_images = np.vstack([sample_haar_images, haar_images])
		# Randomly sample sample_length proportion of data from each input file
		else:
			sample_length = max((st[len(st) - 1].stats.endtime - st[0].stats.starttime) * \
				p['mad_sampling_rate'], min_fp_length)
			# Get a random trace that is long enough
			idx = random.randint(0, len(st) - 1)
			starttime, endtime = get_start_end_time(st, idx)
			while sample_length >= min_fp_length:
				# Get time series sample
				trace_length = (endtime - starttime).total_seconds()
				if trace_length > min_fp_length:
					segment = get_segment(st[idx], starttime, endtime, min(trace_length, sample_length))
					haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(segment.data)
					sample_haar_images = np.vstack([sample_haar_images, haar_images])
					sample_length -= min(sample_length, trace_length)
				idx = random.randint(0, len(st) - 1)
				starttime, endtime = get_start_end_time(st, idx)

	return feats.compute_haar_stats(sample_haar_images)


if __name__ == '__main__':
	param_json = sys.argv[1]
	params = parse_json(param_json)
	start_time, end_time = get_start_end_times(params)
	feats = init_feature_extractor(params)

	median, mad = get_haar_stats(start_time, end_time)
	# Output MAD stats to file
	f = open(gen_mad_fname(params), 'w')
	for i in range(len(median)):
		f.write('%.16f,%.16f\n' %(median[i], mad[i]))
	f.close()