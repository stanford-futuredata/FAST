from obspy import read
import numpy as np
import matplotlib.pyplot as plt

# Script to detect time gaps filled with 0's
def detect_time_gaps(file_name, min_samples=10, epsilon=1e-20, thresh_disc=100):
   # Read data
#   st = read(file_name, format='SAC')
   st = read(file_name)
   tdata = st[0].data

   indz = np.where(abs(tdata) < epsilon)[0] # indices where we have 0
   diff_indz = indz[min_samples:] - indz[0:-min_samples] # Need min_samples consecutive samples with 0's to identify as time gap
   ind_des = np.where(diff_indz == min_samples)[0] # desired indices: value is equal to min_samples in the time gap
   ind_gap = indz[ind_des] # indices of the time gaps

   gap_start_ind = []
   gap_end_ind = []

   if (0 == len(ind_gap)): # No time gaps found
      num_gaps = 0
   else:
      # May have more than 1 time gap
      ind_diff = np.diff(ind_gap) # discontinuities in indices of the time gaps, if there is more than 1 time gap
      ind_disc = np.where(ind_diff > thresh_disc)[0]

      # N-1 time gaps
      print ind_gap
      curr_ind_start = ind_gap[0]
      print curr_ind_start
      for igap in range(len(ind_disc)): # do not enter this loop if ind_disc is empty
	 gap_start_ind.append(curr_ind_start)
	 last_index = ind_gap[ind_disc[igap]] + min_samples
	 gap_end_ind.append(last_index)
	 curr_ind_start = ind_gap[ind_disc[igap]+1] # update for next iteration

      # Last time gap
      gap_start_ind.append(curr_ind_start)
      gap_end_ind.append(ind_gap[-1] + min_samples)
      num_gaps = len(gap_start_ind)
   
   return [num_gaps, gap_start_ind, gap_end_ind]
