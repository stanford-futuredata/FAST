import matplotlib.pyplot as plt
from matplotlib import rcParams
import numpy as np

class FastTime:
   def __init__(self):
      self.duration = np.array([]) # number of days in continuous data
      self.spectrogram = np.array([])
      self.specImageWavelet = np.array([])
      self.binaryFingerprint = np.array([])
      self.minhash = np.array([])
      self.database = np.array([])
      self.similaritysearch = np.array([])
      self.memory_fingerprint = np.array([])

   def get_feature_extraction_runtime(self):
      return self.spectrogram + self.specImageWavelet + self.binaryFingerprint

   def get_similarity_search_runtime(self):
      return self.minhash + self.database + self.similaritysearch


## All runtimes are in s
#ccob_ehn = FastTime()
#ccob_ehn.duration = np.array([1, 7, 32, 90]) 
#ccob_ehn.spectrogram = np.array([8, 61.9318, 563.408, 784.4172])
#ccob_ehn.specImageWavelet = np.array([131.6215, 1170.94, 13599.98, 14778.3085]) 
#ccob_ehn.binaryFingerprint = np.array([47.5761, 949.2784, 1856.893, 7026.1152])
#ccob_ehn.minhash = np.array([119.78, 616.05, 4108.58, 9076.76])
#ccob_ehn.database = np.array([5.7, 26.97, 235.4, 437.96])
#ccob_ehn.similaritysearch = np.array([59, 2959.0, 20638.76, 112114.4])
#ccob_ehn.memory_fingerprint = np.array([0.353817, 2.477183, 10.970649, 31.850418]) # memory in GB
#runtime_feature_extraction = ccob_ehn.get_feature_extraction_runtime()
#runtime_similarity_search = ccob_ehn.get_similarity_search_runtime()

# Nfuncs=6, all runtimes in s
ccob_ehn_nfuncs6 = FastTime()
ccob_ehn_nfuncs6.duration = np.array([1, 3, 7, 14, 31, 90, 181]) 
ccob_ehn_nfuncs6.spectrogram = np.array([8.95, 26.1841, 61.9318, 120.748, 270.044, 784.4172, 1570])
ccob_ehn_nfuncs6.specImageWavelet = np.array([131.6215, 497.7987, 1170.94, 2330.6663, 5125.96, 14778.3085, 29558]) 
ccob_ehn_nfuncs6.binaryFingerprint = np.array([36.5906, 101.9178, 237.5582, 477.2111, 1856.893, 7026.1152, 12952.5539])
ccob_ehn_nfuncs6.minhash = np.array([99.46, 303.13, 762.32, 1404.36, 4226.33, 9076.76, 18226.48])
ccob_ehn_nfuncs6.database = np.array([5.63, 16.14, 39.3, 77.75, 218.16, 437.96, 1083.54])
ccob_ehn_nfuncs6.similaritysearch = np.array([14.09, 109.58, 634.07, 2604.83, 20631.2, 112114.4, 615703.4])
ccob_ehn_nfuncs6.memory_fingerprint = np.array([0.353817, 1.061605, 2.477183, 4.954443, 10.970649, 31.850418, 64.054809]) # memory in GB
ccob_ehn_nfuncs6.memory_database = np.array([0.468, 1.1, 2.0, 3.3, 6.1, 14, 25]) # memory in GB
#runtime_feature_extraction = ccob_ehn_nfuncs6.get_feature_extraction_runtime()
#runtime_similarity_search = ccob_ehn_nfuncs6.get_similarity_search_runtime()
#runtime_total = runtime_feature_extraction + runtime_similarity_search

# Nfuncs=7, all runtimes in s
ccob_ehn_nfuncs7 = FastTime()
ccob_ehn_nfuncs7.duration = ccob_ehn_nfuncs6.duration
ccob_ehn_nfuncs7.spectrogram = ccob_ehn_nfuncs6.spectrogram
ccob_ehn_nfuncs7.specImageWavelet = ccob_ehn_nfuncs6.specImageWavelet
ccob_ehn_nfuncs7.binaryFingerprint = ccob_ehn_nfuncs6.binaryFingerprint
ccob_ehn_nfuncs7.minhash = np.array([115.93, 364.36, 859.05, 1862.42, 4031.1, 10758.29, 22380.39])
ccob_ehn_nfuncs7.database = np.array([6.92, 19.95, 45.36, 97.34, 225.69, 536.21, 1048.94])
ccob_ehn_nfuncs7.similaritysearch = np.array([5.1, 34.97, 183.45, 712.1, 3604.79, 29926.02, 136237.32])
ccob_ehn_nfuncs7.memory_fingerprint = ccob_ehn_nfuncs6.memory_fingerprint
ccob_ehn_nfuncs7.memory_database = np.array([0.663, 1.5, 3.0, 5.1, 9.4, 21, 36]) # memory in GB
runtime_feature_extraction = ccob_ehn_nfuncs7.get_feature_extraction_runtime()
runtime_similarity_search = ccob_ehn_nfuncs7.get_similarity_search_runtime()
runtime_total = runtime_feature_extraction + runtime_similarity_search

# Autocorrelation
ac_duration = np.array([1, 7]) # data duration (days)
ac_runtime_total = np.array([16199, 826786]) # runtime (s)


#rcParams.update({'font.size': 18})
out_dir = '../../../figures/SciAdv/'

# Plot runtimes on linear scale: each part of algorithm
plt.figure(0)
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.spectrogram, 'o-', label='Spectrogram')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.specImageWavelet, 'o-', label='SpecImage/Wavelet')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.binaryFingerprint, 'o-', label='Binary Fingerprint')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.minhash, 'o-', label='Min-Hash')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.database, 'o-', label='Database Generation')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.title('Runtime, NCSN CCOB.EHN')
plt.savefig(out_dir+'NCSN_CCOB_EHN_runtime_breakdown.png')

# Plot overall runtimes on linear scale
plt.figure(1)
plt.plot(ccob_ehn_nfuncs7.duration, runtime_feature_extraction, 'o-', label='Feature Extraction')
plt.plot(ccob_ehn_nfuncs7.duration, runtime_similarity_search, 'o-', label='Similarity Search')
plt.plot(ccob_ehn_nfuncs7.duration, runtime_total, 'o-', label='FAST Total Runtime')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.title('Runtime vs. Continuous data duration')
plt.savefig(out_dir+'NCSN_CCOB_EHN_runtime_vs_data_duration.png')

# Fit to data (log space)
log_duration = np.log10(ccob_ehn_nfuncs7.duration)
log_runtime_feature_extraction = np.log10(runtime_feature_extraction)
log_runtime_similarity_search = np.log10(runtime_similarity_search)
log_runtime_total = np.log10(runtime_total)
log_memory_fingerprint = np.log10(ccob_ehn_nfuncs7.memory_fingerprint)
log_memory_database = np.log10(ccob_ehn_nfuncs7.memory_database)
log_ac_duration = np.log10(ac_duration)
log_ac_runtime_total = np.log10(ac_runtime_total)

pf = np.polyfit(log_duration, log_runtime_feature_extraction, 1)
print "pf = ", pf
ps = np.polyfit(log_duration, log_runtime_similarity_search, 1)
print "ps = ", ps
pp = np.polyfit(log_duration, log_runtime_total, 1)
print "pp = ", pp
pmf = np.polyfit(log_duration, log_memory_fingerprint, 1)
print "pmf = ", pmf
pmd = np.polyfit(log_duration, log_memory_database, 1)
print "pmd = ", pmd
pac = np.polyfit(log_ac_duration, log_ac_runtime_total, 1)
print "pac = ", pac

# Create least-squares best-fit lines (log space)
synth_duration = np.logspace(0, 4, num=100)
fit_runtime_feature_extraction = (10**pf[1])*(synth_duration**pf[0])
fit_runtime_similarity_search = (10**ps[1])*(synth_duration**ps[0])
fit_runtime_total = fit_runtime_feature_extraction + fit_runtime_similarity_search
fit_ac_runtime_total = (10**pac[1])*(synth_duration**pac[0])
fit_memory_fingerprint = (10**pmf[1])*(synth_duration**pmf[0])
fit_memory_database = (10**pmd[1])*(synth_duration**pmd[0])

# Plot runtimes on log scale: each part of algorithm
plt.figure(2)
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.spectrogram, 'o-', label='Spectrogram')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.specImageWavelet, 'o-', label='SpecImage/Wavelet')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.binaryFingerprint, 'o-', label='Binary Fingerprint')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.minhash, 'o-', label='Min-Hash')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.database, 'o-', label='Database Generation')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=14)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.xlim([0.8, 300])
plt.title('Runtime, NCSN CCOB.EHN')
plt.savefig(out_dir+'loglog_NCSN_CCOB_EHN_runtime_breakdown.png')

# Plot overall runtimes on log scale
plt.figure(3)
plt.loglog(ccob_ehn_nfuncs7.duration, runtime_feature_extraction, 'o-', label='Feature Extraction')
plt.loglog(ccob_ehn_nfuncs7.duration, runtime_similarity_search, 'o-', label='Similarity Search')
plt.loglog(ccob_ehn_nfuncs7.duration, runtime_total, 'o-', label='FAST Total Runtime')
plt.loglog(ac_duration, ac_runtime_total, 'o-', color='purple', label='Autocorrelation Runtime')
plt.loglog(synth_duration[21:], fit_ac_runtime_total[21:], '--', color='purple')
#plt.loglog(synth_duration, fit_runtime_total, '--', label='FAST Best-Fit Total Runtime')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.xlim([0.8, 300])
plt.ylim([1e2, 1e10])
plt.title('Runtime Scaling with Data Duration')
plt.savefig(out_dir+'loglog_NCSN_CCOB_EHN_runtime_vs_data_duration.png')

# Check log scale
plt.figure(4)
plt.plot(log_duration, log_runtime_feature_extraction, 'o-', label='Feature Extraction')
plt.plot(log_duration, log_runtime_similarity_search, 'o-', label='Similarity Search')
plt.plot(log_duration, log_runtime_total, 'o-', label='FAST Total Runtime')
plt.plot(log_ac_duration, log_ac_runtime_total, 'o-', label='Autocorrelation Runtime')
plt.legend(loc=2, fontsize=16)
plt.xlim([-0.0969, 2.477])
plt.ylim([2, 10])
plt.xlabel('log(Continuous data duration (days))')
plt.ylabel('log(Runtime (s))')
plt.title('Runtime vs. Continuous data duration')
plt.savefig(out_dir+'logset_NCSN_CCOB_EHN_runtime_vs_data_duration.png')

# Plot memory usage on linear scale
plt.figure(5)
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.memory_fingerprint, 'o-', label='Binary Fingerprint')
plt.plot(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.memory_database, 'o-', label='Database')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Memory usage (GB)')
plt.title('Memory usage vs. Continuous data duration')
plt.savefig(out_dir+'NCSN_CCOB_EHN_memory_vs_data_duration.png')

# Plot memory usage on log scale
plt.figure(6)
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.memory_fingerprint, 'o-', label='Binary Fingerprint')
plt.loglog(ccob_ehn_nfuncs7.duration, ccob_ehn_nfuncs7.memory_database, 'o-', label='Database')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Memory usage (GB)')
plt.xlim([0.8, 300])
plt.title('Memory Scaling with Data Duration')
plt.savefig(out_dir+'loglog_NCSN_CCOB_EHN_memory_vs_data_duration.png')


#duration = [0.5, 1, 1.5, 2, 4, 7, 14]
#mem_database = [6.175, 7.123, 8.135, 9.21, 13.8, 18.3, 29.9]
#mem_search = [6.67, 8.741, 10.2, 12.1, 22.6, 46, 35]
#time_search = [70.85, 263.61, 583.2, 1001.9, 4075.02, 12737, 79715.21]
#
#plt.figure(0)
#plt.plot(duration, mem_database, 'o-', label='Database')
#plt.plot(duration, mem_search, 'o-', label='Search')
#plt.legend()
#plt.xlabel('Continuous data duration (days)')
#plt.ylabel('Memory from top (GB)')
#plt.title('Memory usage for FAST on Guy Arkansas data')
#plt.savefig(out_dir+'20100701_Guy_memory_usage.png')
#
#plt.figure(1)
#plt.plot(duration, time_search, 'o-')
#plt.xlabel('Continuous data duration (days)')
#plt.ylabel('Similarity search runtime (s)')
#plt.title('FAST similarity search runtime on Guy Arkansas data')
#plt.savefig(out_dir+'20100701_Guy_search_runtime.png')
##plt.show()

