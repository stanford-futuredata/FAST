from feature_extractor import FeatureExtractor
from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import datetime

data_folder = 'bp2to20_waveforms%s/'
Fs = 100
minfreq    = 2.0
maxfreq    = 20.0
spec_length = 6.0
spec_lag    = 0.2
fp_length   = 128
fp_lag      = 10
min_fp_length = fp_length * spec_lag + spec_length
partition_len = datetime.timedelta(hours=8)
nfreq = 32
ntimes = 64

def write_timestamp(t, idx1, idx2, starttime, ts_file):
	fp_timestamp = np.asarray([t[int(np.mean((idx1[j], idx2[j])))] for j in range(len(idx1))])
	for ts in fp_timestamp:
		ts_file.write((starttime + datetime.timedelta(seconds = ts)).strftime('%y-%m-%dT%H:%M:%S.%f') + '\n')

def normalize_and_fingerprint(haar_images, fp_file):
	std_haar_images = feats.standardize_haar(haar_images, type = 'MAD')
	binaryFingerprints = feats.binarize_vectors_topK_sign(std_haar_images, K = 1600)
	# Write to file
	b = np.packbits(binaryFingerprints)
	fp_file.write(b.tobytes())

def init_MAD_stats():
	feats.haar_medians = np.zeros(nfreq * ntimes)
	feats.haar_absdevs = np.zeros(nfreq * ntimes)
	f = open('mad%s.txt' % station, 'r')
	for i, line in enumerate(f.readlines()):
		nums = line.split(',')
		feats.haar_medians[i] = float(nums[0])
		feats.haar_absdevs[i] = float(nums[1])
	f.close()

if __name__ == '__main__':
	fname = sys.argv[1]
	station = sys.argv[2]

	feats = FeatureExtractor(sampling_rate=Fs, window_length=spec_length, window_lag=spec_lag, 
		fingerprint_length=fp_length, fingerprint_lag=fp_lag)
	init_MAD_stats()

	# Create timestamp and fingerprint folder if not exist
	fp_folder = data_folder % station + 'fingerprints/'
	ts_folder = data_folder % station + 'timestamps/'
	if not os.path.exists(fp_folder):
		os.makedirs(fp_folder)
	if not os.path.exists(ts_folder):
		os.makedirs(ts_folder)

	# read mseed
	st = read('%s%s' %(data_folder % station, fname))
	ts_file = open(ts_folder + "ts_" + fname[:-6], "a")
	fp_file = open(fp_folder + "fp_" + fname[:-6], "a")
	t00 = time.time()
	for i in range(len(st)):
		# Get start and end time of the current continuous segment
		starttime = datetime.datetime.strptime(str(st[i].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
		endtime = datetime.datetime.strptime(str(st[i].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
		# Ignore segments that are shorter than one spectrogram window length
		if endtime - starttime < datetime.timedelta(seconds = min_fp_length):
			continue

		s = starttime
		# Generate fingerprints per partition
		while endtime - s > datetime.timedelta(seconds = min_fp_length):
			e = min(s + partition_len, endtime)
			partition_st = st[i].slice(UTCDateTime(s.strftime('%Y-%m-%dT%H:%M:%S.%f')),
				UTCDateTime(e.strftime('%Y-%m-%dT%H:%M:%S.%f')))
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
