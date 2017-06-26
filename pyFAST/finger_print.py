from feature_extractor import FeatureExtractor
from obspy import read
import numpy as np
import time
from obspy.core import UTCDateTime
import os
import sys
import datetime

data_folder = 'waveformsKHZ/'
fp_folder = data_folder + 'fingerprints/'
ts_folder = data_folder + 'timestamps/'
if not os.path.exists(fp_folder):
	os.makedirs(fp_folder)
if not os.path.exists(ts_folder):
	os.makedirs(ts_folder)
Fs = 20
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
feats = FeatureExtractor(sampling_rate=Fs, window_length=spec_length, window_lag=spec_lag, 
		fingerprint_length=fp_length, fingerprint_lag=fp_lag)

def write_timestamp(t, idx1, idx2, starttime, ts_file):
	fp_timestamp = np.asarray([t[int(np.mean((idx1[j], idx2[j])))] for j in range(len(idx1))])
	for ts in fp_timestamp:
		ts_file.write((starttime + datetime.timedelta(seconds = ts)).strftime('%y-%m-%dT%H:%M:%S.%f') + '\n')

def normalize_and_fingerprint(partial_haar_images, fp_file):
	feats.compute_haar_stats(partial_haar_images)
	std_haar_images = feats.standardize_haar(partial_haar_images, type = 'MAD')
	binaryFingerprints = feats.binarize_vectors_topK_sign(std_haar_images, K = 1600)
	# Write to file
	b = np.packbits(binaryFingerprints)
	fp_file.write(b.tobytes())

if __name__ == '__main__':
	fname = sys.argv[1]
	st = read('%s%s' %(data_folder, fname))
	# Downsample to 20 Hz
	st.decimate(5)

	ts_file = open(ts_folder + "ts_" + fname[:-6], "a")
	fp_file = open(fp_folder + "fp_" + fname[:-6], "a")
	last_normalized = datetime.datetime.strptime(str(st[0].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
	partial_haar_images = np.zeros([0, int(nfreq) * int(ntimes)])
	t00 = time.time()
	for i in range(len(st)):
		# Get start and end time of the current continuous segment
		starttime = datetime.datetime.strptime(str(st[i].stats.starttime), '%Y-%m-%dT%H:%M:%S.%fZ')
		endtime = datetime.datetime.strptime(str(st[i].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
		# Ignore segments that are shorter than one spectrogram window length
		if endtime - starttime < datetime.timedelta(seconds = min_fp_length):
			continue

		if last_normalized + partition_len <= starttime + datetime.timedelta(seconds = min_fp_length):
			normalize_and_fingerprint(partial_haar_images, fp_file)
			last_normalized = min(last_normalized + partition_len, starttime)
			partial_haar_images = np.zeros([0, int(nfreq) * int(ntimes)])

		# Generate fingerprints per partition
		s = starttime
		while starttime > last_normalized + partition_len:
			last_normalized += partition_len
		while endtime - s > datetime.timedelta(seconds = min_fp_length):
			e = min(min(last_normalized, s) + partition_len, endtime)
			partition_st = st[i].slice(UTCDateTime(s.strftime('%Y-%m-%dT%H:%M:%S.%f')),
				UTCDateTime(e.strftime('%Y-%m-%dT%H:%M:%S.%f')))
			# Spectrogram + Wavelet transform
			haar_images, nWindows, idx1, idx2, Sxx, t  = feats.data_to_haar_images(partition_st.data)
			# Write fingerprint time stamps to file
			write_timestamp(t, idx1, idx2, s, ts_file)
			# Normalize and output fingerprints on a roughly 8 hour time interval
			partial_haar_images = np.vstack([partial_haar_images, haar_images])
			if last_normalized + partition_len <= e:
				normalize_and_fingerprint(partial_haar_images, fp_file)
				last_normalized = e
				partial_haar_images = np.zeros([0, int(nfreq) * int(ntimes)])

			s = e

	# Output last segment
	endtime = datetime.datetime.strptime(str(st[len(st) - 1].stats.endtime), '%Y-%m-%dT%H:%M:%S.%fZ')
	if endtime - last_normalized >= datetime.timedelta(seconds = min_fp_length):
		normalize_and_fingerprint(partial_haar_images, fp_file)

	ts_file.close()
	fp_file.close()
	t000 = time.time()
	print("Binary fingerprints took: %.2f seconds" % (t000 - t00))
