from obspy import read
import os
import numpy as np
from matplotlib import rcParams
import matplotlib.pyplot as plt
from remove_narrowband_correlated_noise import separate_corr_noise_from_eq

############################################## FUNCTION DEFINITIONS ##########################################################

### Function to output waveforms for matching/new/missed detections
def output_waveforms_to_file(allch, out_wv_dir, startstr, ref_time, det_times, det_sim, window_length):
   for i in range(len(det_times)):
#   for i in [54, 334, 858, 1068, 1288, 1366, 1490]:
      wv_start_time = det_times[i] # waveform start time
      out_file = out_wv_dir+startstr+'_waveforms_rank'+format(i,'05d')+'_mag'+str(det_sim[i])+'_time'+str(det_times[i])+'.png'
#      out_file = out_wv_dir+startstr+'_waveforms_rank'+format(i,'05d')+'_mag'+str(det_sim[i])+'_time'+str(det_times[i])+'.eps'
      print out_file
      allch.plot(starttime=ref_time+wv_start_time-2, endtime=ref_time+wv_start_time+window_length+2,
	    size=(600,800), outfile=out_file, dpi=140)


### Function to read in matching/new/missed detection times from comparison text file
def read_match_new_missed_detections_from_file(input_dir, input_file):
   match_map = {}
   new_map = {}
   missed_map = {}
   list_match_magnitude = [] # matching detections: template matching magnitude
   list_match_fast_sim = [] # matching detections: FAST similarity

   with open(input_dir+input_file, "r") as f:

      # Read until "Matching detections"
      while True:
	 line = f.readline()
	 if (line.startswith('Matching')):
	    num_match = int(line.split()[2])
	    break

      line = f.readline()
      line = f.readline()
      line = f.readline()

      # Read all matching detection times
      for i in range(num_match):
	 linestr = f.readline().split()
	 tmp_time = float(linestr[3])
	 tmp_mag = float(linestr[4])
	 match_map[tmp_time] = tmp_mag
	 list_match_magnitude.append(tmp_mag)
	 list_match_fast_sim.append(float(linestr[1]))

      # Read until "New detections"
      while True:
	 line = f.readline()
	 if (line.startswith('New')):
	    num_new = int(line.split()[2])
	    break

      line = f.readline()

      # Read all new detection times (new events or false detections?)
      for i in range(num_new):
	 linestr = f.readline().split()
	 tmp_time = float(linestr[0])
	 tmp_mag = float(linestr[1])
	 new_map[tmp_time] = tmp_mag

      # Read until "Missed detections"
      while True:
	 line = f.readline()
	 if (line.startswith('Missed')):
	    num_missed = int(line.split()[2])
	    break

      line = f.readline()
      line = f.readline()
      line = f.readline()

      # Read all missed detection times
      for i in range(num_missed):
	 linestr = f.readline().split()
	 tmp_time = float(linestr[0])
	 tmp_mag = float(linestr[1])
	 missed_map[tmp_time] = tmp_mag

   f.close()

   print 'Matching detections: ', len(match_map)
   print 'New detections: ', len(new_map)
   print 'Missed detections: ', len(missed_map)

   return match_map, new_map, missed_map, list_match_magnitude, list_match_fast_sim


### Function to sort detection times in descending order of magnitude (or similarity)
def sort_descending_order(det_map):
   sorted_map = sorted(det_map.items(), key=lambda x: x[1], reverse=True)
   det_times = [x[0] for x in sorted_map]
   det_mag = [x[1] for x in sorted_map]
   return det_times, det_mag


### Function to plot template matching magnitude vs FAST similarity
def plot_magnitude_vs_FAST_similarity(input_dir, file_final_new_event_sim, file_final_new_event_mag, start_date, end_date, list_match_fast_sim, list_match_magnitude):
   new_event_sim = np.loadtxt(input_dir+file_final_new_event_sim, unpack=True)
   new_event_mag = np.loadtxt(input_dir+file_final_new_event_mag, unpack=True)
   plt.figure(num=0, figsize=(9,6))
   ax = plt.plot(list_match_fast_sim, list_match_magnitude, 'o', label=str(len(list_match_magnitude))+' matching events')
   plt.plot(new_event_sim, new_event_mag, 'go', label=str(len(new_event_mag))+' new events')
   rcParams.update({'font.size': 14})
   plt.xlabel('network FAST similarity')
   plt.ylabel('Local magnitude')
   plt.title('Local magnitude vs. network FAST similarity, '+start_date+' to '+end_date, y=1.04)
   plt.legend(loc=4, fontsize=14)
   plt.savefig(input_dir+'match_magnitude_vs_fast_sim.png')
   plt.clf()


### Function to plot magnitude vs. time for all detections (matching/new/missed)
def plot_magnitude_vs_detection_time(input_dir, file_final_new_event_time, file_final_new_event_mag, start_date, end_date, match_time, match_mag, missed_time, missed_mag):
   # Read in new event detections (verified visually)
   new_event_time = np.loadtxt(input_dir+file_final_new_event_time, unpack=True)
   new_event_mag = np.loadtxt(input_dir+file_final_new_event_mag, unpack=True)
   print 'New event detections, verified visually: ', len(new_event_time)

   plt.figure(num=1, figsize=(20,6))
   plt.stem(match_time, match_mag, linefmt='b', markerfmt='bo', label=str(len(match_time))+' matching events', bottom=-2)
   plt.stem(missed_time, missed_mag, linefmt='r', markerfmt='ro', label=str(len(missed_time))+' missed events', bottom=-2)
   plt.stem(new_event_time, new_event_mag, linefmt='g', markerfmt='go', label=str(len(new_event_time))+' new events', bottom=-2)
   plt.legend(loc=9)
   #plt.xlim([0, 604800])
   plt.xlim([0, 2678400])
   plt.ylim([-2, 3])
   plt.xlabel('Time (s) since 2010-07-01')
   plt.ylabel('Local magnitude')
   plt.title('FAST and template matching detections, WHAR 3-component, '+start_date+' to '+end_date)
   plt.savefig(input_dir+'detections_magnitude_vs_time.png')
   plt.clf()

### Function to plot magnitude vs. time for all detections (matching/new/missed)
def plot_mag_vs_detection_time(input_dir, file_final_new_event_time, file_final_new_event_mag, file_final_match, file_final_missed, start_date, end_date):
   # Read in matching event detections (verified visually)
   [match_time, match_mag] = np.loadtxt(input_dir+file_final_match, unpack=True)
   print 'Matching event detections, verified visually: ', len(match_time)

   # Read in missed event detections (verified visually)
   [missed_time, missed_mag] = np.loadtxt(input_dir+file_final_missed, unpack=True)
   print 'Missed event detections, verified visually: ', len(missed_time)

   # Read in new event detections (verified visually)
   new_event_time = np.loadtxt(input_dir+file_final_new_event_time, unpack=True)
   new_event_mag = np.loadtxt(input_dir+file_final_new_event_mag, unpack=True)
   print 'New event detections, verified visually: ', len(new_event_time)

#   plt.figure(num=1, figsize=(40,6))
   plt.figure(num=1, figsize=(50,6))
   plt.stem(match_time, match_mag, linefmt='b', markerfmt='bo', label=str(len(match_time))+' matching events: detected by template matching and FAST', bottom=-2)
   plt.stem(missed_time, missed_mag, linefmt='r', markerfmt='ro', label=str(len(missed_time))+' missed events: detected only by template matching', bottom=-2)
   plt.stem(new_event_time, new_event_mag, linefmt='c', markerfmt='co', label=str(len(new_event_time))+' new events: detected only by FAST', bottom=-2)
   plt.legend(loc=9, fontsize=16)
   rcParams.update({'font.size': 16})
   plt.xlim([0, 7948800])
   plt.ylim([-2, 3])
   plt.xlabel('Time (s) since 2010-06-01')
   plt.ylabel('Local magnitude')
   plt.title('FAST and template matching detections, WHAR 3-component, '+start_date+' to '+end_date)
#   plt.savefig(input_dir+'detections_magnitude_vs_time.png')
   plt.savefig(input_dir+'detections_magnitude_vs_time.eps')
   plt.clf()

### Function to output all waveforms
def plot_output_all_waveforms(file_HHE, file_HHN, file_HHZ, input_dir, out_wv_dir, match_time, match_mag, new_time, new_mag, missed_time, missed_mag):
   # Read in waveform data
   sac_dir = '/data/beroza/ceyoon/multiple_components/data/GuyArkansas/'
   allch = read(sac_dir+file_sac_HHE)
   allch += read(sac_dir+file_sac_HHN)
   allch += read(sac_dir+file_sac_HHZ)

   ref_time = allch[0].stats.starttime 
   window_length = 4 # window length (s)

   # Create output waveform directory if it does not already exist
   if not os.path.exists(out_wv_dir):
      os.makedirs(out_wv_dir)

   # Post-processing: Remove narrowband correlated noise from new detections
   out_new_eq_file = input_dir+'postproc_new_eq_detections.txt'
   out_new_noise_file = input_dir+'postproc_new_noise_detections.txt'
   new_eq_time, new_eq_sim, new_noise_time, new_noise_sim = separate_corr_noise_from_eq(new_time,
	 new_mag, window_length, allch, out_new_eq_file, out_new_noise_file)
#   new_eq_time = np.loadtxt(input_dir+file_final_new_event_time, unpack=True)
#   new_eq_sim = np.loadtxt(input_dir+file_final_new_event_mag, unpack=True)
#   print 'New event detections, verified visually: ', len(new_eq_time)

   # Post-processing: Remove narrowband correlated noise from matching detections
   out_match_eq_file = input_dir+'postproc_match_eq_detections.txt'
   out_match_noise_file = input_dir+'postproc_match_noise_detections.txt'
   match_eq_time, match_eq_sim, match_noise_time, match_noise_sim = separate_corr_noise_from_eq(match_time,
	 match_mag, window_length, allch, out_match_eq_file, out_match_noise_file)
#   [match_eq_time, match_eq_sim] = np.loadtxt(input_dir+file_final_match, unpack=True)
#   print 'Matching event detections, verified visually: ', len(match_eq_time)

   # Post-processing: Remove narrowband correlated noise from missed detections
   out_missed_eq_file = input_dir+'postproc_missed_eq_detections.txt'
   out_missed_noise_file = input_dir+'postproc_missed_noise_detections.txt'
   missed_eq_time, missed_eq_sim, missed_noise_time, missed_noise_sim = separate_corr_noise_from_eq(missed_time,
	 missed_mag, window_length, allch, out_missed_eq_file, out_missed_noise_file)
#   [missed_eq_time, missed_eq_sim] = np.loadtxt(input_dir+file_final_missed, unpack=True)
#   print 'Missed event detections, verified visually: ', len(missed_eq_time)

   # Output waveforms one by one
   output_waveforms_to_file(allch, out_wv_dir, 'new_eq', ref_time, new_eq_time, new_eq_sim, window_length)
   output_waveforms_to_file(allch, out_wv_dir, 'new_noise', ref_time, new_noise_time, new_noise_sim, window_length)
   output_waveforms_to_file(allch, out_wv_dir, 'match_eq', ref_time, match_eq_time, match_eq_sim, window_length)
   output_waveforms_to_file(allch, out_wv_dir, 'match_noise', ref_time, match_noise_time, match_noise_sim, window_length)
   output_waveforms_to_file(allch, out_wv_dir, 'missed_eq', ref_time, missed_eq_time, missed_eq_sim, window_length)
   output_waveforms_to_file(allch, out_wv_dir, 'missed_noise', ref_time, missed_noise_time, missed_noise_sim, window_length)
   #output_waveforms_to_file(allch, out_wv_dir, 'new', ref_time, new_time, new_mag, window_length)
   #output_waveforms_to_file(allch, out_wv_dir, 'match', ref_time, match_time, match_mag, window_length)
   #output_waveforms_to_file(allch, out_wv_dir, 'missed', ref_time, missed_time, missed_mag, window_length)


############################################## INPUTS ##########################################################

# Read detection times and magnitudes from compare_fpss_*.txt files
# Guy, Arkansas: Matching, New, Missed Detections
# For now, run on cees-cluster
#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20101101_3ch_01hr/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.12_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_thresh0.12_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.14_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_thresh0.16_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.15_catalog_timewin3.txt' # final threshold
#file_sac_HHE = '201007_HHE_BP_1_1_01_bp1to20.SAC'
#file_sac_HHN = '201007_HHN_BP_1_1_01_bp1to20.SAC'
#file_sac_HHZ = '201007_HHZ_BP_1_1_01_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_01hr/'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20101101_3ch_24hr/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.15_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.24_catalog_timewin3.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_thresh0.24_catalog_timewin4.txt'
#file_sac_HHE = '201007_HHE_BP_1_1_bp1to20.SAC'
#file_sac_HHN = '201007_HHN_BP_1_1_bp1to20.SAC'
#file_sac_HHZ = '201007_HHZ_BP_1_1_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_24hr/'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1wk/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_thresh0.24_catalog_timewin4.txt'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_thresh0.32_catalog_timewin4.txt'
#file_sac_HHE = '201007_HHE_BP_1_7_bp1to20.SAC'
#file_sac_HHN = '201007_HHN_BP_1_7_bp1to20.SAC'
#file_sac_HHZ = '201007_HHZ_BP_1_7_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1wk/'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_2wk/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes4_thresh0.24_catalog_timewin4.txt'
#file_sac_HHE = '201007_HHE_BP_1_14_bp1to20.SAC'
#file_sac_HHN = '201007_HHN_BP_1_14_bp1to20.SAC'
#file_sac_HHZ = '201007_HHZ_BP_1_14_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_2wk/'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_thresh0.32_catalog_timewin4.txt'
#file_sac_HHE = '201007_HHE_BP_1_30_bp1to20.SAC'
#file_sac_HHN = '201007_HHN_BP_1_30_bp1to20.SAC'
#file_sac_HHZ = '201007_HHZ_BP_1_30_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/'
#file_final_new_event_time = 'selected_time.txt'
#file_final_new_event_sim = 'selected_sim.txt'
#file_final_new_event_mag = 'selected_mag_3compA.txt'
#start_date = '2010-07-01'
#end_date = '2010-07-31'

input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/'
input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_thresh0.33_catalog_timewin6.txt'
#file_sac_HHE = '20100601_20100831_HHE_BP_1_30_bp1to20.SAC'
#file_sac_HHN = '20100601_20100831_HHN_BP_1_30_bp1to20.SAC'
#file_sac_HHZ = '20100601_20100831_HHZ_BP_1_30_bp1to20.SAC'
file_sac_HHE = '20100601_20100831_HHE_CustBP_1_30_bp1to20.SAC'
file_sac_HHN = '20100601_20100831_HHN_CustBP_1_30_bp1to20.SAC'
file_sac_HHZ = '20100601_20100831_HHZ_CustBP_1_30_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/'
out_wv_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/waveforms/'
#out_wv_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/test_waveforms/'
#out_wv_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/SP_waveforms/'
#out_wv_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/newSP_waveforms/'
file_final_new_event_time = 'selected_new_eq_times.txt'
file_final_new_event_sim = 'selected_sim.txt'
file_final_new_event_mag = 'selected_new_eq_mag_corrected.txt'
file_final_match = 'selected_match_eq_times_mag.txt'
file_final_missed = 'selected_missed_eq_times_mag.txt'
#file_final_new_event_time = 'SP_new_eq_times.txt'
#file_final_new_event_sim = 'SP_sim.txt'
#file_final_new_event_mag = 'SP_new_eq_mag_corrected.txt'
#file_final_match = 'SP_match_eq_times_mag.txt'
#file_final_missed = 'SP_missed_eq_times_mag.txt'
start_date = '2010-06-01'
end_date = '2010-08-31'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100801_3ch_1month/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_thresh0.16_catalog_timewin4.txt'
#file_sac_HHE = '201008_HHE_BP_1_30_bp1to20.SAC'
#file_sac_HHN = '201008_HHN_BP_1_30_bp1to20.SAC'
#file_sac_HHZ = '201008_HHZ_BP_1_30_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100801_3ch_1month/'

#input_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_1month/'
#input_file = 'compare_fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_thresh0.5_catalog_timewin4.txt'
#file_sac_HHE = '201006_HHE_BP_1_30_bp1to20.SAC'
#file_sac_HHN = '201006_HHN_BP_1_30_bp1to20.SAC'
#file_sac_HHZ = '201006_HHZ_BP_1_30_bp1to20.SAC'
#out_wv_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100601_3ch_1month/'


############################################## MAIN PROGRAM ##########################################################

# Read in matching, new, missed detection times from file
# Along with template matching magnitudes + FAST similarity values for matching detections
[match_map, new_map, missed_map, list_match_magnitude, list_match_fast_sim] = read_match_new_missed_detections_from_file(input_dir, input_file)

# Sort detection times in descending order of magnitude (similarity, for new FAST detections)
[match_time, match_mag] = sort_descending_order(match_map)
[new_time, new_mag] = sort_descending_order(new_map)
[missed_time, missed_mag] = sort_descending_order(missed_map)

# Output plot of all waveforms: matching/new/missed detections
flag_plot_output_waveforms = False
if (flag_plot_output_waveforms):
   plot_output_all_waveforms(file_sac_HHE, file_sac_HHN, file_sac_HHZ, input_dir, out_wv_dir, match_time, match_mag, new_time, new_mag, missed_time, missed_mag)

# Plot template matching magnitude vs. FAST similarity for matching detections 
flag_plot_magnitude_similarity = False
if (flag_plot_magnitude_similarity):
   plot_magnitude_vs_FAST_similarity(input_dir, file_final_new_event_sim, file_final_new_event_mag, start_date, end_date, list_match_fast_sim, list_match_magnitude)

# Plot times for matching, missed, new detections
flag_plot_detection_times = False
if (flag_plot_detection_times):
   plot_mag_vs_detection_time(input_dir, file_final_new_event_time, file_final_new_event_mag, file_final_match, file_final_missed, start_date, end_date)
#   plot_magnitude_vs_detection_time(input_dir, file_final_new_event_time, file_final_new_event_mag, start_date, end_date, match_time, match_mag, missed_time, missed_mag)
