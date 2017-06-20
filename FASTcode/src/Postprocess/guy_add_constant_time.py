import numpy as np
import matplotlib.pyplot as plt

# Read in template matching detection times (s)
text_dir = '../../data/TimeSeries/WHAR/'
det_times_first = np.loadtxt(text_dir+'201006_Time.txt')
print np.shape(det_times_first)
print np.mean(det_times_first)

det_times_second = np.loadtxt(text_dir+'201007_Time.txt')
print np.shape(det_times_second)
det_times_second = det_times_second + 2592000.0
print np.mean(det_times_second)

det_times_third = np.loadtxt(text_dir+'201008_Time.txt')
print np.shape(det_times_third)
det_times_third = det_times_third + 5270400.0
print np.mean(det_times_third)

det_times_out = np.concatenate((det_times_first, det_times_second, det_times_third))
print np.shape(det_times_out)
print max(det_times_out)

np.savetxt(text_dir+'Template_detection_time_201006_201008.txt', det_times_out, fmt='%9.2f')

