from obspy import UTCDateTime
import utils_hypoinverse as utils_hyp

# Read HYPOINVERSE summary output file
# Output file for plotting on GMT map

# Inputs - Hector Mine
catalog_start_time = UTCDateTime('1999-10-15T13:00:00.676000')
loc_dir = '../../data/location_hypoinverse/'

## Inputs - Calipatria
#catalog_start_time = UTCDateTime('2021-06-05T00:00:06.840000')
#loc_dir = '../../data/20210605_Calipatria_Data/location_hypoinverse/'



in_hinv_sum_file = loc_dir+'locate_events.sum'
output_plot_file = loc_dir+'events_locations.txt'

#-----------------------------------


fout = open(output_plot_file, 'w')
with open(in_hinv_sum_file, 'r') as fin:
   for line in fin:
      origin_time = utils_hyp.get_origin_time_hypoinverse_file(line)
      num_sec = origin_time - catalog_start_time
      origin_str = UTCDateTime.strftime(origin_time, "%Y-%m-%dT%H:%M:%S.%f")

      [lat_deg, lon_deg, depth_km] = utils_hyp.get_lat_lon_depth_hypoinverse_file(line)
      evid = utils_hyp.get_event_id_hypoinverse_file(line)
      ev_id = (evid.strip()).zfill(8)
      mag = 0.01*float(line[147:150])

      fout.write(("%f %s %f %f %f %f %s\n") % (num_sec, origin_str, lat_deg, lon_deg, depth_km, mag, ev_id))
      print(line)
fout.close()

