import numpy as np
import glob
import os
from obspy import read
from statsmodels import robust
from detect_time_gaps import detect_time_gaps


# ------------------- INPUTS ------------------------------------------------
#ts_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/filled/'
#file_arr = glob.glob(ts_dir+'YR*.303')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES02/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES04/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES06/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES08/'
ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES09/'
out_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/filled/'
file_arr = glob.glob(ts_dir+'TZ.*')
format_str = 'MSEED'

#ts_dir = '/lfs/raiders2/0/ceyoon/TimeSeries/Wenchuan/after/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/ORIGINAL_DATA/' # after only
#out_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/' # after only
#file_arr = glob.glob(ts_dir+'CombinedAfter*')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/ORIGINAL_DATA/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/'
#file_arr = glob.glob(ts_dir+'*.BH*')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/ORIGINAL_DATA/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/'
#file_arr = glob.glob(ts_dir+'*.sac')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-31-00-00-00/sac/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/filled/'
#file_arr = glob.glob(ts_dir+'*.SAC')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJS/'
#out_dir = ts_dir+'filled/'
#file_arr = glob.glob(ts_dir+'*.seed')

#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsENWF/'
#out_dir = ts_dir+'filled/'
#file_arr = glob.glob(ts_dir+'*.mseed')

# ------------------- INPUTS ------------------------------------------------


if not os.path.exists(out_dir):
   os.makedirs(out_dir)

print 'Number of files: ', len(file_arr)
for ifile in file_arr:

   file_str = os.path.basename(ifile)
   print file_str
   file_name = ts_dir+file_str



   # ------------------- FIND TIME GAPS ------------------------------------------------
   # Minimum number of samples for time gap
   min_samples = 10

   # Machine precision (use to define zero)
   epsilon = 1e-20

   # Threshold for discontinuity for multiple gaps
   thresh_disc = 100

   [num_gaps, gap_start_ind, gap_end_ind] = detect_time_gaps(file_name, min_samples, epsilon, thresh_disc)

   print 'Number of time gaps: ', num_gaps
   print 'Starting index of each time gap: ', gap_start_ind
   print 'Ending index of each time gap: ', gap_end_ind


   # ------------------- FILL TIME GAPS WITH UNCORRELATED NOISE  ------------------------------------------------

   st = read(file_name, format=format_str)

   ntest = 2000 # Number of test samples in data - assume they are noise
   for igap in range(num_gaps):
      ngap = gap_end_ind[igap] - gap_start_ind[igap] + 1
      print 'Number of samples in gap: ', ngap

      # Bounds check
      if (gap_start_ind[igap]-ntest < 0): # not enough data on left side
	 median_gap_right = np.median(st[0].data[gap_end_ind[igap]+1:gap_end_ind[igap]+ntest]) # median of ntest noise values on right side of gap
	 median_gap = median_gap_right
	 mad_gap_right = robust.mad(st[0].data[gap_end_ind[igap]+1:gap_end_ind[igap]+ntest]) # MAD of ntest noise values on right side of gap
	 mad_gap = mad_gap_right
      elif (gap_end_ind[igap]+ntest >= len(st[0].data)): # not enough data on left side
	 median_gap_left = np.median(st[0].data[gap_start_ind[igap]-ntest:gap_start_ind[igap]-1]) # median of ntest noise values on left side of gap
	 median_gap = median_gap_left
	 mad_gap_left = robust.mad(st[0].data[gap_start_ind[igap]-ntest:gap_start_ind[igap]-1]) # MAD of ntest noise values on left side of gap
	 mad_gap = mad_gap_left
      else:
	 median_gap_left = np.median(st[0].data[gap_start_ind[igap]-ntest:gap_start_ind[igap]-1]) # median of ntest noise values on left side of gap
	 median_gap_right = np.median(st[0].data[gap_end_ind[igap]+1:gap_end_ind[igap]+ntest]) # median of ntest noise values on right side of gap
	 median_gap = 0.5*(median_gap_left + median_gap_right)
	 mad_gap_left = robust.mad(st[0].data[gap_start_ind[igap]-ntest:gap_start_ind[igap]-1]) # MAD of ntest noise values on left side of gap
	 mad_gap_right = robust.mad(st[0].data[gap_end_ind[igap]+1:gap_end_ind[igap]+ntest]) # MAD of ntest noise values on right side of gap
	 mad_gap = 0.5*(mad_gap_left + mad_gap_right)

      # Fill in gap with uncorrelated white Gaussian noise
      gap_x = mad_gap*np.random.randn(ngap) + median_gap
      st[0].data[gap_start_ind[igap]:gap_end_ind[igap]+1] = gap_x

   if (num_gaps):
      st.write(out_dir+'Filled.'+file_str, format=format_str)
#   else:
#      os.system('cp '+file_name+' '+out_dir+'Filled.'+file_str)
