import glob
import os
import sys
from obspy import read
from obspy import UTCDateTime


if __name__ == '__main__':
   network = sys.argv[1]
   station = sys.argv[2]
   channel = sys.argv[3]
   print network, station, channel



# ------------------- INPUTS ------------------------------------------------
#ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/ORIGINAL_DATA/'
#file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'.*.'+channel))
#out_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/continuous_duration/'
#start_time = UTCDateTime('2008-04-01T00:00:17.800000')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/'+network+'.'+station+'/'
#file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'.'+channel+'*.seed'))
#out_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/continuous_duration/'
#start_time = UTCDateTime('2017-01-01T00:00:06.840000')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/waveforms'+station+'/'
#file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'..'+channel+'__20*'))
#out_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/continuous_duration/'
#start_time = UTCDateTime('2006-09-01T01:57:22.570000')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/'+station+'/'
#file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'..'+channel+'*'))
#out_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/continuous_duration/'
#start_time = UTCDateTime('2015-10-28T00:00:21.340000')

ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveforms'+station+'/'
file_arr = sorted(glob.glob(ts_dir+network+'.'+station+'..'+channel+'*.mseed'))
out_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/continuous_duration/'
start_time = UTCDateTime('2018-01-01T00:00:04.500000')

# ------------------- INPUTS ------------------------------------------------

if not os.path.exists(out_dir):
   os.makedirs(out_dir)

out_file = out_dir+'continuous.'+network+'.'+station+'.'+channel+'.txt'
out_ind_file = out_dir+'indices_continuous.'+network+'.'+station+'.'+channel+'.txt'

print 'Number of files: ', len(file_arr)
fout = open(out_file, 'w')
findex = open(out_ind_file, 'w')
for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print file_str

   file_name = ts_dir+file_str
   st = read(file_name)
   print st.__str__(extended=True)

   for itr in range(len(st)):
      time_start = st[itr].stats.starttime
      time_end = st[itr].stats.endtime
      fout.write('%s %s\n' % (time_start.strftime('%Y-%m-%dT%H:%M:%S.%f'), time_end.strftime('%Y-%m-%dT%H:%M:%S.%f')))
      ind_start = int(time_start-start_time)
      ind_len = int(time_end-time_start)
      findex.write('%d  %d\n' % (ind_start, ind_len))

fout.close()
findex.close()
