from time import time
from obspy import read
from obspy import Stream
from obspy import UTCDateTime
import numpy as np
import matplotlib.pyplot as plt
import datetime
import sys
import os
import json
import glob

# Inputs
stations = ['CDY', 'CPM', 'GTM', 'HEC', 'RMM', 'RMR', 'TPC']
in_mseed_dir = '../../data/'
in_FINAL_Detection_List = 'network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'
out_dir = 'event_ids'

init_time = UTCDateTime('1999-10-15T13:00:00.676000', precision=2) # global start time for all channels

# wtime_before is the number of seconds before the event 
# time (first column in FINAL_Detection_List_HectorMine_7sta_2stathresh.txt).  
# wtime_after is the number of seconds after the event time.  
# these parameters specify the window length (total of 180 seconds, for the default parameters)

wtime_before = 60 # time window before origin time (s)
wtime_after = 120 # time window after origin time (s)

if not os.path.exists(out_dir):
    os.makedirs(out_dir)

ev_ids = []
det_times = []
det_start_times = []
det_end_times = []
dt_fp = 1.0
det_times = []
diff_times = []
dL_dt = []
nstas = []
peaksums = []

with open(in_FINAL_Detection_List, 'r') as f:
    EQ_data = f.readlines()[:]

EQ_detections = []

for data in EQ_data:
    line = data.split()
    ev_ids.append(line[0])
    det_times.append(line[1])
    det_start_times.append(line[2])
    det_end_times.append(line[3])
    dL = line[4]
    diff_ind = line[5]
    nstas.append(line[6])
    peaksums.append(line[7])
    det_times.append(int(det_start_ind) * dt_fp)
    diff_times.append(int(diff_ind) * dt_fp)
    dL_dt.append(int(dL) * dt_fp)

st = read('waveforms*/Deci5.Pick.*', format='SAC')
print(len(st))
print(st.__str__(extended=True))

print("\n ------------------- OUTPUT CUT EVENT FILES --------------------------\n")

i_load = 0

for kk in range(len(ev_ids)):
    curr_ev = ev_ids[kk]

    ev_time = init_time + det_times[kk]
    start_time = ev_time - wtime_before
    end_time = ev_time + wtime_after

    if (int(diff_times[kk]) > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

    i_load += 1

#    Read in time window for event files from daylong .sac files
    for ista in stations:
        st_slice = st.slice(start_time, end_time)

        for tr in st_slice:
            timestamp = str(ev_time.year) + str(ev_time.month) + str(ev_time.day) + str(ev_time.hour).zfill(2) + str(ev_time.minute).zfill(2) + str(ev_time.second).zfill(2)

            out_file = out_dir + "/" + curr_ev
            output_file_name = out_file + "/" + curr_ev +'_'+ timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.sac'
            tr.write(output_file_name, format='SAC')

            plot_file = 'plots/' + curr_ev + '_' + timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.png'
            tr.plot(equal_scale=False, size=(400,800), outfile=plot_file)

print ("Number of event waveforms loaded =", i_load) 