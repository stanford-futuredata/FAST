import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tic


# Read in template text files
text_dir = './'
data_hhe = np.loadtxt(text_dir+'waveform_examples_HHE.txt')
data_hhn = np.loadtxt(text_dir+'waveform_examples_HHN.txt')
data_hhz = np.loadtxt(text_dir+'waveform_examples_HHZ.txt')
ntemp = np.shape(data_hhe)[1]-1 # number of waveforms  
print ntemp, 'waveforms'
time_val = data_hhe[:,0] # time values (s)

# All waveforms in one array
data = np.dstack((data_hhe, data_hhn, data_hhz))
data_hhe = []
data_hhn = []
data_hhz = []

# Channel names
channels = ['WHAR.HHE', 'WHAR.HHN', 'WHAR.HHZ']

# Plot template waveforms for all 3 channels
out_dir = './'
nch = 3
for it in range(1,ntemp+1): # loop over waveforms (index 0 = time values)
   plt.figure(num=0, figsize=(7,10))
   for k in range(0,nch): # loop over channels
      plt.subplot(nch,1,k+1)
      plt.plot(time_val, data[:,it,k])
      plt.ylabel('Amplitude')
      plt.title(channels[k])

   plt.xlabel('Time (s)')
   plt.savefig(out_dir+'waveform_num'+str(it).zfill(4)+'.png')
   plt.clf()
