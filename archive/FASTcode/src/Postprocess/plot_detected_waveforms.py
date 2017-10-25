import matplotlib.pyplot as plt
import numpy as np
from obspy import read

#times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_10to11day_3ch_24hr_Filter3to20/'
#out_dir = '../../figures/Ometepec/Filter3to20/DetectedWaveforms/'
#times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to20/'
#out_dir = '../../figures/Ometepec/Filter3to20/2to3dayDetectedWaveforms/'
#times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to20/'
#out_dir = '../../figures/Ometepec/Filter3to20/8to9dayDetectedWaveforms/'
#times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to30/'
#out_dir = '../../figures/Ometepec/Filter3to30/2to3dayDetectedWaveforms/'
#times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to30/'
#out_dir = '../../figures/Ometepec/Filter3to30/8to9dayDetectedWaveforms/'
times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_15days_3ch_Filter3to20/'
out_dir = '../../figures/Ometepec/Filter3to20/15daysDetectedWaveforms/'

#[det_times, det_sim] = np.loadtxt(times_dir+'fast_wLen6_wLag0.2_fpLen128_fpLag10_tvalue1600_nfuncs5_ntbls100_nvotes2_timewin25_thresh0.1.txt', unpack=True, skiprows=1)
[det_times, det_sim] = np.loadtxt(times_dir+'fast_wLen6_wLag0.2_fpLen128_fpLag10_tvalue1600_nfuncs5_ntbls100_nvotes2_timewin25_thresh0.08.txt', unpack=True, skiprows=1)
ind_descend = np.argsort(det_sim)[::-1]
det_times = det_times[ind_descend]
det_sim = det_sim[ind_descend]
print len(det_times)

sac_dir = '../../data/TimeSeries/Ometepec/'
#allch = read(sac_dir+'10to11day.*')
#allch = read(sac_dir+'2to3day.201203.PNIG.HH*.bp3to20')
#allch = read(sac_dir+'8to9day.201203.PNIG.HH*.bp3to20')
#allch = read(sac_dir+'2to3day.201203.PNIG.HH*.bp3to30')
#allch = read(sac_dir+'8to9day.201203.PNIG.HH*.bp3to30')
allch = read(sac_dir+'Fill.15days.201203.PNIG.HH*.sac.bp3to20')
nch = len(allch)
print nch

dt = allch[0].stats.starttime
wtime_before = 0
wtime_after = 60

out_width = 400
out_height = 600



for k in range(len(det_times)):
   start_time = dt + det_times[k] - wtime_before
   end_time = dt + det_times[k] + wtime_after
   st_slice = allch.slice(start_time, end_time)

#   out_file = out_dir+'event_rank'+format(k,'04d')+'_sim'+str(det_sim[k])+'_time'+str(det_times[k])+'.png'
   out_file = out_dir+'event_rank'+format(k,'05d')+'_sim'+str(det_sim[k])+'_time'+str(det_times[k])+'.png'
   st_slice.plot(equal_scale=False, size=(out_width,out_height), outfile=out_file)
