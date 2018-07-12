from obspy import read
from obspy import UTCDateTime
from obspy.clients.fdsn import Client 
from obspy.clients.fdsn.header import FDSNException
import numpy as np
import matplotlib.pyplot as plt
import os
import sys
from obspy import Stream
from matplotlib import rcParams

rcParams['pdf.fonttype'] = 42
print rcParams['pdf.fonttype']

if len(sys.argv) != 3:
   print "Usage: python PARTIALplot_detected_waveforms_Diablo.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST
 

# Inputs
times_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/network_detection/'
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+'sort_nsta_peaksum_11sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt', unpack=True)
out_dir = times_dir+'11sta_2stathresh_WaveformPlots/'
if not os.path.exists(out_dir):
   os.makedirs(out_dir)

# Times
dt_fp = 1.2
det_times = dt_fp * det_start_ind
diff_times = dt_fp * diff_ind
dL_dt = dt_fp * dL
print len(det_times)

# Window length (seconds) for event plot
init_time = UTCDateTime('2006-09-01T01:57:22.570000') # global start time for all channels (global_idx_stats.txt)
wtime_before = 60
wtime_after = 120

# Plot dimensions
out_width = 800
out_height = 1600

# Download data and plot
client = Client('NCEDC')
stations = ['DCD', 'DPD', 'VPD', 'LSD', 'LMD', 'SH', 'SHD', 'EFD', 'EC', 'MLD', 'PABB', 'PPB']
networks = ['PG', 'PG', 'PG', 'PG', 'PG', 'PG', 'PG', 'PG', 'PG', 'PG', 'NC', 'NC']
i_load = 0 # index for waveform data successfully loaded
for kk in range(IND_FIRST, IND_LAST):
   ev_time = init_time + det_times[kk]
   start_time = ev_time - wtime_before
   end_time = ev_time + wtime_after
   if (diff_times[kk] > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

   st = Stream()
   for ista in range(len(stations)):
      try:
	 st += client.get_waveforms(networks[ista], stations[ista], '*','EH*', start_time, end_time)
      except FDSNException: # catch exception if data not available at this time
	 print "load data failed for event " + str(kk) + " time " + str(det_times[kk])+", station ", stations[ista]
	 continue
   print kk, det_times[kk], len(st), " traces"

   st.detrend('demean')
   st.detrend('linear')
   st.filter('bandpass', freqmin=3, freqmax=12)

   i_load += 1
   out_file = out_dir+'event_rank'+format(kk,'05d')+'_nsta'+str(int(num_sta[kk]))+'_peaksum'+str(int(peaksum[kk]))+'_ind'+str(int(det_start_ind[kk]))+'_time'+str(det_times[kk])+'_'+ev_time.strftime('%Y-%m-%dT%H:%M:%S.%f')+'.png'
   st.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)

print "Number of event waveforms loaded =", i_load 
