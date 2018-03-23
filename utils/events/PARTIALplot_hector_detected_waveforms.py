from obspy import read
from obspy import UTCDateTime
import numpy as np
import matplotlib.pyplot as plt
import sys
import os


if len(sys.argv) != 3:
   print "Usage: python PARTIALplot_detected_hector_waveforms.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST
   

times_dir = '../../data/network_detection/'
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+'sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt', unpack=True)
out_dir = times_dir+'7sta_2stathresh_NetworkWaveformPlots/'
#[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta] = np.loadtxt(times_dir+'FINAL_7sta_Hector_events.txt', unpack=True)
#out_dir = times_dir+'Earthquakes_7sta_2stathresh_NetworkWaveformPlots/'
if not os.path.exists(out_dir):
   os.makedirs(out_dir)

dt_fp = 1.0
det_times = dt_fp * det_start_ind
det_end_times = dt_fp * det_end_ind
diff_times = dt_fp * diff_ind
print len(det_times)

# Use filtered data for plotting
sac_dir = '../../data/'
st = read(sac_dir+'waveforms*/Deci5.Pick.*', format='SAC')
print len(st)
print st.__str__(extended=True)

init_time = UTCDateTime('1999-10-15T13:00:00.676000') # global start time for all channels
#wtime_before = 30
#wtime_after = 60
wtime_before = 10
wtime_after = 40

out_width = 400
out_height = 800

for kk in range(IND_FIRST, IND_LAST):
   ev_time = init_time + det_times[kk]
   start_time = ev_time - wtime_before
   end_time = ev_time + wtime_after
   if (diff_times[kk] > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

   st_slice = st.slice(start_time, end_time)

   out_file = out_dir+'event_rank'+format(kk,'04d')+'_nsta'+str(int(num_sta[kk]))+'_peaksum'+str(int(peaksum[kk]))+'_ind'+str(int(det_start_ind[kk]))+'_time'+str(det_times[kk])+'_'+str(det_end_times[kk])+'_'+ev_time.strftime('%Y-%m-%dT%H:%M:%S.%f')+'.png'
   st_slice.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)
