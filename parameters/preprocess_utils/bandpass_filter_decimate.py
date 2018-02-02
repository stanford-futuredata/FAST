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
#sac_dir = '/lfs/raiders2/0/ceyoon/TimeSeries/Wenchuan/after/'
#sac_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/' # after only
#sac_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/'
#sac_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/'
sac_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/filled/'
#sac_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/filled/'

#file_arr = glob.glob(sac_dir+'Filled.CombinedAfter*')
#file_arr = glob.glob(sac_dir+'Filled.*')
file_arr = glob.glob(sac_dir+'Filled.*'+network+'.'+station+'..'+channel+'.D.SAC')
#file_arr = glob.glob(sac_dir+'Filled.*'+network+'.'+station+'.'+channel+'.sac')
print 'Number of files: ', len(file_arr)

# Ometepec
#min_freq = 3
#max_freq = 20
#dec_factor = 1

str_prefix = 'Deci'+str(int(dec_factor))+'.bp'+str(int(min_freq))+'to'+str(int(max_freq))+'.'
print str_prefix

bad_files = []
for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print file_str

   file_name = sac_dir+file_str
   st = read(file_name, format='SAC')
   if (len(st) > 1):
      print "Warning: more than one trace in stream"

   if np.isnan(st[0].data).any():
      print "WARNING: DATA CONTAINS NaN VALUES, SKIP THIS FILE", st
      bad_files.append(file_str)
      continue

   st.detrend(type='demean')
   st.detrend(type='linear')

   st.filter('bandpass', freqmin=min_freq, freqmax=max_freq)
   st.decimate(dec_factor)

   st.write(sac_dir+str_prefix+file_str, format='SAC')

print "Number of files not written out due to NaN: ", len(bad_files)
print bad_files
