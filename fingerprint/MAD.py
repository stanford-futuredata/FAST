from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
from multiprocessing import Pool
import os
import sys
import random
from config import *
from feature_extractor import *


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
	sample_haar_images = []
	st = read(params['data']['folder'] + fname)
	# No sampling
	if p['mad_sampling_rate'] == 1:
		for i in range(len(st)):
			if st[i].stats.endtime - st[i].stats.starttime <= min_fp_length:
				print('continue')
				continue

			haar_images, nWindows, idx1, idx2, Sxx, t  = feats.data_to_haar_images(st[i].data)
			sample_haar_images.append(haar_images)

	# Randomly sample sample_length proportion of data from each input file 
	# path + get_ts_fname(fname))) at each specified sample interval
	else:
		# Minimum number of time series samples required to make at least one fingerprint
		MAX_SAMPLE_ITER = 1000
		min_fp_samples = int(min_fp_length * p['sampling_rate'])

		# Check that this file has enough time series data for at least one fingerprint
		# If not, don't even bother sampling this file
		flag_sample = False
		for i in range(len(st)):
			if st[i].stats.endtime - st[i].stats.starttime > min_fp_length:
				flag_sample = True
				break

		if flag_sample:
			sample_interval = p['mad_sample_interval']
			sample_length = max(sample_interval * p['mad_sampling_rate'], min_fp_length)
			curr_time = st[0].stats.starttime
			file_endtime = st[len(st) - 1].stats.endtime
			n_iter = 0
			while True:
				if n_iter > MAX_SAMPLE_ITER: # avoid infinite loop
					print("WARNING: File ", fname, " exceeded maximum number of iterations =",
						  MAX_SAMPLE_ITER, " for MAD random sampling")
					break
				n_iter += 1

				start_offset = random.randint(0, sample_interval - sample_length)
				segment = st.slice(curr_time + start_offset, curr_time + start_offset + sample_length)
				if len(segment) > 0:
					data = segment[0].data
					for i in range(1, len(segment)):
						data = np.append(data, segment[i].data)
					if len(data) > min_fp_samples: # Make sure there is enough time series data to make at least one fingerprint
						haar_images, nWindows, idx1, idx2, Sxx, t = feats.data_to_haar_images(data)
						sample_haar_images.append(haar_images)
					else: # Next time, hit a time segment long enough for at least one fingerprint?
						continue
				else: # Next time, don't hit a time gap?
					continue

				curr_time = curr_time + sample_interval
				if file_endtime - curr_time < sample_interval:
					break
		else:
			print("WARNING: File ", fname, " not enough time series data for MAD random sampling")

	if len(sample_haar_images):
		total_haar_images = np.concatenate(sample_haar_images, axis=0)
		np.save(mad_folder+'%s_sample.npy' % fname, total_haar_images)
	else:
		print("WARNING: File ", fname, " NOT SAMPLED FOR MAD CALCULATION")


def get_haar_stats():
	files = params['data']['MAD_sample_files']
	pool = Pool(min(params['performance']['num_fp_thread'], len(files)))
	pool.map(get_haar_image, files)
	sample_haar_images = []
	for file in files:
		file_name = mad_folder+'%s_sample.npy' % file
		if os.path.isfile(file_name):
			partial = np.load(file_name)
			sample_haar_images.append(partial)
			os.remove(file_name)
		else:
			print("WARNING: File not included in MAD SAMPLE", file_name)

	total_haar_images = np.concatenate(sample_haar_images, axis=0)
	return feats.compute_haar_stats(total_haar_images, type='MAD')


if __name__ == '__main__':
	t_start = time.time()
	param_json = sys.argv[1]
	params = parse_json(param_json)
	feats = init_feature_extractor(params, get_ntimes(params))

	mad_folder = params['data']['folder'] + 'mad/'
	if not os.path.exists(mad_folder):
		os.makedirs(mad_folder)

	median, mad = get_haar_stats()
	# Output MAD stats to file
	f = open(gen_mad_fname(params), 'w')
	for i in range(len(median)):
		f.write('%.16f,%.16f\n' %(median[i], mad[i]))
	f.close()
	t_end = time.time()
	print("MAD fingerprints took: %.2f seconds" % (t_end - t_start))
