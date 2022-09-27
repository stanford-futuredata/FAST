import numpy as np
import glob
import os
import sys
from obspy import read


if __name__ == '__main__':
   network = sys.argv[1]
   station = sys.argv[2]
   channel = sys.argv[3]
   min_freq = int(sys.argv[4])
   max_freq = int(sys.argv[5])
   dec_factor = int(sys.argv[6])
   print(network, station, channel)
   print('bandpass:', min_freq, '-', max_freq, 'Hz, decimate factor:', dec_factor)



# ------------------- INPUTS ------------------------------------------------
#ts_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
#file_arr = glob.glob(ts_dir+'*YR.'+station+'..'+channel+'*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/'+station+'/'
#file_arr = glob.glob(ts_dir+'*TZ.'+station+'..'+channel+'*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+'*'+network+'.'+station+'..'+channel+'.D.SAC')
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+'*.'+network+'.'+station+'.'+channel+'.sac')
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/filled/'
#file_arr = glob.glob(ts_dir+'Filled.'+network+'.'+station+'.*.'+channel)
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/'+network+'.'+station+'/'
#file_arr = glob.glob(ts_dir+'*SA.'+station+'.'+channel+'*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+'Filled.*'+network+'.'+station+'.'+channel+'.sac')
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+network+'.'+station+'..'+channel+'__20*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/'+station+'/'
#file_arr = glob.glob(ts_dir+network+'.'+station+'..'+channel+'*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+network+'.'+station+'..'+channel+'*.mseed')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveforms'+station+'/'
#file_arr = glob.glob(ts_dir+network+'.'+station+'..'+channel+'*.mseed')
#format_str = 'MSEED'

ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveforms'+station+'/'
file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'..'+channel+'*.mseed'))
format_str = 'MSEED'
# ------------------- INPUTS ------------------------------------------------

str_prefix = 'Deci'+str(int(dec_factor))+'.bp'+str(int(min_freq))+'to'+str(int(max_freq))+'.'
print(str_prefix)

bad_files = []
print('Number of files: ', len(file_arr))
for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print(file_str)

   # Read file
   file_name = ts_dir+file_str
   st = read(file_name, format=format_str)
   print(st.__str__(extended=True))
   if (len(st) > 1):
      print("Warning: more than one trace in stream")

   # Skip file if there are NaN values
   if np.isnan(st[0].data).any():
      print("WARNING: DATA CONTAINS NaN VALUES, SKIP THIS FILE", st)
      bad_files.append(file_str)
      continue

   # Demean and detrend
   st.detrend(type='demean')
   st.detrend(type='linear')

   # Bandpass filter and decimate
   st.filter('bandpass', freqmin=min_freq, freqmax=max_freq)
   st.decimate(dec_factor)

##   Decimate for NEP only - different sampling rates on same station
#   for itr in range(len(st)):
#      if (int(round(st[itr].stats.sampling_rate)) == 200):
#	 st[itr].decimate(2*dec_factor)
#	 print "sampling rate is 200 Hz, decimate twice"
#      else:
#	 st[itr].decimate(dec_factor)

   # Write filtered data to file
   if (format_str == 'MSEED'):
      for itr in range(len(st)):
         st[itr].data = st[itr].data.astype(np.int32)
         print(st[itr].data)
   st.write(ts_dir+str_prefix+file_str, format=format_str)

print("Number of files not written out due to NaN: ", len(bad_files))
print(bad_files)
