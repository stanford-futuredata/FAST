from obspy import read
from obspy import UTCDateTime
import glob
import os
import sys
import matplotlib.pyplot as plt

# Function to plot a single spectrogram
def single_spectrogram_plot(spec_folder, in_st, str_sta, str_ch, in_year, in_month, in_day, in_hour):
   try:
      st1 = in_st.slice(starttime=UTCDateTime(in_year, in_month, in_day, in_hour, 0, 0), endtime=UTCDateTime(in_year, in_month, in_day, in_hour+1, 0, 0))
      if (len(st1) > 0):
	 fig = st1[0].spectrogram(show=False)
	 ax = fig.axes[0]
	 mappable = ax.images[0]
	 plt.colorbar(mappable=mappable, ax=ax)
	 plt.savefig(spec_folder+'spec_'+str_sta+'_'+str_ch+'_'+str(in_year)+str(in_month).zfill(2)+str(in_day).zfill(2)+'_hr'+str(in_hour).zfill(2)+'.png')
	 plt.close(fig)
   except ValueError:
      print "Cannot slice hour-spectrogram data for: ", str_sta, str_ch, ", starting: ", UTCDateTime(in_year, in_month, in_day, in_hour, 0, 0)
   return



# ---------- Start execution -------------
if (len(sys.argv) != 4):
   print "Usage: python plot_sample_spectrograms.py <network> <station> <channel>"
   sys.exit(1)
   
network = str(sys.argv[1])
station = str(sys.argv[2])
channel = str(sys.argv[3])
print "Running plot_sample_spectrograms.py"
print "NETWORK: ", network, ", STATION: ", station, ", CHANNEL: ", channel


# ------------------- INPUTS ------------------------------------------------
#data_folder = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
#input_files = sorted(glob.glob(data_folder+network+'.'+station+'..'+channel+'*.303'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/'+station+'/'
#input_files = sorted(glob.glob(data_folder+'TZ.'+station+'..'+channel+'*'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/waveforms'+station+'/'
#input_files = sorted(glob.glob(data_folder+'2014*'+network+'.'+station+'..'+channel+'.D.SAC'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/OBSTest/waveforms'+station+'/'
#input_files = sorted(glob.glob(data_folder+'2011*.'+network+'.'+station+'.'+channel+'.sac'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/filled/'
#input_files = sorted(glob.glob(data_folder+'Filled.'+network+'.'+station+'.*.'+channel))

#data_folder = '/lfs/1/ceyoon/TimeSeries/SaudiFull/'+network+'.'+station+'/'
#input_files = sorted(glob.glob(data_folder+'SA.'+station+'.'+channel+'*.seed'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/Ometepec/waveforms'+station+'/'
#input_files = sorted(glob.glob(data_folder+'Filled.*'+network+'.'+station+'.'+channel+'.sac'))

data_folder = '/lfs/1/ceyoon/TimeSeries/Diablo/waveforms'+station+'/'
input_files = sorted(glob.glob(data_folder+network+'.'+station+'..'+channel+'__20*'))

#data_folder = '/lfs/1/ceyoon/TimeSeries/NEP/waveforms'+sta_str+'/'
# ------------------- INPUTS ------------------------------------------------


# Output directory
spec_folder = data_folder+'sample_spectrograms/'
if not os.path.exists(spec_folder):
   os.makedirs(spec_folder)

# If time series file is longer than 1 day, then sample it every other day
dur_thresh = 86800.0 # Slightly longer duration than 86400 s (1 day)
#iday = [8, 16, 24] # Diablo data set only
iday = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28]

# Plot spectrogram(s) for each time series file
print "Number of input files: ", len(input_files)
if (input_files):
   for ifile in input_files:
      st = read(ifile)
      print st
      start_time = st[0].stats.starttime
      file_dur = st[0].stats.endtime - start_time
      if (file_dur > dur_thresh): # longer than 1 day (usually 1 month)
	 for ii in iday:
	    single_spectrogram_plot(spec_folder, st, station, channel, start_time.year, start_time.month, ii, 1)  # Start at hour 1
	    single_spectrogram_plot(spec_folder, st, station, channel, start_time.year, start_time.month, ii, 13) # Start at hour 13
      else: # 1 day long
	 single_spectrogram_plot(spec_folder, st, station, channel, start_time.year, start_time.month, start_time.day, 1)  # Start at hour 1
	 single_spectrogram_plot(spec_folder, st, station, channel, start_time.year, start_time.month, start_time.day, 13) # Start at hour 13
print "*******************************************************"
