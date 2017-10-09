from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import datetime
from util import *

def write_timestamp(t, idx1, idx2, starttime, ts_file):
	fp_timestamp = np.asarray([t[int(np.mean((idx1[j], idx2[j])))] for j in range(len(idx1))])
	for ts in fp_timestamp:
		ts_file.write((starttime + datetime.timedelta(seconds = ts)).strftime('%y-%m-%dT%H:%M:%S.%f') + '\n')

def normalize_and_fingerprint(haar_images, fp_file):
	std_haar_images = feats.standardize_haar(haar_images, type = 'MAD')
	binaryFingerprints =  feats.binarize_vectors_topK_sign(std_haar_images, K = 1600)
	# Write to file
	b = np.packbits(binaryFingerprints)
	fp_file.write(b.tobytes())

def init_MAD_stats(mad_fname):
	feats.haar_medians = np.zeros(
		params['fingerprint']['nfreq'] * params['fingerprint']['ntimes'])
	feats.haar_absdevs = np.zeros(
		params['fingerprint']['nfreq'] * params['fingerprint']['ntimes'])
	f = open(mad_fname, 'r')
	for i, line in enumerate(f.readlines()):
		nums = line.split(',')
		feats.haar_medians[i] = float(nums[0])
		feats.haar_absdevs[i] = float(nums[1])
	f.close()

def init_fp_folders(params):
	# Create timestamp and fingerprint folder if not exist
	fp_folder = params['data']['folder'] + 'fingerprints/'
	ts_folder = params['data']['folder'] + 'timestamps/'
	if not os.path.exists(fp_folder):
		os.makedirs(fp_folder)
	if not os.path.exists(ts_folder):
		os.makedirs(ts_folder)
	return fp_folder, ts_folder

def get_partition_padding():
	# add this to end of time series of each partition so we don't have missing fingerprints
	sec_extra = params['fingerprint']['spec_length'] + \
		(params['fingerprint']['fp_length'] - params['fingerprint']['fp_lag']) * \
		params['fingerprint']['spec_lag']
	time_extra = datetime.timedelta(seconds=sec_extra)
	return time_extra

if __name__ == '__main__':
	fname = sys.argv[1]
	param_json = sys.argv[2]
	params = parse_json(param_json)

	feats = init_feature_extractor(params)

	mad_fname = gen_mad_fname(params)
	init_MAD_stats(mad_fname)

	fp_folder, ts_folder = init_fp_folders(params)

	# read mseed
	st = read(params['data']['folder'] + fname)
	ts_file = open(ts_folder + "ts_" + fname[:-6], "a")
	fp_file = open(fp_folder + "fp_" + fname[:-6], "a")
	time_padding = get_partition_padding()
	min_fp_length = get_min_fp_length(params)

	t00 = time.time()
	for i in range(len(st)):
		# Get start and end time of the current continuous segment
		starttime = datetime.datetime.strptime(str(st[i].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
		endtime = datetime.datetime.strptime(str(st[i].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
		# Ignore segments that are shorter than one spectrogram window length
		if endtime - starttime < datetime.timedelta(seconds = min_fp_length):
			continue

		s = starttime
		# Generate and output fingerprints per partition_len
		while endtime - s > datetime.timedelta(seconds = min_fp_length):
			dt = datetime.timedelta(
				seconds = params['performance']['partition_len'])
			e = min(s + dt, endtime)
			e_padding = min(s + dt + time_padding, endtime)
			partition_st = st[i].slice(UTCDateTime(s.strftime('%Y-%m-%dT%H:%M:%S.%f')),
				UTCDateTime(e_padding.strftime('%Y-%m-%dT%H:%M:%S.%f')))
			# Spectrogram + Wavelet transform
			haar_images, nWindows, idx1, idx2, Sxx, t  = feats.data_to_haar_images(partition_st.data)
			# Write fingerprint time stamps to file
			write_timestamp(t, idx1, idx2, s, ts_file)
			# Normalize and output fingerprints on a roughly 8 hour time interval
			normalize_and_fingerprint(haar_images, fp_file)
			s = e

	ts_file.close()
	fp_file.close()
	t000 = time.time()
	print("Binary fingerprints took: %.2f seconds" % (t000 - t00))
