import matplotlib.pyplot as plt
from matplotlib import rcParams
import numpy as np

class FastTime:
   def __init__(self):
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

# One time per component
# Nfuncs=8, all runtimes in s
runtime_3month = FastTime()
runtime_3month.spectrogram = np.array([3878.0631, 35791.1359, 3843.7403]) # why did spectrogram for HHN take so long? cees-tool-5 low on memory?
#runtime_3month.spectrogram = np.array([3878.0631, 3891.1359, 3843.7403])
runtime_3month.specImageWavelet = np.array([40484.9395, 40844.0459, 40509.2303]) 
runtime_3month.binaryFingerprint = np.array([8687.0575+5566.0073+6387.466, 8695.6862+5713.6159+4641.0683, 8689.7886+4059.0123+5000.3215])
runtime_3month.minhash = np.array([42227.39, 54160.5, 41063.92])
runtime_3month.database = np.array([1547.67, 1894.47, 1788.02])
runtime_3month.similaritysearch = np.array([352508.12, 306434.54, 303584.67])
runtime_3month.memory_fingerprint = np.array([110, 112, 110]) # memory in GB
runtime_3month.memory_database = np.array([66, 74.1, 70]) # memory in GB
runtime_3month.memory_similaritysearch = np.array([226, 276, 236])
runtime_feature_extraction = runtime_3month.get_feature_extraction_runtime()
runtime_similarity_search = runtime_3month.get_similarity_search_runtime()
runtime_total = runtime_feature_extraction + runtime_similarity_search
runtime_postprocess = np.array([1163.6403, 111.0184, 2292.42, 957.14, 42810.1732, 19.8153]) # postprocess runtime (total similarity matrix, remove duplicates)
complete_runtime = sum(runtime_total) + sum(runtime_postprocess)
print "complete runtime totalMatrix_WHAR_20100601_3ch_3month = ", complete_runtime
