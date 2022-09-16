from obspy import UTCDateTime
import utils_hypoinverse as utils_hyp

# Read HYPOINVERSE summary output file
# Output file for plotting on GMT map


in_hinv_sum_file = 'locate_events.sum'
catalog_start_time = UTCDateTime('1999-10-15T00:00:00')
output_plot_file = 'events_locations.txt'

#-----------------------------------


fout = open(output_plot_file, 'w')
with open(in_hinv_sum_file, 'r') as fin:
   for line in fin:
      origin_time = utils_hyp.get_origin_time_hypoinverse_file(line)
      num_sec = origin_time - catalog_start_time

      [lat_deg, lon_deg, depth_km] = utils_hyp.get_lat_lon_depth_hypoinverse_file(line)
      evid = utils_hyp.get_event_id_hypoinverse_file(line)
      mag = 0.01*float(line[147:150])

      fout.write(("%f %f %f %f %f %s\n") % (num_sec, lat_deg, lon_deg, depth_km, mag, evid))
      print(line)
fout.close()

