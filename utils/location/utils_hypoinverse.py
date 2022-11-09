from obspy import UTCDateTime

# Utilities to read from hypoinverse file

# Return event origin time in UTCDateTime
def get_origin_time_hypoinverse_file(line):
   year = int(line[0:4])
   month = int(line[4:6])
   day = int(line[6:8])
   hour = int(line[8:10])
   minute = int(line[10:12])
   second = float(line[12:14]) + 0.01*float(line[14:16])
   origin_time = UTCDateTime(year, month, day, hour, minute, second)
#   print(year, month, day, hour, minute, second, origin_time)
   return origin_time


# Return event latitude (deg), longitude (deg), depth (km)
def get_lat_lon_depth_hypoinverse_file(line):
   lat = float(line[16:18])
   lat_dir = line[18]
   dlat_min = 0.01*float(line[19:23])
   lat_deg = lat + dlat_min/60.
   if (lat_dir == 'S'):
      lat_deg *= -1.0

   lon = float(line[23:26])
   lon_dir = line[26]
   dlon_min = 0.01*float(line[27:31])
   lon_deg = lon + dlon_min/60.
   if (lon_dir == 'W'):
      lon_deg *= -1.0

   depth_km = 0.01*float(line[31:36])

#   print(lat, lat_dir, dlat_min, lon, lon_dir, dlon_min)
#   print(lat_deg, lon_deg, depth_km)
   return [lat_deg, lon_deg, depth_km]


# Return event ID as a string
def get_event_id_hypoinverse_file(line):
   evid = line[136:146]
   return evid


# Return phase data for one line (one station/channel)
def get_one_phase_hypoinverse_file(line, ev_id):
   flag_good_phase = True
   sta = line[0:4]
   net = line[5:7]
   chan = line[9:12]

   year = int(line[17:21])
   month = int(line[21:23])
   day = int(line[23:25])
   hour = int(line[25:27])
   minute = int(line[27:29])

   p_str = line[14:15].strip()
   s_str = line[47:48].strip()
   p_wt = int(line[16:17])
   s_wt = int(line[49:50])
#   print(line)
#   print(p_str, p_wt)
#   print(s_str, s_wt)

   if (p_str == 'P'):
      ph_str = 'P'
      ph_time = 0.01*float(line[29:34])
      ph_res = abs(0.01*float(line[34:38]))
      ph_wt = p_wt
   elif (s_str == 'S'):
      ph_str = 'S'
      ph_time = 0.01*float(line[41:46])
      ph_res = abs(0.01*float(line[50:54]))
      ph_wt = s_wt
   else:
      ph_str = 'X'
      ph_time = 0.00
      ph_res = 0.00
      ph_wt = 0
      print("ERROR: phase is neither P nor S")
      flag_good_phase = False
      return [flag_good_phase] # Do not add this bad phase weight to event_dict
###      continue # Do not add this bad phase weight to event_dict

   if (ph_wt == 9):
      num_bad_wt += 1
      print("ERROR BadWEIGHT: phase weight is 9, do not use")
      flag_good_phase = False
      return [flag_good_phase] # Do not add this bad phase weight to event_dict
###      continue # Do not add this bad phase weight to event_dict

   if (ph_time < 0.0): # this shouldn't happen, phases should come after origin time
      ph_time += 60.0
      minute -= 1
      print("TimeERROR: phase time is before origin time", ev_id)
   while (ph_time >= 60.0):
      ph_time -= 60.0
      minute += 1
   if (minute < 0):
      minute += 60
      hour -= 1
   while (minute >= 60):
      minute -= 60
      hour += 1
   if (hour >= 24):
      hour -= 24
      day += 1
   try:
      ph_UTC_time = UTCDateTime(year, month, day, hour, minute, ph_time)
   except Exception:
      print("Bad ph_UTC_time", ev_id, year, month, day, hour, minute, ph_time)
      flag_good_phase = False
      return [flag_good_phase] # Do not add this bad phase weight to event_dict
###      continue
   net_sta = net.strip()+sta.strip()
   return [flag_good_phase, ph_str, net_sta, chan, ph_UTC_time, ph_res]


# Return event and phase data from HYPOINVERSE arc file
#
# Output:
#    event_dict: dictionary, key is event ID as integer
#    event_dict[ev_id]['event'] -> [origin time (UTCDateTime), lat (deg), lon (deg), depth (km)]
#    event_dict[ev_id]['P']['netsta'] -> list ['channel', arrival time (UTCDateTime)]
#    event_dict[ev_id]['S']['netsta'] -> list ['channel', arrival time (UTCDateTime)]
#    ev_id_list: event IDs in order
#
def get_event_phase_data_hypoinverse_file(in_hinv_arc_file):
   event_dict = {}
   ev_id_list = []
   num_bad_wt = 0
   with open(in_hinv_arc_file, 'r') as fin:
      for line in fin:
         # Read in an event
         if ((line[0:2] == '19') or (line[0:2] == '20')):
            origin_time = get_origin_time_hypoinverse_file(line)
            ev_id = int(get_event_id_hypoinverse_file(line))
            [lat_deg, lon_deg, depth_km] = get_lat_lon_depth_hypoinverse_file(line) #CY
            num_ph = int(line[119:122])
            count_ph = 0
            ev_id_list.append(ev_id) # store in order
            event_dict[ev_id] = {}
            event_dict[ev_id]['event'] = [origin_time, lat_deg, lon_deg, depth_km] #CY
            event_dict[ev_id]['P'] = {}
            event_dict[ev_id]['S'] = {}
#            print(line)

         # Read line marking end of an event
         elif ((line[0:2]) == '  '):
            ev_id_end = int(line[62:72])
            if (ev_id != ev_id_end):
               print("WARNING: event ID does not match: ", ev_id, ev_id_end)
            if (count_ph != num_ph):
               print("WARNING: number of phases for this event does not match: ", ev_id, ev_id_end, count_ph, num_ph)

         # Read phase for this event
         else:
            [flag_good_phase, ph_str, net_sta, chan, ph_UTC_time, ph_res] = get_one_phase_hypoinverse_file(line, ev_id)
            if (flag_good_phase):
               event_dict[ev_id][ph_str][net_sta] = [chan, ph_UTC_time, ph_res]
               count_ph += 1

#            print(year, month, day, hour, minute, ph_time, ph_str, ph_UTC_time, ph_wt)

   #         phase_str = sta.strip()+net.strip()+chan.strip()+p_str.strip()+s_str.strip()
   #         event_dict[ev_id]['phases'].append((phase_str, line))
   print("Number of events from HYPOINVERSE arc file: ", len(event_dict), len(ev_id_list))
   print("Number of bad phase weights: ", num_bad_wt)
   return [event_dict, ev_id_list]
