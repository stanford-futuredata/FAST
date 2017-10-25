import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tic


# Read in template text files
text_dir = '../../../data/TimeSeries/WHAR/'
data_hhe = np.loadtxt(text_dir+'2010_6month_temp_HHE_1_20Hz.txt')
data_hhn = np.loadtxt(text_dir+'2010_6month_temp_HHN_1_20Hz.txt')
data_hhz = np.loadtxt(text_dir+'2010_6month_temp_HHZ_1_20Hz.txt')
ntemp = np.shape(data_hhe)[1]-1 # number of templates  
print ntemp, 'templates'
time_val = data_hhe[:,0] # time values (s)

# All templates in one array
data = np.dstack((data_hhe, data_hhn, data_hhz))
data_hhe = []
data_hhn = []
data_hhz = []

# Channel names
channels = ['WHAR.HHE', 'WHAR.HHN', 'WHAR.HHZ']

# Plot template waveforms for all 3 channels
out_dir = '../../../figures/WHAR/TemplateWaveforms/'
nch = 3
for it in range(1,ntemp+1): # loop over templates (index 0 = time values)
   plt.figure(num=0, figsize=(6,10))
   for k in range(0,nch): # loop over channels
      plt.subplot(nch,1,k+1)
      plt.plot(time_val, data[:,it,k])
      plt.ylabel('Amplitude')
      plt.title(channels[k])

   plt.xlabel('Time (s)')
   plt.savefig(out_dir+'template_waveform_num'+str(it).zfill(4)+'.png')
   plt.clf()
