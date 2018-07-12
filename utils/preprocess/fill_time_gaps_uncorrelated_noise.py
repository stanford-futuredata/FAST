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

##ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES02/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES04/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES06/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES08/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/CES09/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/TanzaniaMonth/filled/'
#file_arr = glob.glob(ts_dir+'TZ.*')
#format_str = 'MSEED'

##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-01-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-02-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-03-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-04-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-05-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-06-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-07-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-08-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-09-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-10-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-11-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-12-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-13-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-14-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-15-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-16-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-17-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-18-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-19-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-20-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-21-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-22-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-23-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-24-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-25-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-26-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-27-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-28-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-29-00-00-00/sac/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-30-00-00-00/sac/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/2014-05-31-00-00-00/sac/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/data/filled/'
#file_arr = glob.glob(ts_dir+'*.SAC')
#format_str = 'SAC'

##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110101/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110102/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110103/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110104/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110105/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110106/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110107/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110108/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110109/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110110/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110111/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110112/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110113/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/20110114/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/filled/'
#file_arr = glob.glob(ts_dir+'2011*.sac')
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/ORIGINAL_DATA/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/after/'
#file_arr = glob.glob(ts_dir+'*.BH*')
#format_str = 'SAC'

##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.EWJHS/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY01/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY02/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY03/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY04/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY05/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY06/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY07/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY08/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY09/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY10/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY11/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY12/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY13/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY14/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY15/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY16/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNY17/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.LNYS/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.MURBA/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.NUMJS/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.OLAS/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.SUMJS/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ01/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ02/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ03/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ04/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ05/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ06/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ07/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ08/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ09/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ10/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ11/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJ12/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/SaudiFull/SA.UMJS/'
#out_dir = ts_dir+'filled/'
#file_arr = glob.glob(ts_dir+'*.seed')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/ORIGINAL_DATA/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/Ometepec/waveformsPNIG/'
#file_arr = glob.glob(ts_dir+'*.sac')
#format_str = 'SAC'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/CZSB/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/BrazilAcre/CZSB/'
#file_arr = glob.glob(ts_dir+'BR*')
#format_str = 'MSEED'

##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKAK/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKFG/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKRE/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKSO/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKSP/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKWE/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/waveformsOKWR/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/Okmok/data/'
#file_arr = glob.glob(ts_dir+'AVO*')
#format_str = 'MSEED'

##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsENM4/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsENV4/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG014/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG024/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG034/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG044/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG054/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG064/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG074/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG084/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG094/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG104/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG114/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG134/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG144/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG164/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG174/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG184/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG194/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG204/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG214/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG224/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG234/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG244/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG264/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG274/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG304/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG314/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG324/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG344/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG364/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG374/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG394/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG404/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG414/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG424/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG434/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG444/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG454/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG464/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG494/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG504/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG514/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG524/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG534/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG544/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG554/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG564/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG574/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG584/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG594/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG604/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG614/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG624/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG634/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG644/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG654/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG664/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG674/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG684/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsG694/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsHWF4/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsT014/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsT034/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsT054/'
##ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsVLW4/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/waveformsZLV4/'
#out_dir = '/lfs/1/ceyoon/TimeSeries/Groningen/data/'
#file_arr = glob.glob(ts_dir+'NL*')
#format_str = 'MSEED'

#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsENWF/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsKEMF/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsKEMO/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsNC27/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsNC89/'
#ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsNCBC/'
ts_dir = '/lfs/1/ceyoon/TimeSeries/NEP/waveformsNCHR/'
out_dir = '/lfs/1/ceyoon/TimeSeries/NEP/'
file_arr = glob.glob(ts_dir+'NV*.mseed')
format_str = 'MSEED'


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
