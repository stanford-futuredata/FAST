from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
from multiprocessing import Pool
import os
import sys
import random
import datetime
from util import *

def get_segment(st, starttime, endtime, sample_length):
	delta = int((endtime - starttime).total_seconds() - sample_length)
	start_delta = random.randint(0, delta)
	sample_segment = st.slice(
		UTCDateTime((
			starttime + datetime.timedelta(seconds=start_delta)).strftime('%Y-%m-%dT%H:%M:%S.%f')),
		UTCDateTime((
			starttime + datetime.timedelta(seconds=start_delta + sample_length)).strftime('%Y-%m-%dT%H:%M:%S.%f')))
	return sample_segment

def get_haar_image(fname):
	p = params['fingerprint']
	min_fp_length = get_min_fp_length(params)
	ntimes = get_ntimes(params)
	sample_haar_images = np.zeros([0, p['nfreq'] * ntimes])
	st = read(params['data']['folder'] + fname)
	# No sampling
	if p['mad_sampling_rate'] == 1:
		for i in range(len(st)):
			if st[i].stats.endtime - st[i].stats.starttime <= min_fp_length:
				print 'continue'
				continue
			haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(st[i].data)
			sample_haar_images = np.vstack([sample_haar_images, haar_images])
	# Randomly sample sample_length proportion of data from each input file 
	# at each specified sample interval
	else:
		sample_interval = p['mad_sample_interval']
		sample_length = max(sample_interval * p['mad_sampling_rate'], min_fp_length)
		curr_time = st[0].stats.starttime
		file_endtime = st[len(st) - 1].stats.endtime
		while file_endtime - curr_time >= sample_interval:
			start_offset = random.randint(0, sample_interval - sample_length)
			segment = st.slice(curr_time + start_offset,
				curr_time + start_offset + sample_length)
			if len(segment) > 0:
				data = segment[0].data
				for i in range(1, len(segment)):
					data = np.append(data, segment[i].data)
				haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(data)
				sample_haar_images = np.vstack([sample_haar_images, haar_images])
			curr_time = curr_time + sample_interval

	np.save('%s_sample' % fname, sample_haar_images)

def get_haar_stats():
	ntimes = get_ntimes(params)
	sample_haar_images = np.zeros([0, params['fingerprint']['nfreq'] * ntimes])
	files = params['data']['MAD_sample_files']
	pool = Pool(params['performance']['num_fp_thread'])
	pool.map(get_haar_image, files)
	for file in files:
		partial = np.load('%s_sample.npy' % file)
		sample_haar_images = np.vstack([sample_haar_images, partial])
		os.remove('%s_sample.npy' % file)

	return feats.compute_haar_stats(sample_haar_images)


if __name__ == '__main__':
	param_json = sys.argv[1]
	params = parse_json(param_json)
	feats = init_feature_extractor(params)

	median, mad = get_haar_stats()
	# Output MAD stats to file
	f = open(gen_mad_fname(params), 'w')
	for i in range(len(median)):
		f.write('%.16f,%.16f\n' %(median[i], mad[i]))
	f.close()