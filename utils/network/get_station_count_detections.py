# Script to determine the number of channels from stations available during event time
# Use this when different stations in network have different durations
# Call this script after delete_overlap_network_detections.py

import numpy as np
import glob

# ---------------------------------------------------INPUTS --------------------------------------------
#base_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/'
#dt_fp = 2.0
#detfile_name = '15sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'
#outfile_name = '15sta_2stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt'
#ch_per_sta = 3

base_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/'
dt_fp = 1.2
detfile_name = '36sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt'
outfile_name = '36sta_3stathresh_ChannelCount_FinalUniqueNetworkDetectionTimes.txt'
ch_per_sta = 3
# ---------------------------------------------------INPUTS --------------------------------------------

dur_dir = base_dir+'continuous_duration/'
dur_ind_files = sorted(glob.glob(dur_dir+'indices_continuous.*'))
num_ch = len(dur_ind_files)
print 'Number of files: ', num_ch

# Load duration data (start_index, len_index) for all channels and stations
dur_data = []
for ich in range(num_ch):
   curr_ch_data = np.loadtxt(dur_ind_files[ich], unpack=True)
   dur_data.append(curr_ch_data)

# Load detection data
det_dir = base_dir+'network_detection/'
[det_start_ind, det_end_ind, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum, num_sta, diff_ind] = np.loadtxt(det_dir+detfile_name, usecols=(0,1,2,3,4,5,6,7,8,9,10,11), unpack=True)
det_times = dt_fp * det_start_ind
num_det = len(det_times)
print 'Number of detections: ', num_det

# Loop over detections
fout = open(det_dir+outfile_name, 'w')
for idet in range(num_det):
   curr_det = det_times[idet]

   # Count number of channels recording data during each detection time
   curr_count = 0

   # Loop over channels
   for ich in range(num_ch):
      curr_ch_data = dur_data[ich]
      if (len(np.shape(curr_ch_data)) == 1):
	 curr_ch_data = np.transpose(np.atleast_2d(dur_data[ich]))
      num_dur = np.shape(curr_ch_data)[1]

      if (num_dur == 1):
	 if (curr_det < curr_ch_data[0,0]): # check if out of duration bounds
	    continue
      else:
	 if ((curr_det < curr_ch_data[0,0]) or (curr_det > (curr_ch_data[0,-1]+curr_ch_data[1,-1]))): # check if out of duration bounds
	    continue

      # Get the index (idur) of the duration chunk containing this detection time
      idur = 0	 
      for idur in range(num_dur):
	 # If the detection time is within this duration chunk, increment the count
	 if ((curr_det >= curr_ch_data[0,idur]) and (curr_det <= (curr_ch_data[0,idur]+curr_ch_data[1,idur]))):
	    curr_count += 1
	    break

   # Output the fraction of channels available at this detection time
###   frac_ch = float(curr_count)/float(num_ch)
   frac_ch = ch_per_sta * float(num_sta[idet])/float(curr_count)
   print "idet = ", idet, ", num_sta = ", num_sta[idet], ", curr_count = ", curr_count, ", frac_ch = ", frac_ch

   fout.write(('%12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12.8f\n') % (det_start_ind[idet], det_end_ind[idet], dL[idet], nevents[idet], nsta[idet], tot_ndets[idet], max_ndets[idet], tot_vol[idet], max_vol[idet], peaksum[idet], num_sta[idet], diff_ind[idet], frac_ch))
fout.close()
