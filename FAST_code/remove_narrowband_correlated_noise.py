from obspy import read
import matplotlib.pyplot as plt
import matplotlib.ticker as tic
import numpy as np

# Define function to separate earthquakes from narrowband correlated noise
def separate_corr_noise_from_eq(start_times, start_sim, window_length, allch, out_eq_file, out_noise_file):
   noise_times = []
   eq_times = []
   noise_sim = []
   eq_sim = []

   # Loop over start times for event windows
   for it,start_time in enumerate(start_times):  
      print '------------ start_time = ', start_time
      startindex = int(start_time * allch[0].stats.sampling_rate) # start index
      nsamples = int(window_length * allch[0].stats.sampling_rate) # number of samples in window
      time_val = np.arange(startindex,startindex+nsamples)*allch[0].stats.delta # time value array (s)
      dfreq = 1.0/(allch[0].stats.sampling_rate) # frequency spacing (Hz)
      freq = np.fft.rfftfreq(nsamples, dfreq) # frequency value array (Hz)

      flag_plot_time_window = False
      flag_plot_spec = False 

      data_times = np.zeros((nsamples,len(allch)))
      data_specs = np.zeros((len(freq),len(allch)))
      max_inds = np.zeros(len(allch))
      pct_max_freqs = np.zeros(len(allch))
      power_thresh = 0.56 # Threshold for % power within narrow band of power spectrum (above: noise)

      # Loop over channels
      for k in range(0,len(allch)):
	 data_time = allch[k].data[startindex:startindex+nsamples] # time series waveform amplitude
	 data_spec = np.abs(np.fft.rfft(data_time))**2 # power spectrum of event

	 data_times[:,k] = data_time
	 data_specs[:,k] = data_spec

	 max_ind = np.argmax(data_spec) # frequency index with maximum power spectrum
	 radius_ind = 3 # number of frequency indices before and after maximum for % power calculation
	 low_max_ind = max(0, max_ind-radius_ind)
	 high_max_ind = min(len(data_spec), max_ind+radius_ind+1)
	 pct_max_freq = sum(data_spec[low_max_ind:high_max_ind])/sum(data_spec) # % power within radius_ind of maximum
	 max_inds[k] = max_ind
	 pct_max_freqs[k] = pct_max_freq
         #print '% near max freq = ', pct_max_freq
         #print 'max, low, high freq indices = ', max_ind, low_max_ind, high_max_ind
     
      # Check if event is earthquake or noise
      is_high_pct_freq = (pct_max_freqs[0] > power_thresh) or (pct_max_freqs[1] > power_thresh) or (pct_max_freqs[2] > power_thresh)
      is_noise = is_high_pct_freq
      if (is_noise):
	 noise_times.append(start_time)
	 noise_sim.append(start_sim[it])
	 print 'noise'
      else:
	 eq_times.append(start_time)
	 eq_sim.append(start_sim[it])

      # Plot time window
      if (flag_plot_time_window):
	 plt.figure(num=0, figsize=(6,10))
	 x_formatter = tic.ScalarFormatter(useOffset=False)
	 for k in range(0,len(allch)):
	    plt.subplot(len(allch),1,k+1)
	    plt.plot(time_val, data_times[:,k])

	    ax = plt.gca()
	    plt.setp(ax.get_xticklabels()[::2], visible=False)
	    ax.xaxis.set_major_formatter(x_formatter)
	    plt.draw()
	    plt.ylabel('Amplitude')
	    plt.title(allch[k].stats.station+'.'+allch[k].stats.channel)

	 plt.xlabel('Time (s)')
	 plt.savefig('event_time_window_'+str(start_time)+'.png')
	 plt.clf()
      
      # Plot spectrum
      if (flag_plot_spec):
	 plt.figure(num=1, figsize=(6,10))
	 x_formatter = tic.ScalarFormatter(useOffset=False)
	 for k in range(0,len(allch)):
	    plt.subplot(len(allch),1,k+1)
	    plt.plot(freq, data_specs[:,k])
	    plt.ylabel('Power spectral amplitude')
	    plt.title(allch[k].stats.station+'.'+allch[k].stats.channel)

	 plt.xlabel('Frequency (Hz)')
	 plt.savefig('event_spec_'+str(start_time)+'.png')
	 plt.clf()

   flag_output_noise_file = True
   flag_output_eq_file = True

   noise_times = np.asarray(noise_times)
   noise_sim = np.asarray(noise_sim)
   if (flag_output_noise_file):
      np.savetxt(out_noise_file, np.c_[noise_times, noise_sim], fmt=['%7.5f','%6.5f'])
   print 'len(noise_times) = ', len(noise_times)

   eq_times = np.asarray(eq_times)
   eq_sim = np.asarray(eq_sim)
   if (flag_output_eq_file):
      np.savetxt(out_eq_file, np.c_[eq_times, eq_sim], fmt=['%7.5f','%6.5f'])
   print 'len(eq_times) = ', len(eq_times)

   return eq_times, eq_sim, noise_times, noise_sim




# sac_dir = '/data/beroza/ceyoon/multiple_components/data/GuyArkansas/'
# allch = read(sac_dir+'201007_HHE_BP_1_30_bp1to20.SAC')
# allch += read(sac_dir+'201007_HHN_BP_1_30_bp1to20.SAC')
# allch += read(sac_dir+'201007_HHZ_BP_1_30_bp1to20.SAC')
# #allch = read(sac_dir+'201007_HHE_BP_1_7_bp1to20.SAC')
# #allch += read(sac_dir+'201007_HHN_BP_1_7_bp1to20.SAC')
# #allch += read(sac_dir+'201007_HHZ_BP_1_7_bp1to20.SAC')
# 
# new_detection_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
# #new_detection_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1wk/'
# new_detection_file = new_detection_dir+'all_new_detections_thresh0.32_timewin4.txt'
# 
# out_eq_file = new_detection_dir+'new_earthquake_detections_thresh0.32_timewin4.txt'
# out_noise_file = new_detection_dir+'new_noise_detections_thresh0.32_timewin4.txt'
# 
# window_length = 4 # window length (s)
# 
# #start_times = [471.0, 496.2, 521.7, 82581.6, 188748.0, 188949.9, 338941.8, 437333.4, 437344.5, 604707.9] # low frequency correlated noise  
# #start_times = [48387, 49415.4, 50417.1, 54270.9, 130195.2, 134119.2, 492625.2, 554351.7, 567674.4, 570753.9, 592994.7, 593011.8] # high frequency correlated noise
# #start_times = [413849.1, 427197.9, 486013.8, 488970.0, 503023.2, 510984.6, 525362.7, 563862, 565854.6, 582548.7] # earthquake
# #start_times = [427179.9, 492771, 572470.2] # regular noise
# #start_times = [1085506.8, 1606151.4, 1606491.3, 1989441.3, 2023062.3, 2041113.3, 2041238.1, 2041497.6, 2074578.6, 2075385, 2076513.9, 2076586.5, 2078212.5, 2078828.1, 2091452.4, 2100976.2, 2125080, 2239341.6, 2267951.7, 2318210.7] 
# #start_sim = [1]*len(start_times) # dummy similarities
# 
# [start_times, start_sim] = np.loadtxt(new_detection_file, unpack=True)
# print 'len(start_times) = ', len(start_times)
# 
# [eq_times, eq_sim, noise_times, noise_sim] = separate_corr_noise_from_eq(start_times, start_sim, window_length, allch, out_eq_file, out_noise_file)
# 
# #sac_dir = '/data/beroza/ceyoon/multiple_components/data/ncsn/'
# #allch = read(sac_dir+'2011.008.00.00.00.deci5.24hr.NC.CML.EHZ.D.SAC.bp2to6')   
# #window_length = 10
# #start_time = 25825
