from obspy import read
from obspy import UTCDateTime
import numpy as np

# Output final detection list

# Inputs
#times_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_22sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_ItalyDayYR_22sta_3stathresh.txt'
#init_time = UTCDateTime('2016-10-29T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_19sta_4stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_SaudiMonth_19sta_4stathresh.txt'
#init_time = UTCDateTime('2014-05-01T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

#times_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/network_detection/'
#infile_name = 'EQ_sort_nsta_peaksum_5sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = times_dir+'FINAL_Detection_List_TanzaniaMonth_5sta_2stathresh.txt'
#init_time = UTCDateTime('2016-07-31T00:00:06.840000') # global start time for all channels
#dt_fp = 1.2

times_dir = '../../data/network_detection/'
infile_name = 'EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'
outfile_name = times_dir+'FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'
init_time = UTCDateTime('1999-10-15T13:00:00.676000') # global start time for all channels
dt_fp = 1.0

# ================================================================

# Get original detection list data
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(times_dir+infile_name, unpack=True)
det_times = dt_fp * det_start_ind
print len(det_times)

# Output detection list with only necessary data
with open(outfile_name, 'w') as fout:
   for kk in range(len(det_times)):
      event_time = init_time + det_times[kk]
      fout.write(('%s %12.2f %12d %12d %12d %12d %12d\n') % (event_time.strftime('%Y-%m-%dT%H:%M:%S.%f'), det_times[kk], det_start_ind[kk], det_end_ind[kk], diff_ind[kk], num_sta[kk], peaksum[kk]))
