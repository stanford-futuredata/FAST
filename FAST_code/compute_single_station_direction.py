from obspy import read
import math
import numpy as np
from matplotlib import rcParams
import matplotlib.pyplot as plt

# Detection file locations
#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
#input_time_file = 'example_location_time.txt' # times (s) of detected earthquakes in chronological order - new from FAST
#input_time_file = 'longer_example_location_time.txt' # times (s) of detected earthquakes in chronological order - new from FAST
#start_times = np.loadtxt(input_dir+input_time_file, unpack=True)
start_times = [250764.48, 504365.96, 3101083, 3926294.22, 4341748.2, 5101461.07, 5734578.36, 6032303.95, 7667516.53]
p_index = np.array([48, 42, 8, 75, 54, 60, 58, 54, 65])-1 # P wave arrival index picked manually in MATLAB, start time = first sample
s_index = np.array([222, 205, 76, 183, 194, 138, 147, 137, 183])-1 # S wave arrival index picked manually in MATLAB, start time = first sample

# Waveform file locations
sac_dir = '/data/beroza/ceyoon/multiple_components/data/GuyArkansas/'
file_sac_HHE = '20100601_20100831_HHE_CustBP_1_30_bp1to20.SAC'
file_sac_HHN = '20100601_20100831_HHN_CustBP_1_30_bp1to20.SAC'
file_sac_HHZ = '20100601_20100831_HHZ_CustBP_1_30_bp1to20.SAC'
channel_names = ['HHE', 'HHN', 'HHZ']
allch = read(sac_dir+file_sac_HHE)
allch += read(sac_dir+file_sac_HHN)
allch += read(sac_dir+file_sac_HHZ)

# Waveform image dimensions
nch = len(allch) # number of component
nevent = len(start_times) # number of events in detection file
window_length = 8 # waveform window length (s)
nsamples = int(window_length * allch[0].stats.sampling_rate) + 1 # number of samples in waveform window
time_val = np.arange(0,0+nsamples)*allch[0].stats.delta # time value array (s)
time_val = np.reshape(time_val, (len(time_val), 1))
image_waveform = np.zeros((nsamples, nevent, nch))
rcParams.update({'font.size': 18})

# Loop over detection times
for it,start_time in enumerate(start_times):
   print "start_time = ", start_time
   for k in range(0,nch):
      startindex = int(start_time * allch[0].stats.sampling_rate) # start index
      data_time = allch[k].data[startindex:startindex+nsamples] # time series waveform amplitude
      image_waveform[:,it,k] = data_time
  
   # Window for P-wave arrival (plot HHE, HHN, HHZ components)
   ind1 = max(p_index[it] - 20, 0)
   ind2 = ind1 + 40
   print ind1, ind2
   tval = time_val[ind1:ind2]
   east_comp = image_waveform[ind1:ind2,it,0]
   north_comp = image_waveform[ind1:ind2,it,1]
   z_comp = image_waveform[ind1:ind2,it,2]

   sptime = (s_index[it]-p_index[it])*allch[0].stats.delta
   vp = 4.73 # p-wave velocity (only an estimate from model, from most reasonable depths, km/s)
   dist = sptime*vp/(math.sqrt(3.0)-1.0)
   print "S-P time = ", sptime, "s"
   print "max distance = ", dist, "km"

   plt.figure(0)
   plt.plot(time_val[ind1:ind2], east_comp, color='r', label='HHE')
   plt.plot(time_val[ind1:ind2], north_comp, color='b', label='HHN')
   plt.plot(time_val[ind1:ind2], z_comp, color='k', label='HHZ')
   plt.legend(loc=2)
   #plt.legend(loc='upper right')
   plt.xlabel('Time from start time (s)')
   plt.ylabel('Amplitude')
   plt.title('Event, start time (s) = '+str(start_time))
   #plt.show()
   #plt.savefig('waveform10s_'+str(start_time)+'.png')
   #plt.savefig('pwave_'+str(start_time)+'.png')
   plt.savefig('pwave_'+str(start_time)+'.eps')
   plt.clf()

   # Window to select P-wave particle motion, polarization analysis
   # Use first 20 samples (0.2 s)
   ind1 = p_index[it]
   ind2 = ind1 + 20
   ###ind2 = ind1 + 10
   print ind1, ind2
   e_comp = image_waveform[ind1:ind2,it,0]
   n_comp = image_waveform[ind1:ind2,it,1]
   dir_arr = np.transpose(np.vstack((e_comp, n_comp)))
   max_amp = np.amax(dir_arr)
   np.shape(dir_arr)

   # Use SVD to solve for best-fit polarization direction
   u, s, v = np.linalg.svd(dir_arr)
   dir_vec = v[0,:] # direction of polarization determined by vector for largest singular value
   print "v = ", v
   print "singular values = ", s
   print "direction = ", np.degrees(np.arctan2(dir_vec[1], dir_vec[0])), "deg"

   plt.figure(1)
   plt.plot(e_comp, n_comp)
   plt.axis('equal')
   plt.axes().set_aspect(1.0)
   plt.xlim([-max_amp, max_amp])
   plt.ylim([-max_amp, max_amp])
   plt.xlabel('East amplitude')
   plt.ylabel('North amplitude')
   plt.title('Event polarization, start time (s) = '+str(start_time))
   #plt.show()
   #plt.savefig('particlemotion_'+str(start_time)+'.png')
   plt.savefig('particlemotion_'+str(start_time)+'.eps')
   #plt.savefig('particlemotion10samples_'+str(start_time)+'.png')
   #plt.clf()
