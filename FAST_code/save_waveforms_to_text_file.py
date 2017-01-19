from obspy import read
import numpy as np
from matplotlib import rcParams
import matplotlib.pyplot as plt

# Detection file locations
input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
#input_time_file = 'example_location_time.txt' # times (s) of detected earthquakes in chronological order - new from FAST
input_time_file = 'longer_example_location_time.txt' # times (s) of detected earthquakes in chronological order - new from FAST
start_times = np.loadtxt(input_dir+input_time_file, unpack=True)

# Waveform file locations
sac_dir = '/data/beroza/ceyoon/multiple_components/data/GuyArkansas/'
file_sac_HHE = '201007_HHE_BP_1_30_bp1to20.SAC'
file_sac_HHN = '201007_HHN_BP_1_30_bp1to20.SAC'
file_sac_HHZ = '201007_HHZ_BP_1_30_bp1to20.SAC'
channel_names = ['HHE', 'HHN', 'HHZ']
allch = read(sac_dir+file_sac_HHE)
allch += read(sac_dir+file_sac_HHN)
allch += read(sac_dir+file_sac_HHZ)

# Waveform image dimensions
nch = len(allch) # number of components
nevent = len(start_times) # number of events in detection file
#window_length = 4 # waveform window length (s)
window_length = 6 # waveform window length (s)
nsamples = int(window_length * allch[0].stats.sampling_rate) + 1 # number of samples in waveform window
time_val = np.arange(0,0+nsamples)*allch[0].stats.delta # time value array (s)
time_val = np.reshape(time_val, (len(time_val), 1))
image_waveform = np.zeros((nsamples, nevent, nch))
rcParams.update({'font.size': 14})

# Loop over channels
for k in range(0,nch):
   # Loop over detection times
   for it,start_time in enumerate(start_times):
      startindex = int(start_time * allch[0].stats.sampling_rate) # start index
      data_time = allch[k].data[startindex:startindex+nsamples] # time series waveform amplitude
      image_waveform[:,it,k] = data_time
      output_array = np.hstack((time_val, image_waveform[:,:,k]))

   np.savetxt('waveform_examples_'+channel_names[k]+'.txt', output_array, fmt='%18.14f')
