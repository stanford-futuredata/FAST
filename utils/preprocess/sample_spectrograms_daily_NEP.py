from obspy import read
from obspy import UTCDateTime
import glob
import os
import sys
import matplotlib.pyplot as plt

if (len(sys.argv) != 3):
   print "Usage: python sample_spectrograms_daily_NEP.py <network> <station>"
   sys.exit(1)
   
net_str = str(sys.argv[1])
sta_str = str(sys.argv[2])
print "NETWORK: ", net_str, ", STATION: ", sta_str

year = [2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017]
month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

#net_str = "NC"
#net_str = "PG"
#ch_str = "*"
ch_str = "HH*"
#ch_str = "EHZ"
#sta_str = "DCD"

data_folder = '/lfs/1/ceyoon/TimeSeries/NEP/waveforms'+sta_str+'/'
spec_folder = data_folder+'daily_sample_spectrograms/'
if not os.path.exists(spec_folder):
   os.makedirs(spec_folder)

iday = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28]
for iy in range(len(year)):
   for im in range(len(month)):
      start_year = year[iy]
      start_month = month[im]
      if (month[im] == 12):
	 end_year = year[iy] + 1
	 end_month = 1
      else:
	 end_year = year[iy]
	 end_month = month[im+1]
      print start_year, start_month, end_year, end_month

      for ii in range(len(iday)):

	 input_files = glob.glob(data_folder+net_str+'.'+sta_str+'*'+str(start_year)+str(start_month).zfill(2)+str(iday[ii]).zfill(2)
	       +'T000000Z__'+str(end_year)+str(start_month).zfill(2)+'*')
	 if (input_files):
	    print input_files
	    for ifile in input_files:
	       st = read(ifile)
	       print st

	       st1 = st.slice(starttime=UTCDateTime(start_year, start_month, iday[ii], 0, 0, 0), endtime=UTCDateTime(start_year, start_month, iday[ii], 1, 0, 0))
	       print st1
	       if (len(st1) == 1):
#	       st1.spectrogram(outfile=spec_folder+'spec_'+sta_str+'_'+st1[0].stats.channel+'_'+str(start_year)+str(start_month).zfill(2)+str(iday[ii]).zfill(2)+'_hr00.png')
		  fig = st1[0].spectrogram(show=False)
		  ax = fig.axes[0]
		  mappable = ax.images[0]
		  plt.colorbar(mappable=mappable, ax=ax)
		  plt.savefig(spec_folder+'spec_'+sta_str+'_'+st1[0].stats.channel+'_'+str(start_year)+str(start_month).zfill(2)+str(iday[ii]).zfill(2)+'_hr00.png')
		  plt.close(fig)

	       st2 = st.slice(starttime=UTCDateTime(start_year, start_month, iday[ii], 12, 0, 0), endtime=UTCDateTime(start_year, start_month, iday[ii], 13, 0, 0))
	       print st2
	       if (len(st2) == 1):
#	       st2.spectrogram(outfile=spec_folder+'spec_'+sta_str+'_'+st2[0].stats.channel+'_'+str(start_year)+str(start_month).zfill(2)+str(iday[ii]).zfill(2)+'_hr12.png')
		  fig = st2[0].spectrogram(show=False)
		  ax = fig.axes[0]
		  mappable = ax.images[0]
		  plt.colorbar(mappable=mappable, ax=ax)
		  plt.savefig(spec_folder+'spec_'+sta_str+'_'+st2[0].stats.channel+'_'+str(start_year)+str(start_month).zfill(2)+str(iday[ii]).zfill(2)+'_hr12.png')
		  plt.close(fig)


