import matplotlib.pyplot as plt
from matplotlib import rcParams
import numpy as np

out_dir = '../../../figures/WHAR/'

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

# Nfuncs=8, all runtimes in s
whar_hhe_nfuncs8 = FastTime()
whar_hhe_nfuncs8.duration = np.array([31, 92])
whar_hhe_nfuncs8.spectrogram = np.array([1329.2327, 3878.0631])
whar_hhe_nfuncs8.specImageWavelet = np.array([13802.6173, 40484.9395]) 
whar_hhe_nfuncs8.binaryFingerprint = np.array([17216.6836, 8687.0575+5566.0073+6387.466])
whar_hhe_nfuncs8.minhash = np.array([20613.89, 42227.39])
whar_hhe_nfuncs8.database = np.array([1536.81, 1547.67])
whar_hhe_nfuncs8.similaritysearch = np.array([58647.13, 352508.12])
whar_hhe_nfuncs8.memory_fingerprint = np.array([37, 110]) # memory in GB
whar_hhe_nfuncs8.memory_database = np.array([29, 66]) # memory in GB
whar_hhe_nfuncs8.memory_similaritysearch = np.array([34, 226])
runtime_feature_extraction = whar_hhe_nfuncs8.get_feature_extraction_runtime()
runtime_similarity_search = whar_hhe_nfuncs8.get_similarity_search_runtime()
runtime_total = runtime_feature_extraction + runtime_similarity_search

# Autocorrelation
#ac_duration = np.array([1, 7]) # data duration (days)
#ac_runtime_total = np.array([16199, 826786]) # runtime (s)


#rcParams.update({'font.size': 18})

# Plot runtimes on linear scale: each part of algorithm
plt.figure(0)
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.spectrogram, 'o-', label='Spectrogram')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.specImageWavelet, 'o-', label='SpecImage/Wavelet')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.binaryFingerprint, 'o-', label='Binary Fingerprint')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.minhash, 'o-', label='Min-Hash')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.database, 'o-', label='Database Generation')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.title('Runtime, WHAR.HHE')
plt.savefig(out_dir+'WHAR_HHE_runtime_breakdown.png')

# Plot overall runtimes on linear scale
plt.figure(1)
plt.plot(whar_hhe_nfuncs8.duration, runtime_feature_extraction, 'o-', label='Feature Extraction')
plt.plot(whar_hhe_nfuncs8.duration, runtime_similarity_search, 'o-', label='Similarity Search')
plt.plot(whar_hhe_nfuncs8.duration, runtime_total, 'o-', label='FAST Total Runtime')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
plt.title('Runtime vs. Continuous data duration')
plt.savefig(out_dir+'WHAR_HHE_runtime_vs_data_duration.png')
#
## Fit to data (log space)
#log_duration = np.log10(whar_hhe_nfuncs8.duration)
#log_runtime_feature_extraction = np.log10(runtime_feature_extraction)
#log_runtime_similarity_search = np.log10(runtime_similarity_search)
#log_runtime_total = np.log10(runtime_total)
#log_memory_fingerprint = np.log10(whar_hhe_nfuncs8.memory_fingerprint)
#log_memory_database = np.log10(whar_hhe_nfuncs8.memory_database)
#log_ac_duration = np.log10(ac_duration)
#log_ac_runtime_total = np.log10(ac_runtime_total)
#
#pf = np.polyfit(log_duration, log_runtime_feature_extraction, 1)
#print "pf = ", pf
#ps = np.polyfit(log_duration, log_runtime_similarity_search, 1)
#print "ps = ", ps
#pp = np.polyfit(log_duration, log_runtime_total, 1)
#print "pp = ", pp
#pmf = np.polyfit(log_duration, log_memory_fingerprint, 1)
#print "pmf = ", pmf
#pmd = np.polyfit(log_duration, log_memory_database, 1)
#print "pmd = ", pmd
#pac = np.polyfit(log_ac_duration, log_ac_runtime_total, 1)
#print "pac = ", pac
#
## Create least-squares best-fit lines (log space)
#synth_duration = np.logspace(0, 4, num=100)
#fit_runtime_feature_extraction = (10**pf[1])*(synth_duration**pf[0])
#fit_runtime_similarity_search = (10**ps[1])*(synth_duration**ps[0])
#fit_runtime_total = fit_runtime_feature_extraction + fit_runtime_similarity_search
#fit_ac_runtime_total = (10**pac[1])*(synth_duration**pac[0])
#fit_memory_fingerprint = (10**pmf[1])*(synth_duration**pmf[0])
#fit_memory_database = (10**pmd[1])*(synth_duration**pmd[0])

# Plot runtimes on log scale: each part of algorithm
plt.figure(2)
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.spectrogram, 'o-', label='Spectrogram')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.specImageWavelet, 'o-', label='SpecImage/Wavelet')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.binaryFingerprint, 'o-', label='Binary Fingerprint')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.minhash, 'o-', label='Min-Hash')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.database, 'o-', label='Database Generation')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=14)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
#plt.xlim([0.8, 300])
plt.title('Runtime, WHAR.HHE')
plt.savefig(out_dir+'loglog_WHAR_HHE_runtime_breakdown.png')

# Plot overall runtimes on log scale
plt.figure(3)
plt.loglog(whar_hhe_nfuncs8.duration, runtime_feature_extraction, 'o-', label='Feature Extraction')
plt.loglog(whar_hhe_nfuncs8.duration, runtime_similarity_search, 'o-', label='Similarity Search')
plt.loglog(whar_hhe_nfuncs8.duration, runtime_total, 'o-', label='FAST Total Runtime')
#plt.loglog(ac_duration, ac_runtime_total, 'o-', color='purple', label='Autocorrelation Runtime')
#plt.loglog(synth_duration[21:], fit_ac_runtime_total[21:], '--', color='purple')
##plt.loglog(synth_duration, fit_runtime_total, '--', label='FAST Best-Fit Total Runtime')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Runtime (s)')
#plt.xlim([0.8, 300])
#plt.ylim([1e2, 1e10])
plt.title('Runtime Scaling with Data Duration')
plt.savefig(out_dir+'loglog_WHAR_HHE_runtime_vs_data_duration.png')
#
## Check log scale
#plt.figure(4)
#plt.plot(log_duration, log_runtime_feature_extraction, 'o-', label='Feature Extraction')
#plt.plot(log_duration, log_runtime_similarity_search, 'o-', label='Similarity Search')
#plt.plot(log_duration, log_runtime_total, 'o-', label='FAST Total Runtime')
#plt.plot(log_ac_duration, log_ac_runtime_total, 'o-', label='Autocorrelation Runtime')
#plt.legend(loc=2, fontsize=16)
#plt.xlim([-0.0969, 2.477])
#plt.ylim([2, 10])
#plt.xlabel('log(Continuous data duration (days))')
#plt.ylabel('log(Runtime (s))')
#plt.title('Runtime vs. Continuous data duration')
#plt.savefig(out_dir+'logset_WHAR_HHE_runtime_vs_data_duration.png')
#
# Plot memory usage on linear scale
plt.figure(5)
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_fingerprint, 'o-', label='Binary Fingerprint')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_database, 'o-', label='Database')
plt.plot(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Memory usage (GB)')
plt.title('Memory usage vs. Continuous data duration')
plt.savefig(out_dir+'WHAR_HHE_memory_vs_data_duration.png')

# Plot memory usage on log scale
plt.figure(6)
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_fingerprint, 'o-', label='Binary Fingerprint')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_database, 'o-', label='Database')
plt.loglog(whar_hhe_nfuncs8.duration, whar_hhe_nfuncs8.memory_similaritysearch, 'o-', label='Similarity Search')
plt.legend(loc=2, fontsize=16)
plt.xlabel('Continuous data duration (days)')
plt.ylabel('Memory usage (GB)')
#plt.xlim([0.8, 300])
plt.title('Memory Scaling with Data Duration')
plt.savefig(out_dir+'loglog_WHAR_HHE_memory_vs_data_duration.png')

