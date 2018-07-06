from obspy import read
from obspy import UTCDateTime
from obspy.clients.fdsn import Client 
from obspy.clients.fdsn.header import FDSNException
import numpy as np
import matplotlib.pyplot as plt
import os
import sys
from obspy import Stream

if len(sys.argv) != 3:
   print "Usage: python PARTIALcut_sac_files_Diablo.py <start_ind> <end_ind>"
   sys.exit(1)

IND_FIRST = int(sys.argv[1])
IND_LAST = int(sys.argv[2])
print "PROCESSING:", IND_FIRST, IND_LAST


# File with detection times from network FAST
det_file = 'EQ_NEW_LOCAL_EVENT_DETECTIONS.txt' # new local events
#det_file = 'ZOOM2_CATALOG_EVENTS.txt' # catalog events inside M=2 circle/box for magnitude calibration
#det_file = 'NEW_OTHERSIGNAL_11sta_2stathresh_Postprocess_Detections.txt' # new 'other signal' events
#det_file = 'ZOOM1_BLAST_EVENTS.txt' # blast events inside relocation box
#det_file = 'ZOOM1_MISSED_EVENTS.txt' # missed events inside relocation box
#det_file = 'TELESEISMIC_EVENTS.txt' # teleseismic events

times_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/network_detection/'
[det_times, det_rank] = np.loadtxt(times_dir+det_file, unpack=True)
print len(det_times)
out_dir = times_dir+'EventWaveforms_11sta_2stathresh/' # new local events
#out_dir = times_dir+'CatalogZOOM2Waveforms_11sta_2stathresh/' # catalog events inside M=2 circle/box for magnitude calibration
#out_dir = times_dir+'OtherWaveforms_11sta_2stathresh/' # new 'other signal' events
#out_dir = times_dir+'BlastWaveforms_11sta_2stathresh/' # blast events to relocate
#det_times = np.loadtxt(times_dir+det_file, unpack=True)
#out_dir = times_dir+'MissedWaveforms_11sta_2stathresh/' # missed events to relocate
#out_dir = times_dir+'TeleseismicWaveforms_11sta_2stathresh/' # teleseismic events
if not os.path.exists(out_dir):
   os.makedirs(out_dir)

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
#   st.filter('bandpass', freqmin=2, freqmax=10)

   i_load += 1

   for itr in range(len(st)):
#      out_file = out_dir+'event_rank'+str(int(det_rank[kk])).zfill(5)+'_time'+str(int(det_times[kk]))+'_'+start_time.strftime("%Y%m%d%H%M%S.%f")+'.'+st[itr].stats.station+'.'+st[itr].stats.channel+'.SAC'
#      out_file = out_dir+'catevent_rank'+str(int(det_rank[kk])).zfill(5)+'_time'+str(int(det_times[kk]))+'_'+start_time.strftime("%Y%m%d%H%M%S.%f")+'.'+st[itr].stats.station+'.'+st[itr].stats.channel+'.SAC'
#      out_file = out_dir+'otherevent_rank'+str(int(det_rank[kk])).zfill(5)+'_time'+str(int(det_times[kk]))+'_'+start_time.strftime("%Y%m%d%H%M%S.%f")+'.'+st[itr].stats.station+'.'+st[itr].stats.channel+'.SAC'
      out_file = out_dir+'event_rank_time'+str(int(det_times[kk]))+'_'+start_time.strftime("%Y%m%d%H%M%S.%f")+'.'+st[itr].stats.station+'.'+st[itr].stats.channel+'.SAC'
      st[itr].write(out_file, format='SAC')

print "Number of event waveforms loaded =", i_load 
