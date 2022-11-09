import datetime
from obspy import UTCDateTime
import json
import os
# Convert REAL phase output file to HYPOINVERSE phase input file

# from EQTransformer/utils/associator.py
def _weighcalculator_prob(pr):
    'calculate the picks weights'
    weight = 4
    if pr > 0.6:
        weight = 0
    elif pr <= 0.6 and pr > 0.5:
        weight = 1
    elif pr <= 0.5 and pr > 0.2:
        weight = 2
    elif pr <= 0.2 and pr > 0.1:
        weight = 3  
    elif pr <= 0.1:
        weight = 4 
    return weight


# Inputs - Hector Mine
base_dir = '../../data/'
start_lat = 34.603
start_lon = -116.265
start_depth = 5

## Inputs - Calipatria
#base_dir = '../../data/20210605_Calipatria_Data/'
#start_lat = 33.1
#start_lon = -115.6
#start_depth = 5


# make directory for hypoinverse data files
loc_dir = base_dir+'location_hypoinverse/'
if not os.path.exists(loc_dir):
    os.makedirs(loc_dir)

# copy files needed for hypoinverse to the new data file directory
os.system('cp hadley.crh locate_events.hyp '+loc_dir)

in_real_phase_file = base_dir+'seisbench_picks/event_picks.json'
out_hinv_phase_file = loc_dir+'hinv_phase_file.txt' # Change file name


fout = open(out_hinv_phase_file, 'w')
with open(in_real_phase_file, 'r') as freal:
   
   json_data = json.load(freal)
   
   for i in json_data['SeisBench_Picks']:
      
      ev_id = i
      
      count_phases = 0
      
      if json_data['SeisBench_Picks'][ev_id]['P_Origin_Time'] != ' ':
         json_origin_time = json_data['SeisBench_Picks'][ev_id]['P_Origin_Time']
         year = int(json_origin_time[0:4])
         month = int(json_origin_time[5:7])
         day = int(json_origin_time[8:10])
         hour = int(json_origin_time[11:13])
         minute = int(json_origin_time[14:16])
         
         origin_time_nosec = datetime.datetime(year, month, day, hour, minute)
         origin_delta = datetime.timedelta(seconds=float(json_origin_time[17:26]))
         
         origin_time = origin_time_nosec + origin_delta
         origin_time_second = round(100*(origin_time.second + 1e-6*origin_time.microsecond))
         
         lat = start_lat
         lat_int = int(float(lat))
         dlat = abs(float(lat) - float(lat_int))
         lat_min = str(format(round(100*float(dlat*60.0)), '04d'))
         if (lat_int < 0):
            lat_char = 'S'
         else:
            lat_char = ' '
         lat_int = abs(lat_int)
         
         lon = start_lon
         lon_int = int(float(lon))
         dlon = abs(float(lon) - float(lon_int))
         lon_min = str(format(round(100*float(dlon*60.0)), '04d'))
         if (lon_int < 0):
            lon_char = 'W'
         else:
            lon_char = 'E'
         lon_int = abs(lon_int)
            
         depth = start_depth
         depth_out = round(100*float(depth))
         
         fout.write(('%4d%02d%02d%02d%02d%04d%2d%1s%4s%3d%1s%4s%5d%3d\n') % (origin_time.year, origin_time.month, origin_time.day, origin_time.hour, origin_time.minute, origin_time_second, lat_int, lat_char, lat_min, lon_int, lon_char, lon_min, depth_out, 0))
         
         for j in json_data['SeisBench_Picks'][ev_id]:
               if j != 'P_Origin_Time':
                  #  print(i)

                  if len(json_data['SeisBench_Picks'][ev_id][j]) > 0:
                     for k in range(len(json_data['SeisBench_Picks'][ev_id][j])):

                           trace_id = j.split('.')
                           
                           net = trace_id[0].strip()
                           sta = trace_id[1].strip()
                           ph = json_data['SeisBench_Picks'][ev_id][j][k]['phase']
                           tt = UTCDateTime(json_data['SeisBench_Picks'][ev_id][j][k]['peak_time']) - UTCDateTime(origin_time)
                           delta = datetime.timedelta(seconds=tt)
                           arr_time = origin_time + delta
                           res = 0.05
                           weight = float(json_data['SeisBench_Picks'][ev_id][j][k]['peak_value'])
                           
                           if (ph == 'P'):
                                 chan = 'HHZ'
                                 p_remark = 'IP'
                                 s_remark = '  '
                                 p_res = str(format(round(100*res), '4d'))
                                 s_res = '    '
                                 p_weight = _weighcalculator_prob(weight) 
                                 s_weight = 0
                                 p_arr_time_sec = round(100*(arr_time.second + 1e-6*arr_time.microsecond))
                                 s_arr_time_sec = 0.00
                           else: # ph == 'S'
                              chan = 'HHE'
                              p_remark = '  '
                              s_remark = 'ES'
                              p_res = '    '
                              s_res = str(format(round(100*res), '4d'))
                              p_weight = 0
                              s_weight = _weighcalculator_prob(weight) 
                              p_arr_time_sec = 0.00
                              s_arr_time_sec = round(100*(arr_time.second + 1e-6*arr_time.microsecond))
                              
                           fout.write(('%-5s%-2s  %3s %2s %1d%4d%02d%02d%02d%02d%5d%4s   %5d%2s %1d%4s\n') % (sta, net, chan, p_remark, p_weight, arr_time.year, arr_time.month, arr_time.day, arr_time.hour, arr_time.minute, p_arr_time_sec, p_res, s_arr_time_sec, s_remark, s_weight, s_res))
                           
                           count_phases += 1
                           
         if count_phases > 0:
            fout.write("{:<62}".format(' ')+"%10s"%(ev_id)+'\n')
            
fout.close()



