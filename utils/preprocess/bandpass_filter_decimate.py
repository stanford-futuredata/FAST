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
   print network, station, channel
   print 'bandpass:', min_freq, '-', max_freq, 'Hz, decimate factor:', dec_factor



# ------------------- INPUTS ------------------------------------------------
#ts_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
#file_arr = glob.glob(ts_dir+'*YR.'+station+'..'+channel+'*')
#format_str = 'MSEED'

ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/'+station+'/'
file_arr = glob.glob(ts_dir+'*TZ.'+station+'..'+channel+'*')
format_str = 'MSEED'

#ts_dir = '/lfs/raiders2/0/ceyoon/TimeSeries/Wenchuan/after/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/' # after only
#ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/filled/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/filled/'

#file_arr = glob.glob(ts_dir+'Filled.CombinedAfter*')
#file_arr = glob.glob(ts_dir+'Filled.*')
#file_arr = glob.glob(ts_dir+'Filled.*'+network+'.'+station+'..'+channel+'.D.SAC')
#file_arr = glob.glob(ts_dir+'Filled.*'+network+'.'+station+'.'+channel+'.sac')

# Ometepec
#min_freq = 3
#max_freq = 20
#dec_factor = 1
# ------------------- INPUTS ------------------------------------------------

str_prefix = 'Deci'+str(int(dec_factor))+'.bp'+str(int(min_freq))+'to'+str(int(max_freq))+'.'
print str_prefix

bad_files = []
print 'Number of files: ', len(file_arr)
for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print file_str

   # Read file
   file_name = ts_dir+file_str
   st = read(file_name, format=format_str)
   print st.__str__(extended=True)
   if (len(st) > 1):
      print "Warning: more than one trace in stream"

   # Skip file if there are NaN values
   if np.isnan(st[0].data).any():
      print "WARNING: DATA CONTAINS NaN VALUES, SKIP THIS FILE", st
      bad_files.append(file_str)
      continue

   # Demean and detrend
   st.detrend(type='demean')
   st.detrend(type='linear')

   # Bandpass filter and decimate
   st.filter('bandpass', freqmin=min_freq, freqmax=max_freq)
   st.decimate(dec_factor)

   # Write filtered data to file
   if (format_str == 'MSEED'):
      for itr in range(len(st)):
	 st[itr].data = st[itr].data.astype(np.int32)
      print st[itr].data
   st.write(ts_dir+str_prefix+file_str, format=format_str)

print "Number of files not written out due to NaN: ", len(bad_files)
print bad_files
