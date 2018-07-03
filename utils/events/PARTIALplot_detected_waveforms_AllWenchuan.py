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
   print "Usage: python PARTIALplot_detected_waveforms_AllWenchuan.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST
   

# Inputs
#times_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/network_detection/'
#[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+'sort_nsta_peaksum_15sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt', unpack=True)
#out_dir = times_dir+'15sta_2stathresh_NetworkWaveformPlots/'
#if not os.path.exists(out_dir):
#   os.makedirs(out_dir)
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/'
#init_time = UTCDateTime('2008-07-01T00:00:17.800000') # global start time for all channels
#dt_fp = 2.0

times_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/'
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind, frac_ch] = np.loadtxt(times_dir+'sort_nsta_peaksum_15sta_2stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt', usecols=(0,1,2,3,4,5,6,7,8,9,10,11,12), unpack=True)
out_dir = times_dir+'15sta_2stathresh_NetworkWaveformPlots/'
if not os.path.exists(out_dir):
   os.makedirs(out_dir)
ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/'

# Times   
dt_fp = 2.0
det_times = dt_fp * det_start_ind
diff_times = dt_fp * diff_ind
dL_dt = dt_fp * dL
print len(det_times)

# Window length (seconds) for event plot
init_time = UTCDateTime('2008-04-01T00:00:17.800000') # global start time for all channels
wtime_before = 0
wtime_after = 120

# Plot dimensions
out_width = 800
out_height = 1600

# Read in data and plot
# Use filtered data for plotting
for kk in range(IND_FIRST, IND_LAST):
   ev_time = init_time + det_times[kk]
   start_time = ev_time - wtime_before
   end_time = ev_time + wtime_after
   if (diff_times[kk] > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

   jday_start = start_time.julday
   jday_end = end_time.julday
   if (jday_start != jday_end):
      print "Warning: start and end day not equal", kk, jday_start, jday_end

   st = read(ts_dir+'Deci2.*2008'+str(jday_start).zfill(3)+'*.BH*', format='SAC')
#   print len(st)
#   print st.__str__(extended=True)

   st_slice = st.slice(start_time, end_time)

   out_file = out_dir+'event_rank'+format(kk,'05d')+'_nsta'+str(int(num_sta[kk]))+'_fracch'+str(float(frac_ch[kk]))+'_peaksum'+str(int(peaksum[kk]))+'_ind'+str(int(det_start_ind[kk]))+'_time'+str(det_times[kk])+'_'+ev_time.strftime('%Y-%m-%dT%H:%M:%S.%f')+'.png'
   st_slice.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)
