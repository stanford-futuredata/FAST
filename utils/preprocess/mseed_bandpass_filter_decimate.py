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
#mseed_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/waveforms'+station+'/'
#mseed_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
mseed_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/'+station+'/'

#file_arr = glob.glob(mseed_dir+network+'.'+station+'..'+channel+'__20*')
#file_arr = glob.glob(mseed_dir+'YR.'+station+'..'+channel+'*')
file_arr = glob.glob(mseed_dir+'*TZ.'+station+'..'+channel+'*')
print 'Number of files: ', len(file_arr)

for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print file_str

   file_name = mseed_dir+file_str
   st = read(file_name)
   print st.__str__(extended=True)

   st.detrend(type='demean')
   st.detrend(type='linear')

   st.filter('bandpass', freqmin=min_freq, freqmax=max_freq)
   st.decimate(dec_factor)

   for itr in range(len(st)):
      st[itr].data = st[itr].data.astype(np.int32)
   print st[itr].data
   st.write(mseed_dir+'Deci'+str(dec_factor)+'.bp'+str(min_freq)+'to'+str(max_freq)+'.'+file_str, format='MSEED')

#   for itr in range(len(st)):
#      st[itr].data = st[itr].data.astype(np.float32)
#   print st[itr].data
#   st.write(mseed_dir+'Deci'+str(dec_factor)+'.bp'+str(min_freq)+'to'+str(max_freq)+'.'+file_str, format='MSEED', encoding=4) # encode as float32
