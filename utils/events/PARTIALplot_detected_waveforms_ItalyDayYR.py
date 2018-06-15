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
   print "Usage: python PARTIALplot_detected_waveforms_ItalyDayYR.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST
   

# Inputs
times_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/'
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+'sort_nsta_peaksum_22sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt', unpack=True)
out_dir = times_dir+'22sta_2stathresh_NetworkWaveformPlots/'
if not os.path.exists(out_dir):
   os.makedirs(out_dir)

dt_fp = 1.2
det_times = dt_fp * det_start_ind
diff_times = dt_fp * diff_ind
dL_dt = dt_fp * dL
print len(det_times)

sac_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
st = read(sac_dir+'Deci4.bp2to20.YR*HHZ*')
print len(st)
print st.__str__(extended=True)

# Window length (seconds) for event plot
init_time = UTCDateTime('2016-10-29T00:00:06.840000') # global start time for all channels
wtime_before = 10
wtime_after = 50

# Plot dimensions
out_width = 800
out_height = 2000

for kk in range(IND_FIRST, IND_LAST):
   ev_time = init_time + det_times[kk]
   start_time = ev_time - wtime_before
   end_time = ev_time + wtime_after
   if (diff_times[kk] > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

   st_slice = st.slice(start_time, end_time)

   out_file = out_dir+'event_rank'+format(kk,'05d')+'_nsta'+str(int(num_sta[kk]))+'_peaksum'+str(int(peaksum[kk]))+'_ind'+str(int(det_start_ind[kk]))+'_time'+str(det_times[kk])+'_'+ev_time.strftime('%Y-%m-%dT%H:%M:%S.%f')+'.png'
   st_slice.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)
