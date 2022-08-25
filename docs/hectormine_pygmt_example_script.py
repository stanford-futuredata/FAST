#!/usr/bin/env python
# coding: utf-8

# # Plotting HYPOINVERSE Output With PyGMT

# In[1]:


import pygmt
import numpy as np
import pandas as pd
import json


# In[3]:


station_names = []
network = []
channels = []

station_lats = []
station_lons = []
elev = []

with open('station_list.json') as infile:
    stations = json.load(infile)
    
    for i in stations:
        station_names.append(i)
    
    for i in station_names:
        network.append(stations[i]['network'])
        channels.append(stations[i]['channels'])
        station_lats.append(stations[i]['coords'][0])
        station_lons.append(stations[i]['coords'][1])
        elev.append(stations[i]['coords'][2])


station_data = {
    'stations': station_names,
    'lat': station_lats,
    'lon': station_lons
}

station_df = pd.DataFrame(station_data)


# In[240]:


num_of_sec = []
lat = []
lon = []
depth = []
mag = []
ev_id = []

with open('events_locations_hectormine.txt', 'r') as f:
    for line in f:
        split_line = line.split()
        num_of_sec.append(split_line[0])
        lat_split = float(split_line[1])
        lat.append(lat_split)
        lon_split = float(split_line[2])
        lon.append(lon_split)
        depth_split = float(split_line[3])
        depth.append(depth_split)
        mag_split = float(split_line[4])
        mag.append(mag_split)
        ev_id.append(split_line[5])

lat_arr = np.array(lat)
lon_arr = np.array(lon)
depth_arr = np.array(depth)
mag_arr = np.array(mag)
        
region = [lon_arr.min() - 1, lon_arr.max() + 1, lat_arr.min() - 1, lat_arr.max() + 1]  


# In[251]:


fig = pygmt.Figure() 


# In[252]:


pygmt.config(MAP_FRAME_TYPE="plain")
pygmt.config(FORMAT_GEO_MAP="ddd.xx")
pygmt.config(FORMAT_GEO_MAP='D');
pygmt.config(FONT_LABEL='10p,Helvetica,black');


# In[253]:


subset_region = [lon_arr.min() - 0.5, lon_arr.max() + 0.5, lat_arr.min() - 0.5, lat_arr.max() + 0.5]

fig.basemap(region=region, projection='M4i', frame=['a', '+t1999 Hector Mine Foreshock Locations'])

fig.coast(land='lightyellow')

pygmt.makecpt(cmap='viridis', series=[depth_arr.min(), depth_arr.max()])

fig.plot(x=lon_arr, 
         y=lat_arr,
         color=depth_arr,
         cmap=True,
         style="c0.3c",  
         pen="black",
         frame='a',)


scale = "f-117.2/33.8/20/50+u+lScale:"


with pygmt.config(FONT_TITLE=10):
    fig.basemap(rose="jTL+w1.3c+lO,E,S,N+o-0.1c/3c", 
                map_scale=scale,) 

fig.plot(x=station_df.lon, 
         y=station_df.lat, 
         style='i0.5c', 
         color='red3', 
         pen='black')

fig.text(x=station_df.lon, y=station_df.lat + 0.07, text=station_df.stations)

fig.colorbar(frame='af+l"Depth (km)"')


with fig.inset(position="jTR+o0.1c", 
               box="+p1.5p,black", 
               region=[-130, -105, 27, 45],
               projection='M1.5i'):

    
    fig.coast(region=[-130, -105, 27, 45],
              projection='M1.5i',
              land="lightyellow", 
              water="lightskyblue", 
              borders="a/faint,117/117/117", 
              shorelines="1/0.5p",
              )
    
    rectangle = [[subset_region[0], subset_region[2], subset_region[1], subset_region[3]]]
    fig.plot(data=rectangle, style="r+s", pen="0.8p,red")
    

             
fig.show()

