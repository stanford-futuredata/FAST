from obspy import UTCDateTime
from obspy import Stream
from obspy import read
from obspy.clients.fdsn import Client
import os
import json

#t = UTCDateTime(2021, 6, 5, 10, 55, 58) # largest event time

start_time = UTCDateTime("2021-06-05 00:00:00")
end_time = UTCDateTime("2021-06-06 00:00:00")
start_time_file = (f"{start_time.year}{str(start_time.month).zfill(2)}{str(start_time.day).zfill(2)}T{str(start_time.hour).zfill(2)}{str(start_time.minute).zfill(2)}{str(start_time.second).zfill(2)}Z")
end_time_file = (f"{end_time.year}{str(end_time.month).zfill(2)}{str(end_time.day).zfill(2)}T{str(end_time.hour).zfill(2)}{str(end_time.minute).zfill(2)}{str(end_time.second).zfill(2)}Z")
#lon = -115.635
#lat = 33.140
#depth = 5.8

#chan_priority_list=["HH[ZNE12]", "BH[ZNE12]", "EH[ZNE12]", "HN[ZNE12]"]
chan_priority_list=["HHZ", "HHN", "HHE", "HH1", "HH2",
                    "BHZ", "BHN", "BHE", "BH1", "BH2",
                    "EHZ", "EHN", "EHE", "EH1", "EH2",
                    "HNZ", "HNN", "HNE", "HN1", "HN2"]

#client1 = Client("IRIS")
#client2 = Client("SCEDC")

clientlist=["SCEDC","IRIS"]
minlat=32.7
maxlat=33.7
minlon=-116.1
maxlon=-115.1

base_dir = '../../../data/20210605_Calipatria_Data/'

for cli in clientlist:
    print('-----------------------------------------------------------------')
    print('Current client: ', cli)
    curr_client = Client(cli)

    client_inventory = curr_client.get_stations(
        starttime=start_time, endtime=end_time,
        minlatitude=minlat, maxlatitude=maxlat,
        minlongitude=minlon, maxlongitude=maxlon)
#        longitude=lon, latitude=lat, maxradius=0.5)
    client_contents = client_inventory.get_contents()
    print(client_inventory)

    out_dir = base_dir+'waveforms_'+cli
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

    out_station_json_file=base_dir+'station_list_'+cli+'.json'
    station_list = {}

    for ev in client_inventory:
        for st in ev:
            station_list[st.code] = {"latitude": st.latitude, "longitude": st.longitude}
                    
            with open(out_station_json_file, 'w') as fp:
                json.dump(station_list, fp)

    wave_form = ''

    for i in client_contents["stations"]:
        curr = i.split()

        network = curr[0].split('.')[0]
        station = curr[0].split('.')[1]
#        if (True):
#        if ((network == 'CE')):
#        if ((network == 'NP')):
#        if ((network == 'PB')):
#        if ((network == 'SB')):
#        if ((network == 'PB') and (station == 'DHL2')):
#        if ((network == 'SB') and (station == 'WLA02')):
#        if ((network == 'CI') and (station == 'WI2')):
                
        try:
            wave_form = client2.get_waveforms(network, station, "*", "*", start_time, end_time)
            for s in wave_form:
                if s.stats.channel in chan_priority_list:
                    s.write(f"{out_dir}/{s.stats.network}.{s.stats.station}.{s.stats.channel}__{start_time_file}__{end_time_file}.mseed", format="MSEED")

        except:
            print(f"No data available for {network}.{station}")

#           for s in wave_form:
#               if s.stats.channel in chan_priority_list:
#                   s.write(f"{out_dir}/{s.stats.network}.{s.stats.station}.{s.stats.channel}__{start_time_file}__{end_time_file}.mseed", format="MSEED")
