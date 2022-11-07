import json
import math

# Output station file
#  HYPOINVERSE input format
def output_station_file_hypoinverse(in_sta_file, out_hypoinv_file):
   json_file = open(in_sta_file)
   stations_ = json.load(json_file)

   max_amp_period = 0.2 # default
   end_str = '     0.00  0.00  0.00  0.00 3  0.00--'
   with open(out_hypoinv_file,'w') as fout:
      for sta,val in stations_.items():
         lat = val['coords'][0]
         lon = val['coords'][1]
         elev = val['coords'][2]
#         print(sta,val)
#         print(val['network'])
#         print(lat,lon,elev)
         dlat = abs(lat) - math.floor(abs(lat))
         dlon = abs(lon) - math.floor(abs(lon))
         min_dlat = 60.*dlat
         min_dlon = 60.*dlon
#         print(dlat,dlon,elev)
#         print(min_dlat, min_dlon, elev)

         if (lat > 0):
            char_lat = ' '
         else:
            char_lat = 'S'

         if (lon < 0):
            char_lon = ' '
            lon *= -1.0  # West is positive
         else:
            char_lon = 'E'

         for chan in val['channels']:
            if (chan[2] == '2' or chan[2] == 'N'):
               end_chan = 'HHN'
            elif (chan[2] == '1' or chan[2] == 'E'):
               end_chan = 'HHE'
            else:
               end_chan = 'HHZ'

            fout.write("%-5s %2s  %2s  %2d %7.4f%s%3d %7.4f%s%4d%3.1f%s%s\n" % (sta, val['network'], chan, lat, min_dlat, char_lat, lon, min_dlon, char_lon, round(elev), max_amp_period, end_str, end_chan)) 
#            print(chan)


# Output station file
#  GMT format for plots
def output_station_file_gmt(in_sta_file, out_gmt_file, flag_format=0):
   json_file = open(in_sta_file)
   stations_ = json.load(json_file)

   with open(out_gmt_file,'w') as fout:
      for sta,val in stations_.items():
         lat = val['coords'][0]
         lon = val['coords'][1]
         elev = val['coords'][2]
#         print(sta,val)
#         print(val['network'])
#         print(lat,lon,elev)

         if (flag_format == 0): # PhaseLink format for stations
            fout.write("%s %s %7.4f %7.4f %7.4f\n" % (val['network'], sta, lat, lon, elev))
         elif (flag_format == 1): # GMT format for stations
            fout.write("%s.%s %7.4f %7.4f %7.4f\n" % (val['network'], sta, lat, lon, elev))
         else: # GrowClust format for stations (no network)
            fout.write("%s %7.4f %7.4f %7.4f\n" % (sta, lat, lon, elev))


## Output station file
##  HypoSVI format for location
#def output_station_file_hyposvi(in_sta_file, out_hyposvi_file):
#   json_file = open(in_sta_file)
#   stations_ = json.load(json_file)
#
#   with open(out_hyposvi_file,'w') as fout:
#      fout.write("Network Station Y X Z\n")
#      for sta,val in stations_.items():
#         lat = val['coords'][0]
#         lon = val['coords'][1]
#         elev = -0.001*val['coords'][2] # km, positive into the earth downward
##         print(sta,val)
##         print(val['network'])
##         print(lat,lon,elev)
#
#         fout.write("%s %s %7.4f %7.4f %7.4f\n" % (val['network'], sta, lat, lon, elev))
#
#
## Output station file
##  REAL format for association
#def output_station_file_real(in_sta_file, out_real_file):
#   json_file = open(in_sta_file)
#   stations_ = json.load(json_file)
#
#   with open(out_real_file,'w') as fout:
#      for sta,val in stations_.items():
#         lat = val['coords'][0]
#         lon = val['coords'][1]
#         elev = val['coords'][2]*0.001
#         # Note: component does not matter for phase association only
#         fout.write("%7.4f %7.4f %s %s %s %7.4f\n" % (lon, lat, val['network'], sta, val['channels'][0], elev))


def main():

   # Inputs - Hector Mine
   base_dir = '../../data/'

   # Inputs - Calipatria
#   base_dir = '../../data/20210605_Calipatria_Data/'

   in_sta_file = base_dir+'stations/station_list.json'
   out_hypoinv_file = base_dir+'location_hypoinverse/station_list.sta'

   output_station_file_hypoinverse(in_sta_file, out_hypoinv_file)
#   output_station_file_gmt(in_sta_file, out_gmt_file, flag_format=1)

if __name__ == "__main__":
   main()
