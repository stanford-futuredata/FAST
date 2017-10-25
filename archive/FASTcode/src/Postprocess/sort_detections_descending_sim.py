import matplotlib.pyplot as plt
import numpy as np
from obspy import read

times_dir = '../../data/OutputFAST/totalMatrix_IG_PNIG_15days_3ch_Filter3to20/'

[det_times, det_sim] = np.loadtxt(times_dir+'fast_wLen6_wLag0.2_fpLen128_fpLag10_tvalue1600_nfuncs5_ntbls100_nvotes2_timewin25_thresh0.08.txt', unpack=True, skiprows=1)
ind_descend = np.argsort(det_sim)[::-1]
det_times = det_times[ind_descend]
det_sim = det_sim[ind_descend]
print len(det_times)

out_file = times_dir+'descend_sim_fast_wLen6_wLag0.2_fpLen128_fpLag10_tvalue1600_nfuncs5_ntbls100_nvotes2_timewin25_thresh0.08.txt'
np.savetxt(out_file, np.c_[det_times, det_sim], fmt=['%7.5f', '%6.5f'])
