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

EQ = collections.namedtuple("EQ", ["ev_id_list", "det_time", "det_start_ind", "det_end_ind", "dL", "diff_ind", "nsta", "peaksum"])

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

dt_fp = 1.0
det_times = []
diff_times = []
dL_dt = []

with open(in_FINAL_Detection_List, 'r') as f:
    EQ_data = f.readlines()[:]

EQ_detections = []

for data in EQ_data:
    line = data.split()
    ev_id = line[0]
    det_time = line[1]
    det_start_ind = line[2]
    det_end_ind = line[3]
    dL = line[4]
    diff_ind = line[5]
    nsta = line[6]
    peaksum = line[7]
    # ev_id = data[0:8].strip()
    # det_time = data[9:35].strip()
    # det_start_ind = data[40: 45].strip()
    # det_end_ind = data[56:62].strip()
    # dL = data[72: 75].strip()
    # diff_ind = data[84:88].strip()
    # nsta = data[99:101].strip()
    # peaksum = data[109:114].strip()

    det_times.append(int(det_start_ind) * dt_fp)
    diff_times.append(int(diff_ind) * dt_fp)
    dL_dt.append(int(dL) * dt_fp)

    # print(f"ev_id: {ev_id}\ndet_time: {det_time}\ndet_start)ind: {det_start_ind}\ndet_end_ind: {det_end_ind}\ndL: {dL}\ndiff_ind: {diff_ind}\nnsta: {nsta}\npeaksum: {peaksum}")

    EQ_detection = EQ(ev_id, det_time, det_start_ind, det_end_ind, dL, diff_ind, nsta, peaksum)
    EQ_detections.append(EQ_detection)

st = read('waveforms*/Deci5.Pick.*', format='SAC')
print(len(st))
print(st.__str__(extended=True))

print("\n ------------------- OUTPUT CUT EVENT FILES --------------------------\n")


# stations_ = json.load(open(in_station_file))

# det_times = EQ_detections.det_start_in

i_load = 0

for kk in range(len(EQ_detections)):
    curr_ev = EQ_detections[kk].ev_id_list

    ev_time = init_time + det_times[kk]
    start_time = ev_time - wtime_before
    end_time = ev_time + wtime_after

    if (int(diff_times[kk]) > wtime_after): # special case: unusually long delay between start and end times
      end_time = ev_time + diff_times[kk] + wtime_after

    i_load += 1

#    Read in time window for event files from daylong .sac files
#     st_all = Stream()
    for ista in stations:
#         net = val['network']
#         ev_origin_date = datetime.datetime(ev_origin_time.year, ev_origin_time.month, ev_origin_time.day)
#         origin_date_str = datetime.datetime.strftime(ev_origin_date, '%Y%m%d')
#         mseed_files = glob.glob(in_mseed_dir+'*/'+sta+'/'+net+'.'+sta+'*__'+origin_date_str+'T000000Z'+'__*')
#         if (len(mseed_files) > 0):
#             st = read(in_mseed_dir+'*/'+sta+'/'+net+'.'+sta+'*__'+origin_date_str+'T000000Z'+'__*mseed')
#             st_slice = st.slice(start_time, end_time)

        st_slice = st.slice(start_time, end_time)
#       # Filter the cut data
        # st_slice.detrend(type='demean')
        # st_slice.detrend(type='linear')
#         st_slice.filter('bandpass', freqmin=2, freqmax=10, corners=2, zerophase=False)

#         # Output event files in SAC format, in their own event directory
#         out_ev_dir = out_dir+str(ev_id_list[kk])+'/'
#         if not os.path.exists(out_ev_dir):
#         os.makedirs(out_ev_dir)
#         output_event_name = out_ev_dir+'event'+format(ev_id_list[kk],'06d')+'_'+ev_origin_time.strftime('%Y%m%dT%H%M%S.%f')
        for tr in st_slice:

            timestamp = str(ev_time.year) + str(ev_time.month) + str(ev_time.day) + str(ev_time.hour).zfill(2) + str(ev_time.minute).zfill(2) + str(ev_time.second).zfill(2)

            out_file = out_dir + "/" + curr_ev
            output_file_name = out_file + "/" + curr_ev +'_'+ timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.sac'
            tr.write(output_file_name, format='SAC')

            plot_file = 'plots/' + curr_ev + '_' + timestamp + '_' + str(det_times[kk]) + '_' + tr.stats.station + '_' + tr.stats.channel + '.png'
            # st_slice.plot(equal_scale=False, size=(400,800), outfile=plot_file)
            tr.plot(equal_scale=False, size=(400,800), outfile=plot_file)

print ("Number of event waveforms loaded =", i_load) 
