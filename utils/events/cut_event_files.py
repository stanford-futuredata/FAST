from struct import unpack
from time import time
from obspy import read
from obspy import Stream
from obspy import UTCDateTime
from obspy.clients.fdsn import Client 
from obspy.clients.fdsn.header import FDSNException
import numpy as np
import matplotlib.pyplot as plt
import datetime
import sys
import os
import json
import glob
import collections

EQ = collections.namedtuple("EQ", ["ev_id_list", "det_ts", "det_time", "det_start_ind", "dL", "diff_ind", "nsta", "peaksum"])

# Inputs - Hector Mine
stations = ['CDY', 'CPM', 'GTM', 'HEC', 'RMM', 'RMR', 'TPC']
in_mseed_dir = '../../data/'
in_FINAL_Detection_List = '../../data/network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'
out_dir = '../../data/event_ids'
init_time = UTCDateTime('1999-10-15T13:00:00.676000', precision=2) # global start time for all channels
dt_fp = 1.0

## Inputs - Calipatria
#stations = ["USGCB", "BC3", "BOM", "CLI2", "COA", "COK2", "CRR",
#	"CTC", "CTW", "DRE", "ERR", "FRK", "IMP", "NSS2", 
#	"OCP", "RXH", "SAL", "SLB", "SLV", "SNR", "SWP",
#	"SWS", "THM", "WMD", "WWF", "286", "5056", "5058",
#	"5062", "5271", "5274", "5444", 
#        "WLA", "WLA01", "WLA03", "WLA04", "WLA06"]
#in_mseed_dir = '../../data/20210605_Calipatria_Data/'
#in_FINAL_Detection_List = '../../data/20210605_Calipatria_Data/network_detection/FINAL_Detection_List_Calipatria_37sta_3stathresh.txt'
#out_dir = '../../data/20210605_Calipatria_Data/event_ids'
#init_time = UTCDateTime('2021-06-05T00:00:06.840000', precision=2) # global start time for all channels
#dt_fp = 1.2


# wtime_before is the number of seconds before the event 
# time (first column in FINAL_Detection_List_HectorMine_7sta_2stathresh.txt).  
# wtime_after is the number of seconds after the event time.  
# these parameters specify the window length (total of 180 seconds, for the default parameters)

wtime_before = 60 # time window before origin time (s)
wtime_after = 120 # time window after origin time (s)

if not os.path.exists(out_dir):
    os.makedirs(out_dir)

det_times = []
diff_times = []

with open(in_FINAL_Detection_List, 'r') as f:
    EQ_data = f.readlines()[:]

EQ_detections = []

for data in EQ_data:
    line = data.split()
    ev_id = line[0]
    det_ts = line[1]
    det_time = line[2]
    det_start_ind = line[3]
    dL = line[4]
    diff_ind = line[5]
    nsta = line[6]
    peaksum = line[7]

    det_times.append(int(float(det_start_ind)) * dt_fp)
    diff_times.append(int(diff_ind) * dt_fp)

    # print(f"ev_id: {ev_id}\ndet_time: {det_time}\ndet_start)ind: {det_start_ind}\ndet_end_ind: {det_end_ind}\ndL: {dL}\ndiff_ind: {diff_ind}\nnsta: {nsta}\npeaksum: {peaksum}")

    EQ_detection = EQ(ev_id, det_ts, det_time, det_start_ind, dL, diff_ind, nsta, peaksum)
    EQ_detections.append(EQ_detection)

# Cut event files from original unfiltered data (NOT decimated filtered data) for further phase picking
st = read('../../data/waveforms*/19991015*', format='SAC')
#st = read('../../data/20210605_Calipatria_Data/waveforms*/[!Deci]*.mseed')
print(st.__str__(extended=True))
print(len(st))

print("\n ------------------- OUTPUT CUT EVENT FILES --------------------------\n")

i_load = 0

for kk in range(len(EQ_detections)):
    curr_ev = EQ_detections[kk].ev_id_list
    out_file_dir = out_dir + "/" + curr_ev
    if not os.path.exists(out_file_dir):
        os.makedirs(out_file_dir)

    ev_time = init_time + det_times[kk]
    start_time = ev_time - wtime_before
    end_time = ev_time + wtime_after
    print(kk, EQ_detections[kk].det_ts, start_time, end_time)

    i_load += 1

#    Read in time window for event files from daylong .sac files
    for ista in stations:
        st_slice = st.slice(start_time, end_time)

        for tr in st_slice:
            timestamp = str(ev_time.year).zfill(2) + str(ev_time.month).zfill(2) + str(ev_time.day).zfill(2) + str(ev_time.hour).zfill(2) + str(ev_time.minute).zfill(2) + str(ev_time.second).zfill(2)

            output_file_name = out_file_dir + "/" + curr_ev +'_'+ timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.sac'
            tr.write(output_file_name, format='SAC')

            # plot_file = '../../data/plots/' + curr_ev + '_' + timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.png'
            # tr.plot(equal_scale=False, size=(400,800), outfile=plot_file)

print ("Number of event waveforms loaded =", i_load) 
