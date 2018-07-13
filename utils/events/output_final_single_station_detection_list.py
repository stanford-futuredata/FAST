from obspy import read
from obspy import UTCDateTime
import numpy as np

# Output final detection list

# ---------------------------------------------------INPUTS --------------------------------------------
times_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/network_detection/'
infile_name = 'EQ_sort_peaksum_1sta_1stathresh_CZSB_events.txt'
outfile_name = times_dir+'FINAL_Detection_List_BrazilAcre_1sta_1stathresh_peaksum6.txt'
init_time = UTCDateTime('2015-10-28T00:00:21.340000') # global start time for all channels
dt_fp = 2.0

#times_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/network_detection/'
#infile_name = 'EQ_sort_peaksum_1sta_1stathresh_PNIG_events.txt'
#outfile_name = times_dir+'FINAL_Detection_List_Ometepec_1sta_1stathresh_peaksum6.txt'
#init_time = UTCDateTime('2012-01-01T00:00:15.800000') # global start time for all channels
#dt_fp = 2.0
# ---------------------------------------------------INPUTS --------------------------------------------

# ================================================================

# Get original detection list data
[det_start_ind, dL, ndets, peaksum, vol] = np.loadtxt(times_dir+infile_name, unpack=True)
det_times = dt_fp * det_start_ind
print len(det_times)

# Output detection list with only necessary data
with open(outfile_name, 'w') as fout:
   for kk in range(len(det_times)):
      event_time = init_time + det_times[kk]
      fout.write(('%s %12.2f %12d %12d %12d\n') % (event_time.strftime('%Y-%m-%dT%H:%M:%S.%f'), det_times[kk], det_start_ind[kk], dL[kk], peaksum[kk]))
