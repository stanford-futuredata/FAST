########################################################################################################
## pyFAST - Fingerprint and Similarity Thresholding in python
##
## Karianne Bergen
## 11/14/2016
##
## (see Yoon et. al. 2015, Sci. Adv. for algorithm details)
##
########################################################################################################
##
## Example - 24hr single-channel continuous data
##
########################################################################################################

import numpy as np
import sys
from FAST_MinHashLSH import MinHashLSH
from feature_extractor import FeatureExtractor
import time

########################################################################################################
# Loads and saves SAC file for testing codes
########################################################################################################

from obspy import read
st = read('data/NC_CBR_EHZ_20151114','SAC')
Fs = st[0].stats.sampling_rate

    #from obspy.fdsn import Client
    #from obspy import UTCDateTime
    #from obspy.core import Stream
    #
    #minfreq    = 2.0
    #maxfreq    = 8.0
    #sampling_rate = 20.0
    #client = Client("NCEDC")
    #t = UTCDateTime("2015-11-14 00:00:00.000") 
    #dt = 24 *60 * 60  # 24 hours of data
    #dt_postbuffer = 30
    #dt_prebuffer = 10
    #dt_filter = 5
    #st = client.get_waveforms('NC', 'CBR', "*", 'EHZ', t - dt_prebuffer, t + dt + dt_postbuffer+1)
    #st.filter("bandpass", freqmin=minfreq, freqmax=maxfreq, corners=4, zerophase=True)
    #st.decimate(int(st[0].stats.sampling_rate/sampling_rate),strict_length=False,no_filter=True) 
    #st.write('data/NC_CBR_EHZ_20151114','SAC')

########################################################################################################
# Computes Binary Fingerprints from single-channel continuous data
########################################################################################################

spec_length = 10.0
spec_lag    = 0.1
fp_length   = 10.0
fp_lag      = 1.0

t00 = time.time()
feats = FeatureExtractor(sampling_rate = Fs, window_length = spec_length, window_lag = spec_lag, fingerprint_length = fp_length, fingerprint_lag = fp_lag)
haar_images, nWindows, idx1, idx2, Sxx, t  = feats.data_to_haar_images(st[0].data) 
fp_timestamp = np.asarray([t[int(np.mean((idx1[j], idx2[j])))] for j in range(len(idx1))])
feats.compute_haar_stats(haar_images)
haar_images = feats.standardize_haar(haar_images, type = 'MAD')
binaryFingerprints = feats.binarize_vectors_topK_sign(haar_images, K = 400)
nfp, nfeats = np.shape(binaryFingerprints)
t000 = time.time()
print("Computing binary fingerprints: %.4f" % (t000 - t00))


########################################################################################################
#/ TEST All-to-All search
########################################################################################################

t0 = time.time()
lshObj = MinHashLSH(nfeats,nvotes=10,near_repeats=5)
t1 = time.time()
lshObj.insert_data(binaryFingerprints,fp_timestamp)
t2 = time.time()
print("Initializing MinHashLSH object: %.4f" % (t1 - t0) )
print("Building database: %.4f" % (t2 - t1))

t5 = time.time()
detdata = lshObj.search_database_internal(fp_timestamp)
t6 = time.time()
print("Searching database (86411 queries): %.4f" % (t6 - t5))

pairs = zip(*detdata.nonzero())
sim_val = np.array([detdata[pairs[i]] for i in range(len(pairs))])
pair_i = np.array([pairs[i][0] for i in range(len(pairs))])
pair_j = np.array([pairs[i][1] for i in range(len(pairs))])

########################################################################################################
#/ TEST All-to-Some search
########################################################################################################

selected_indices = np.random.choice(nfp, 10000)
selected_timestamps = fp_timestamp[selected_indices]

t0 = time.time()
lshObj2 = MinHashLSH(nfeats,nvotes=10,near_repeats=5,storekeys=False)
t1 = time.time()

lshObj2.insert_data(binaryFingerprints[selected_indices,:],selected_timestamps)
t2 = time.time()
print("Initializing MinHashLSH object: %.4f" % (t1 - t0) )
print("Building database (subset of fingerprints): %.4f" % (t2 - t1))

t5 = time.time()
detdata2 = lshObj2.search_database_external(binaryFingerprints, fp_timestamp)
t6 = time.time()
#t7 = time.time()
print("Searching database (86411 queries): %.4f" % (t6 - t5))

pairs2   = zip(*detdata2.nonzero())
sim_val2 = np.array([detdata2[pairs2[i]] for i in range(len(pairs2))])
pair_i2 = np.array([pairs2[i][0] for i in range(len(pairs2))])
pair_j2 = np.array([pairs2[i][1] for i in range(len(pairs2))])
