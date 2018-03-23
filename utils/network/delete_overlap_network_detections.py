import numpy as np

input_dir = '../data/network_detection/'
allfile_name = input_dir+'uniquestart_sorted_no_duplicates.txt'
outfile_name = input_dir+'7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt'

# Read all event lines into dictionary with start index as key
# Later, we will delete overlapping events from this dictionary
event_dict = {}
with open(allfile_name, 'r') as fin:
   for line in fin:
      evline = line.split()
      key = int(evline[0]) # key is start index
      val = []
      for vv in evline[1:]:
	 val.append(int(vv)) # val: end_index, dL, nevents, nsta, tot_ndets, max_ndets, tot_vol, max_vol, peaksum
      event_dict[key] = val
print "Initial number of event lines:", len(event_dict)

# Traverse events in dictionary in order of start time
keylist = sorted(event_dict.keys())
ik = 0
while (ik < len(keylist)):
   vv = event_dict[keylist[ik]]
   tmp_dict = {}
   tmp_dict[keylist[ik]] = vv

   # If start time of next event is before or at end time of current event, or for all events in the tmp_dict: add to temp dictionary since it overlaps
   ii = 1
   end_time = vv[0]
   if (ik+ii) < len(keylist):
      while(keylist[ik+ii] <= end_time):
	 tmp_dict[keylist[ik+ii]] = event_dict[keylist[ik+ii]]
	 end_time = max(end_time, event_dict[keylist[ik+ii]][0])
	 print ik, ii, ik+ii, keylist[ik+ii], end_time
	 ii += 1
	 if ((ik+ii) >= len(keylist)):
	    break

   # Events with overlap have more than 1 event in temp dictionary
   # Keep the event with highest peaksum; remove all other overlap events in temp dictionary from the event_dict
   if (len(tmp_dict) > 1):
      tmp_eventlist = sorted(tmp_dict.iteritems(), key=lambda(k,v): v[8], reverse=True) # sort by descending order of peaksum
      keep_event = tmp_eventlist[0]
      orig_end_time = keep_event[1][0]
      event_dict[keep_event[0]][0] = end_time # Replace with latest end time over all overlapping events
      print "Event with maximum peaksum: start time:", keep_event[0], ", end time:", event_dict[keep_event[0]][0], ", peaksum:", event_dict[keep_event[0]][8], ", original end time:", orig_end_time
      for iev in tmp_eventlist[1:]:
         print "    Removing overlap event, start time:", iev[0], ", end time:", iev[1][0], ", peaksum:", iev[1][8]
         event_dict.pop(iev[0])
      print "Current number of event lines:", len(event_dict)

   ik += ii
print "Final number of event lines:", len(event_dict)

# Output event list (without overlap events) to file
out_key_list = sorted(event_dict.keys())
with open(outfile_name, 'w') as fout:
   for kkey in out_key_list:
      value = event_dict[kkey]
      fout.write(('%12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12d\n') % (kkey, value[0], value[1], value[2], value[3], value[4], value[5], value[6], value[7], value[8], value[9], value[10]))
#      fout.write(('%12d %12d %12d %12d %12d %12d %12d %12d %12d %12d %12d\n') % (kkey, value[0], value[1], value[2], value[3], value[4], value[5], value[6], value[7], value[8], value[9]))
#      fout.write(('%12d %12d %12d %12d %12d %12d %12d %12d %12d %12d\n') % (kkey, value[0], value[1], value[2], value[3], value[4], value[5], value[6], value[7], value[8]))


#all_times = np.loadtxt(allfile_name, usecols=(0,), dtype=np.int)
#diff_all_times = all_times[1:] - all_times[0:-1]
#print "Number of events including duplicates: ", len(all_times)
#
#all_keep_times = []
#all_keep_times.append(all_times[0])
#for iev in range(len(diff_all_times)):
#   if (diff_all_times[iev] >= offset):
#      all_keep_times.append(all_times[iev+1])
#print "Number of events kept, all times: ", len(all_keep_times)
#
#np.savetxt(outfile_name, np.transpose(all_keep_times), fmt='%d')

