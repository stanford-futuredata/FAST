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
## Feature Extraction (Fingerprinting)
##
########################################################################################################

import numpy as np
import pywt as wt
from sklearn.preprocessing import normalize
from scipy.signal import spectrogram
from scipy.misc import imresize


def init_feature_extractor(params, ntimes):
    feats = FeatureExtractor(sampling_rate=params['fingerprint']['sampling_rate'],
        window_length=params['fingerprint']['spec_length'],
        window_lag=params['fingerprint']['spec_lag'],
        fingerprint_length=params['fingerprint']['fp_length'],
        fingerprint_lag=params['fingerprint']['fp_lag'],
        min_freq=params['fingerprint']["min_freq"],
        max_freq=params['fingerprint']["max_freq"],
        nfreq=params['fingerprint']['nfreq'],
        ntimes=ntimes)
    return feats


class FeatureExtractor(object):

    def __init__(self, sampling_rate, window_length, window_lag, fingerprint_length, fingerprint_lag, 
                min_freq = 0, max_freq = None, nfreq = 32, ntimes = 64):
        self.sampling_rate = sampling_rate             #/ sampling rate
        self.window_len    = window_length             #/ length of window (seconds) used in spectrogram
        self.window_lag    = window_lag                #/ window lag (seconds) used in spectrogram
        self.fp_len        = fingerprint_length        #/ width of fingerprint (samples)
        self.fp_lag        = fingerprint_lag           #/ lag between fingerprints (samples)
        self.max_freq      = self._initialize_frequencies(max_freq)  #/ minimum and maximum frequencies for bandpass filter
        self.min_freq      = min_freq
        self.new_d1        = int(nfreq)                #/ number of frequency / time bins in fingerprints (must be power of 2) - TODO: error checking
        self.new_d2        = int(ntimes)
        self.d1            = None                      #/ dimension of spectral images prior to resizing
        self.d2            = None
        self.haar_means    = None
        self.haar_stddevs  = None
        self.haar_medians  = None
        self.haar_absdevs  = None

    def _initialize_frequencies(self, max_freq):    #/ initializes data structure
        if max_freq is None:
            max_freq = self.sampling_rate/2.0
        return max_freq

    def update(self, field, value):
        if hasattr(self, field):
            setattr(self, field, value)
        else:
             print('WARNING: object has no attribute: ' + field)
             print('object has the following attributes:' + self.__dict__.keys())
        return

    def get_params(self):
        mdict = dict()
        for k in self.__dict__.keys():
          if k not in ['haar_means','haar_stddevs','haar_absdevs','haar_medians']:
            mdict[k] =  self.__dict__[k]
        return mdict

    #/ returns indicies for overlapping windows
    def get_window_params(self, N, L, dL):
        idx0 = np.asarray(range(0, N+1, dL))
        idx2 = np.asarray(range(L,N+1,dL))
        nWindows = len(idx2)
        idx1 = idx0[0:nWindows]
        return nWindows, idx1, idx2

    ########################################################################
    ##     FOR COMPUTING FINGERPRINTS                                     ##
    ########################################################################

    #/ computes spectrogram from continous timeseries data
    def data_to_spectrogram(self, x_data, window_type = 'hanning'):
        f, t, Sxx = spectrogram(x_data, fs=self.sampling_rate,
            window=window_type, nperseg=int(self.sampling_rate*self.window_len),
            noverlap = int(self.sampling_rate*(self.window_len - self.window_lag)))
        # Truncate spectrogram, keep only passband frequencies
        if self.min_freq > 0:
            fidx_keep = (f >= self.min_freq)
            Sxx = Sxx[fidx_keep, :]
            f = f[fidx_keep]
        if self.max_freq < f[-1]:
            fidx_keep = (f <= self.max_freq)
            Sxx = Sxx[fidx_keep, :]
            f = f[fidx_keep]
        self.frequencies = f
        self.times = t
        return f, t, Sxx

    #/ breaks spectrogram into overlapping spectral images
    def spectrogram_to_spectral_images(self, Sxx):
        nFreq, nTimes = np.shape(Sxx)
        nWindows, idx1, idx2 = self.get_window_params(nTimes, self.fp_len, self.fp_lag)
        spectral_images = np.zeros([nWindows, nFreq, self.fp_len])
        for i in range(nWindows):
            spectral_images[i,:,:] = Sxx[:,idx1[i]:idx2[i]]
        self.nwindows = nWindows
        nWindows, self.d1, self.d2 = np.shape(spectral_images)
        #self.new_d1, self.new_d2 = np.exp2(np.floor(np.log2([self.d1, self.d2])))
        return spectral_images, nWindows, idx1, idx2

    #/ resizes each spectral image to specified dimensions
    def _resize_spectral_images(self, spectral_images, new_d1, new_d2):
        new_spectral_images = np.zeros([self.nwindows,new_d1,new_d2])
        for i in range(self.nwindows):
            new_spectral_images[i,:,:] = imresize(spectral_images[i,:,:], (new_d1, new_d2), interp='bilinear', mode='F')
        return new_spectral_images

    #/ reshapes output from PyWavelets 2d wavelet transform into image
    def _unwrap_wavelet_coeffs(self,coeffs):
        L = len(coeffs)
        cA = coeffs[0]
        for i in range(1,L):
            (cH, cV, cD) = coeffs[i]
            cA = np.concatenate((np.concatenate((cA, cV),axis= 1),np.concatenate((cH, cD),axis = 1)),axis=0)
        return cA

    #/ computes wavelet transform for each spectral image
    def spectral_images_to_wavelet(self, spectral_images, wavelet = wt.Wavelet('db1')):
        if (int(self.new_d1)!=self.d1) or (int(self.new_d2)!=self.d2):
            spectral_images = self._resize_spectral_images(spectral_images, self.new_d1, self.new_d2)
        haar_images = np.zeros([self.nwindows,self.new_d1,self.new_d2])
        for i in range(self.nwindows):
            coeffs = wt.wavedec2(spectral_images[i,:,:], wavelet)
            haar_images[i,:,:] = self._unwrap_wavelet_coeffs(coeffs)
        return haar_images

    #/ computes (normalized) haar_images from continous timeseries data
    def data_to_haar_images(self, x_data):
        f, t, Sxx = self.data_to_spectrogram(x_data)
        spectral_images, nWindows, idx1, idx2 = self.spectrogram_to_spectral_images(Sxx)
        haar_images = self.spectral_images_to_wavelet(spectral_images)
        haar_images = normalize(self._images_to_vectors(haar_images), axis=1)
        return haar_images, nWindows, idx1, idx2, Sxx, t

    #/ converts set of images to array of vectors
    def _images_to_vectors(self,images):
        N,d1,d2 = np.shape(images)
        vectors = np.zeros([N,d1*d2])
        for i in range(N):
            vectors[i,:] = np.reshape(images[i,:,:], (1,d1*d2))
        return vectors

    #/ converts set of vectors into set of images (of dimension d1 x d2)
    def _vectors_to_images(self, vectors, d1, d2):
        N,D = np.shape(vectors)
        if D != d1*d2:
            print('warning: invalid dimensions')
            return vectors
        else:
            images = np.zeros([N,d1,d2])
            for i in range(N):
                images[i,:,:] = np.reshape(vectors[i,:], (d1,d2))
            return images

    def compute_haar_stats(self, haar_images,type = None):
        if type is 'MAD':
            shape = haar_images.shape
            medians = []
            for i in range(shape[1]):
                medians.append(np.median(haar_images[:, i]))
            self.haar_medians = np.array(medians)

            mad = []
            for i in range(shape[1]):
                tmp = abs(haar_images[:, i] - medians[i])
                mad.append(np.median(tmp))
            self.haar_absdevs  = np.array(mad)

            return self.haar_medians, self.haar_absdevs
        if type is 'Zscore':
            self.haar_means   = np.mean(haar_images,axis=0)
            self.haar_stddevs = np.std(haar_images,axis=0)
            return self.haar_means, self.haar_stddevs

    def standardize_haar(self, haar_images, type = 'MAD'):
        if type is 'Zscore':
            haar_images = (haar_images - self.haar_means)/self.haar_stddevs
            return haar_images
        elif type is 'MAD':
            haar_images = (haar_images - self.haar_medians)/self.haar_absdevs
            return haar_images
        else:
            print('Warning: invalid type - select type MAD or Zscore')
            return None

    def binarize_vectors_topK_sign(self, coeff_vectors, K):
        self.K = K
        N,M = np.shape(coeff_vectors)
        binary_vectors = np.zeros((N,2*M), dtype=bool)
        for i in range(N):
            idx = np.argsort(abs(coeff_vectors[i,:]))[-K:]
            binary_vectors[i,idx]   = coeff_vectors[i,idx] > 0
            binary_vectors[i,idx+M] = coeff_vectors[i,idx] < 0
        return binary_vectors

    def vectors_to_topK_sign(self, coeff_vectors, K):
        self.K = K
        N,M = np.shape(coeff_vectors)
        sign_vectors = np.zeros([N,M])
        for i in range(N):
            idx = np.argsort(abs(coeff_vectors[i,:]))[-K:]
            sign_vectors[i,idx] = np.sign(coeff_vectors[i,idx])
        return sign_vectors

    def sign_to_binary(self, vector):
        L = len(vector)
        new_vec = np.zeros((L,2), dtype=bool)
        new_vec[:,0] = vector > 0
        new_vec[:,1] = vector < 0
        return  np.reshape(new_vec, (1,2*L))

    def binarize_vectors_topK(self, coeff_vectors, K):
        self.K = K
        N,M = np.shape(coeff_vectors)
        sign_vectors = np.zeros((N,M),dtype=bool)
        for i in range(N):
            idx = np.argsort(coeff_vectors[i,:])[-K:]
            sign_vectors[i,idx] = 1
        return sign_vectors

    def jaccard_sim(self, vec1, vec2):
        return sum(vec1 & vec2)/ (1.0*sum(vec1 | vec2))

