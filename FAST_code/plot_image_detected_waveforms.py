from obspy import read
import numpy as np
from matplotlib import rcParams
import matplotlib.pyplot as plt

# Detection file locations
input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
input_time_file = 'selected_time.txt' # times (s) of detected earthquakes in chronological order - new from FAST
#input_time_file = 'test_match_time.txt' # times (s) of detected earthquakes in chronological order - match from FAST and template (preliminary)
#input_time_file = 'test_missed_time.txt' # times (s) of detected earthquakes in chronological order - missed by FAST (preliminary)
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
window_length = 4 # waveform window length (s)
nsamples = int(window_length * allch[0].stats.sampling_rate) + 1 # number of samples in waveform window
#time_val = np.arange(startindex,startindex+nsamples)*allch[0].stats.delta # time value array (s)
image_waveform = np.zeros((nevent, nsamples, nch))
rcParams.update({'font.size': 14})

# Loop over channels
for k in range(0,nch):
   # Loop over detection times
   for it,start_time in enumerate(start_times):
      startindex = int(start_time * allch[0].stats.sampling_rate) # start index
      data_time = allch[k].data[startindex:startindex+nsamples] # time series waveform amplitude
      image_waveform[it,:,k] = data_time / np.linalg.norm(data_time)

   # Time on x-axis, detections on y-axis (portrait)
#   plt.figure(num=0, figsize=(7,10))
#   plt.imshow(image_waveform[:,:,k], cmap=plt.cm.seismic, interpolation='none', aspect='auto') # aspect='auto' squeezes large images
#   plt.xticks(np.arange(0, nsamples, nsamples/4), [0, 1, 2, 3, 4])
#   plt.xlabel('Time (s)')
#   plt.ylabel('Number of detections')

   # Detections on x-axis, time on y-axis (landscape)
   plt.figure(num=0, figsize=(10,7))
   plt.imshow(np.transpose(image_waveform[:,:,k]), cmap=plt.cm.seismic, interpolation='none', aspect='auto')
   plt.yticks(np.arange(0, nsamples, nsamples/4), [0, 1, 2, 3, 4])
   plt.ylabel('Time (s)')
   plt.xlabel('Number of detections')

   cbar = plt.colorbar(fraction=0.046, pad=0.04)
   cbar.set_label('Normalized waveform amplitude', rotation=270, labelpad=20)
   plt.clim(-0.4, 0.4)
   
   plt.title('New FAST detections, 2010-07-01 to 2010-07-31, \n WHAR.'+channel_names[k], y=1.0)
   plt.savefig(input_dir+'image_waveform_channel_new_'+channel_names[k]+'.png')
   
#   plt.title('Matching detections, 2010-07-01 to 2010-07-31, \n WHAR.'+channel_names[k], y=1.0)
#   plt.savefig(input_dir+'image_waveform_channel_match_'+channel_names[k]+'.png')
   
#   plt.title('Missed detections, 2010-07-01 to 2010-07-31, \n WHAR.'+channel_names[k], y=1.0)
#   plt.savefig(input_dir+'image_waveform_channel_missed_'+channel_names[k]+'.png')
   plt.clf()
