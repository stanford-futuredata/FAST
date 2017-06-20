import matplotlib.pyplot as plt
from obspy import read
from obspy.io.sac.sactrace import SACTrace

# Input data
sac_dir = '../../data/TimeSeries/Ometepec/'
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.unfilt' # unfiltered data
#sac_ext = '' # unfiltered data
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp1to8' # filtered data 1-8 Hz
#sac_ext = '.bp1to8'
#sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp3to30' # filtered data 3-30 Hz
#sac_ext = '.bp3to30'
sac_files = 'Fill.15days.201203.PNIG.HH*.sac.bp3to20' # filtered data 3-20 Hz
sac_ext = '.bp3to20'

#out_str = '2to3day.'
#stime = 2*24*3600 # start time (s) of sliced data
#etime = 3*24*3600 # end time (s) of sliced data

out_str = '8to9day.'
stime = 8*24*3600 # start time (s) of sliced data
etime = 9*24*3600 # end time (s) of sliced data

#out_str = '10to11day.'
#stime = 10*24*3600 # start time (s) of sliced data
#etime = 11*24*3600 # end time (s) of sliced data

#out_str = '2day1hr.'
#stime = 2*24*3600 # start time (s) of sliced data
#etime = stime+3600 # end time (s) of sliced data

#out_str = '8day1hr.'
#stime = 8*24*3600 # start time (s) of sliced data
#etime = stime+3600 # end time (s) of sliced data

#out_str = '2day4hr_Part1.'
#stime = 2*24*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '2day4hr_Part2.'
#stime = (2*24 + 1*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '2day4hr_Part3.'
#stime = (2*24 + 2*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '2day4hr_Part4.'
#stime = (2*24 + 3*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '2day4hr_Part5.'
#stime = (2*24 + 4*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '2day4hr_Part6.'
#stime = (2*24 + 5*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part1.'
#stime = 8*24*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part2.'
#stime = (8*24 + 1*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part3.'
#stime = (8*24 + 2*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part4.'
#stime = (8*24 + 3*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part5.'
#stime = (8*24 + 4*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data

#out_str = '8day4hr_Part6.'
#stime = (8*24 + 5*4)*3600 # start time (s) of sliced data
#etime = stime+4*3600 # end time (s) of sliced data
















# Read in data
allch = read(sac_dir+sac_files)
nch = len(allch)
print nch
dt = allch[0].stats.starttime

# Get start and end times of sliced data in UTCDateTime
start_time = dt + stime
end_time = dt + etime
st_slice = allch.slice(start_time, end_time)

# Output sliced data to SAC file
for ic in range(nch):
   tr_slice = st_slice[ic]
   tr_sac = SACTrace.from_obspy_trace(tr_slice)
   tr_sac.reftime = start_time # kztime is now start_time, b should be 0
   tr_out_slice = tr_sac.to_obspy_trace()

   out_file = sac_dir+out_str+'201203.PNIG.'+tr_slice.stats.channel+sac_ext
   tr_out_slice.write(out_file, format='SAC')
