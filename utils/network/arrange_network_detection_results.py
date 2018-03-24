import numpy as np

det_dir = '../data/network_detection/'
network_file = '7sta_2stathresh_detlist_rank_by_peaksum.txt'
nsta = 7

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
fout.close()
