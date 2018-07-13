from obspy import read
from obspy import UTCDateTime
import numpy as np
import matplotlib.pyplot as plt
import sys
import os
from matplotlib import rcParams

rcParams['pdf.fonttype'] = 42
print rcParams['pdf.fonttype']


if len(sys.argv) != 3:
   print "Usage: python PARTIALplot_detected_waveforms_Ometepec.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST
   

# Inputs
times_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/network_detection/'
[det_start_ind, dL, ndets, peaksum, vol] = np.loadtxt(times_dir+'sort_peaksum_1sta_1stathresh_PNIG_events.txt', unpack=True)
out_dir = times_dir+'1sta_1stathresh_NetworkWaveformPlots/'
if not os.path.exists(out_dir):
   os.makedirs(out_dir)

# Times   
dt_fp = 2.0
det_times = dt_fp * det_start_ind
dL_dt = dt_fp * dL
print len(det_times)

# Window length (seconds) for event plot
init_time = UTCDateTime('2012-01-01T00:00:15.800000') # global start time for all channels
wtime_before = 10
wtime_after = 50

# Plot dimensions
out_width = 400
out_height = 1000

# Read in data and plot
ts_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/waveformsPNIG/'
for kk in range(IND_FIRST, IND_LAST):
   ev_time = init_time + det_times[kk]
   start_time = ev_time - wtime_before
   end_time = ev_time + wtime_after
   if (dL_dt[kk] > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + dL_dt[kk]
#      end_time = ev_time + dL_dt[kk] + wtime_after

#   jday_start = start_time.julday
#   jday_end = end_time.julday
#   if (jday_start != jday_end):
#      print "Warning: start and end day not equal", kk, jday_start, jday_end

   month_str = str(start_time.year)+str(start_time.month).zfill(2)+'01'

   st = read(ts_dir+'Deci1.*'+month_str+'*.sac', format='SAC')
#   print len(st)
#   print st.__str__(extended=True)

   st_slice = st.slice(start_time, end_time)

   out_file = out_dir+'event_rank'+format(kk,'05d')+'_peaksum'+str(int(peaksum[kk]))+'_ind'+str(int(det_start_ind[kk]))+'_time'+str(det_times[kk])+'_'+ev_time.strftime('%Y-%m-%dT%H:%M:%S.%f')+'.png'
   st_slice.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)
