import os
import json
from obspy import UTCDateTime
from obspy.clients.fdsn.client import Client

# eqt_get_station_list.py: script to get list of stations to download data

# Copied from https://github.com/smousavi05/EQTransformer/blob/master/EQTransformer/utils/downloader.py
def makeStationList(json_path,client_list, min_lat, max_lat, min_lon, max_lon, start_time, end_time, channel_list=[], filter_network=[], filter_station=[],**kwargs):


     """
    
    Uses fdsn to find available stations in a specific geographical location and time period.  

    Parameters
    ----------
    json_path: str
        Path of the json file that will be returned

    client_list: list
        List of client names e.g. ["IRIS", "SCEDC", "USGGS"].
                                
    min_lat: float
        Min latitude of the region.
        
    max_lat: float
        Max latitude of the region.
        
    min_lon: float
        Min longitude of the region.
        
    max_lon: float
        Max longitude of the region.
        
    start_time: str
        Start DateTime for the beginning of the period in "YYYY-MM-DDThh:mm:ss.f" format.
        
    end_time: str
        End DateTime for the beginning of the period in "YYYY-MM-DDThh:mm:ss.f" format.
        
    channel_list: str, default=[]
        A list containing the desired channel codes. Downloads will be limited to these channels based on priority. Defaults to [] --> all channels
        
    filter_network: str, default=[]
        A list containing the network codes that need to be avoided. 
        
    filter_station: str, default=[]
        A list containing the station names that need to be avoided.

    kwargs: 
        special symbol for passing Client.get_stations arguments

    Returns
    ----------
    stations_list.json: A dictionary containing information for the available stations.      
        
     """  
 
     station_list = {}
     for cl in client_list:
         inventory = Client(cl).get_stations(minlatitude=min_lat,
                                     maxlatitude=max_lat, 
                                     minlongitude=min_lon, 
                                     maxlongitude=max_lon, 
                                     starttime=UTCDateTime(start_time), 
                                     endtime=UTCDateTime(end_time), 
                                     level='channel',**kwargs)    

         for ev in inventory:
             net = ev.code
             if net not in filter_network:
                 for st in ev:
                     station = st.code
                     print(str(net)+"--"+str(station))
    
                     if station not in filter_station:

                         elv = st.elevation
                         lat = st.latitude
                         lon = st.longitude
                         new_chan = [ch.code for ch in st.channels]
                         if len(channel_list) > 0:
                             chan_priority=[ch[:2] for ch in channel_list]
        
                             for chnn in chan_priority:
                                 if chnn in [ch[:2] for ch in new_chan]:
                                     new_chan = [ch for ch in new_chan if ch[:2] == chnn]                     
    # =============================================================================
    #                      if ("BHZ" in new_chan) and ("HHZ" in new_chan):
    #                          new_chan = [ch for ch in new_chan if ch[:2] != "BH"]
    #                      if ("HHZ" in new_chan) and ("HNZ" in new_chan):
    #                          new_chan = [ch for ch in new_chan if ch[:2] != "HH"]
    #                          
    #                          if len(new_chan)>3 and len(new_chan)%3 != 0:
    #                              chan_type = [ch for ch in new_chan if ch[2] == 'Z']
    #                              chan_groups = []
    #                              for i, cht in enumerate(chan_type):
    #                                  chan_groups.append([ch for ch in new_chan if ch[:2] == cht[:2]])
    #                              new_chan2 = []
    #                              for chg in chan_groups:
    #                                  if len(chg) == 3:
    #                                      new_chan2.append(chg)
    #                              new_chan = new_chan2 
    # ============================================================================= 
                        
                         if len(new_chan) > 0 and (station not in station_list):
                             station_list[str(station)] ={"network": net,
                                                      "channels": list(set(new_chan)),
                                                      "coords": [lat, lon, elv]
                                                      }
     json_dir = os.path.dirname(json_path)
     if not os.path.exists(json_dir):
         os.makedirs(json_dir)
     with open(json_path, 'w') as fp:
         json.dump(station_list, fp)
         
         

#--------------------------START OF INPUTS------------------------
### Calipatria data
clientlist=["SCEDC","IRIS"]
minlat=32.7
maxlat=33.7
minlon=-116.1
maxlon=-115.1

# Download these channels, not ALL channels
chan_priority_list=["HH[ZNE12]", "BH[ZNE12]", "EH[ZNE12]", "HN[ZNE12]"]

### Time duration should be for entire time period of interest

tstart="2021-06-05 00:00:00"
tend="2021-06-06 00:00:00"
out_station_dir = '../../../Calipatria/stations/'
if not os.path.exists(out_station_dir):
    os.makedirs(out_station_dir)
out_station_json_file = out_station_dir+'station_list.json'

#--------------------------END OF INPUTS------------------------

# Get list of stations
makeStationList(json_path=out_station_json_file, client_list=clientlist,
   min_lat=minlat, max_lat=maxlat, min_lon=minlon, max_lon=maxlon,
   start_time=tstart, end_time=tend, 
   channel_list=chan_priority_list,
#   channel_list=[], # don't use this, since it gets ALL channels
   filter_network=["SY"], filter_station=[])
