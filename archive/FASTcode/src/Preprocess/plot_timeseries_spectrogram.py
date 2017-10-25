import matplotlib.pyplot as plt
from obspy import read
from scipy.signal import spectrogram
from scipy.signal import get_window

data_dir = '/data/beroza/ceyoon/FASTcode/'

# Input data
#sac_dir = data_dir+'data/TimeSeries/Ometepec/'
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.unfilt' # unfiltered data
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp1to8' # filtered data 1-8 Hz
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp3to30' # filtered data 3-30 Hz
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp3to20' # filtered data 3-20 Hz
#out_dir = data_dir+'figures/Ometepec/'

sac_dir = data_dir+'data/TimeSeries/HectorMine/'
sac_files = 'Deci5.*'
out_dir = data_dir+'figures/HectorMine/'



# Spectrogram parameters (number of samples)
#ns = 600 # Ometepec
#nlag = 10 # Ometepec
ns = 120 # HectorMine
nlag = 10 # HectorMine


# Read in data
allch = read(sac_dir+sac_files)
nch = len(allch)
print nch
dt = allch[0].stats.starttime
fnyq = allch[0].stats.sampling_rate/2.0

#total_time = 15*24*3600. # number of seconds spanned by time series
#time_interval = 24*3600. # number of seconds per output file
total_time = 21*3600. # number of seconds spanned by time series
time_interval = 3*3600. # number of seconds per output file
nint = int(total_time / time_interval)
for ii in range(0,nint):
   start_time = dt + ii*time_interval
   end_time = dt + (ii+1)*time_interval
   st_slice = allch.slice(start_time, end_time)

   start_hr = int(ii*time_interval/3600.)
   end_hr = int((ii+1)*time_interval/3600.)
   
   # ObsPy plot (different scales) of time series
#   st_slice.plot(equal_scale=False, size=(800,400), outfile=out_dir+'timeseries_'+str(start_hr).zfill(3)+'_'+str(end_hr).zfill(3)+'.png')
   st_slice.plot(equal_scale=False, size=(1200,800), outfile=out_dir+'timeseries_'+str(start_hr).zfill(3)+'_'+str(end_hr).zfill(3)+'.png')

   # Time series plot (same scale)
#   f, axarr = plt.subplots(nch, sharex=True, figsize=(16,8))
   f, axarr = plt.subplots(nch, sharex=True, figsize=(12,8))
   for kk in range(nch):
      axarr[kk].plot(st_slice[kk].times(), st_slice[kk].data)
#      axarr[kk].set_ylim(-1e5, 1e5)
      if (allch[kk].stats['station'] == 'HEC'):
         axarr[kk].set_ylim(-2000, 2000)
      else:
         axarr[kk].set_ylim(-200, 200)
      axarr[kk].set_title(st_slice[kk].stats['network']+'.'+st_slice[kk].stats['station']+'.'+st_slice[kk].stats['channel'], y=0.5)
   plt.xlabel("Time (s)")
   plt.savefig(out_dir+'scale_timeseries_'+str(start_hr).zfill(3)+'_'+str(end_hr).zfill(3)+'.png')
   plt.close(plt.gcf())

   # Spectrogram
#   f, axarr = plt.subplots(nch, sharex=True, sharey=True, figsize=(16,8))
   f, axarr = plt.subplots(nch, sharex=True, sharey=True, figsize=(12,8))
   f.text(0.5, 1, 'Spectrograms, '+str(start_hr)+' to '+str(end_hr))
   for kk in range(nch):
      freq, times, spec = spectrogram(st_slice[kk].data, fs=st_slice[kk].stats.sampling_rate, window=get_window('hamming', ns), nperseg=ns, noverlap=ns-nlag, scaling='spectrum') 
      im = axarr[kk].pcolormesh(times,freq,spec, vmin=-10, vmax=20)
      axarr[kk].set_ylim(0, fnyq)
      axarr[kk].set_xlim(0, time_interval)
      axarr[kk].set_title(st_slice[kk].stats['network']+'.'+st_slice[kk].stats['station']+'.'+st_slice[kk].stats['channel'], y=0.5)
   f.text(0.08, 0.6, 'Frequency (Hz)', rotation=90)
   plt.xlabel('Time (s)')
   f.colorbar(im, ax=axarr.ravel().tolist())
   plt.savefig(out_dir+'spectrogram_'+str(start_hr).zfill(3)+'_'+str(end_hr).zfill(3)+'.png')
   plt.close(plt.gcf())

