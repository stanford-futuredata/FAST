import json
from os import listdir
from os.path import isfile, join

station_dir = '../../../Calipatria/stations/'
in_station_file = station_dir+'station_list.json'
out_station_file = station_dir+'station_list_clean.json'

stations_ = json.load(open(in_station_file))

onlyfiles = [f for f in listdir(station_dir) if (isfile(join(station_dir, f)) and ('.xml' in f))]
print(onlyfiles)

clean_stations = {}
for file in onlyfiles:
   station_parts = file.split('.')
   sta = station_parts[1]
   if (sta in stations_):
      clean_stations[sta] = stations_[sta]

with open(out_station_file, 'w') as fout:
   json.dump(clean_stations, fout)
