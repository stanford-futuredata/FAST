import numpy as np

#det_dir = '/lfs/raiders2/0/ceyoon/TimeSeries/Wenchuan/after/network_detection/Offset60/'
#network_file = '14sta_detlist_rank_by_peaksum.txt'
#det_dir = '/lfs/1/ceyoon/raiders2/TimeSeries/Wenchuan/after/network_detection/'
#det_dir = '/lfs/1/ceyoon/TimeSeries/Wenchuan2/after/network_detection/'
#det_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/network_detection/'


#network_file = '14sta_atleast1_detlist_rank_by_peaksum.txt'
#network_file = '14sta_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt'
#network_file = '14sta_mindets3_dgapL10_inputoffset10_atleast1_detlist_rank_by_peaksum.txt'
###network_file = '14sta_2stathresh_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt'
#network_file = '14sta_3stathresh_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt'
#nsta = 14
#network_file = '15sta_2stathresh_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt'
#nsta = 15
#network_file = 'Filter_4sta_2stathresh_detlist_rank_by_peaksum.txt'
#nsta = 4
#network_file = 'Filter_5sta_3stathresh_detlist_rank_by_peaksum.txt'
#nsta = 5
#network_file = 'Filter_6sta_3stathresh_detlist_rank_by_peaksum.txt'
#nsta = 6
#network_file = '4sta_2stathresh_mindets3_dgapL8_inputoffset10_atleast1_detlist_rank_by_peaksum.txt'
#nsta = 4


#det_dir = '/lfs/1/ceyoon/TimeSeries/AllWenchuan/network_detection/'
##network_file = '15sta_2stathresh_mindets3_dgapL10_inputoffset15_atleast1_detlist_rank_by_peaksum.txt'
#network_file = '15sta_2stathresh_detlist_rank_by_peaksum.txt'
#nsta = 15

det_dir = '../data/network_detection/'
network_file = '7sta_2stathresh_detlist_rank_by_peaksum.txt'
nsta = 7

#det_dir = '/lfs/1/ceyoon/TimeSeries/Diablo/network_detection/'
#network_file = '11sta_2stathresh_mindets3_dgapL10_inputoffset15_detlist_rank_by_peaksum.txt'
#nsta = 11

#det_dir = '/lfs/1/ceyoon/TimeSeries/SaudiMonth/network_detection/'
###network_file = '19sta_2stathresh_mindets3_dgapL10_inputoffset15_detlist_rank_by_peaksum.txt'
#network_file = '19sta_2stathresh_detlist_rank_by_peaksum.txt'
#nsta = 19

#det_dir = '/lfs/1/ceyoon/TimeSeries/OBSTest/network_detection/'
##network_file = '35sta_2stathresh_detlist_rank_by_peaksum.txt'
##nsta = 35
#network_file = '7sta_2stathresh_detlist_rank_by_peaksum.txt'
#nsta = 7

#det_dir = '/lfs/1/ceyoon/TimeSeries/ItalyDay/day303/network_detection/'
#network_file = '22sta_2stathresh_detlist_rank_by_peaksum.txt'
#nsta = 22



out_file = 'NetworkDetectionTimes_'+network_file

# Read in network detections
data = np.genfromtxt(det_dir+network_file, dtype=str, skip_header=1)
#data = np.genfromtxt(det_dir+network_file, dtype=str)
print "Number of network detections: ", len(data)

# Get min and max index (time) for each event over all stations without NaNs
ind_time_min = []
ind_time_max = []
ind_time_diff = []
count_not_nan = []
for iev in range(len(data)):
   cur_event = data[iev]
   ind_event_time = []
   for ista in range(nsta):
      if ('nan' != str.lower(cur_event[ista])):
	 ind_event_time.append(int(cur_event[ista]))
   print 'event:', iev, ', times: ', ind_event_time
   ind_time_min.append(str(min(ind_event_time)))
   ind_time_max.append(str(max(ind_event_time)))
   ind_time_diff.append(str(max(ind_event_time)-min(ind_event_time)))
   count_not_nan.append(str(len(ind_event_time)))

# Output network detections with min index and max index to file
fout = open(det_dir+out_file, 'w')
for iev in range(len(data)):
   fout.write('%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s\n' % (ind_time_min[iev], ind_time_max[iev], data[iev][nsta], data[iev][nsta+1], data[iev][nsta+2], data[iev][nsta+3], data[iev][nsta+4], data[iev][nsta+5], data[iev][nsta+6], data[iev][nsta+7], count_not_nan[iev], ind_time_diff[iev]))
#   fout.write('%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s\n' % (ind_time_min[iev], ind_time_max[iev], data[iev][nsta], data[iev][nsta+1], data[iev][nsta+2], data[iev][nsta+3], data[iev][nsta+4], data[iev][nsta+5], data[iev][nsta+6], data[iev][nsta+7], count_not_nan[iev]))
#   fout.write('%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s\n' % (ind_time_min[iev], ind_time_max[iev], data[iev][nsta], data[iev][nsta+1], data[iev][nsta+2], data[iev][nsta+3], data[iev][nsta+4], data[iev][nsta+5], data[iev][nsta+6], data[iev][nsta+7]))
fout.close()
