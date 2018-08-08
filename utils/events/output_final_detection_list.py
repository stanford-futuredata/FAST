from obspy import read
from obspy import UTCDateTime
import numpy as np

# Output final detection list

# ---------------------------------------------------INPUTS --------------------------------------------
times_dir = '../../data/network_detection/'
infile_name = 'EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'
outfile_name = times_dir+'FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'
init_time = UTCDateTime('1999-10-15T13:00:00.676000') # global start time for all channels
dt_fp = 1.0

#times_dir = '/lfs/1/ceyoon/TimeSeries/HectorMine/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'
#init_time = UTCDateTime('1999-10-15T13:00:00.676000') # global start time for all channels
#dt_fp = 1.0

#times_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_22sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_ItalyDayYR_22sta_3stathresh.txt'
#init_time = UTCDateTime('2016-10-29T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_19sta_4stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_SaudiMonth_19sta_4stathresh.txt'
#init_time = UTCDateTime('2014-05-01T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_5sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_TanzaniaMonth_5sta_3stathresh.txt'
#init_time = UTCDateTime('2016-07-31T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_35sta_15stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_OBSTest_35sta_15stathresh.txt'
#init_time = UTCDateTime('2011-01-01T00:00:17.800000') # global start time for all channels
#dt_fp = 2.0

#times_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_15sta_2stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_AllWenchuan_15sta_2stathresh.txt'
#init_time = UTCDateTime('2008-04-01T00:00:17.800000') # global start time for all channels
#dt_fp = 2.0

#times_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_36sta_3stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_SaudiFull_36sta_3stathresh.txt'
#init_time = UTCDateTime('2017-01-01T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_7sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_Okmok_7sta_3stathresh.txt'
#init_time = UTCDateTime('2008-07-18T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_67sta_13stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_Groningen_67sta_13stathresh.txt'
#init_time = UTCDateTime('2018-01-01T00:00:04.500000') # global start time for all channels
#dt_fp = 1.5

# ---------------------------------------------------INPUTS --------------------------------------------

# ================================================================

# Get original detection list data
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+infile_name, usecols=(0,1,2,3,4,5,6,7,8,9,10,11), unpack=True)
det_times = dt_fp * det_start_ind
print len(det_times)

# Output detection list with only necessary data
with open(outfile_name, 'w') as fout:
   for kk in range(len(det_times)):
      event_time = init_time + det_times[kk]
      fout.write(('%s %12.2f %12d %12d %12d %12d %12d\n') % (event_time.strftime('%Y-%m-%dT%H:%M:%S.%f'), det_times[kk], det_start_ind[kk], dL[kk], diff_ind[kk], num_sta[kk], peaksum[kk]))
