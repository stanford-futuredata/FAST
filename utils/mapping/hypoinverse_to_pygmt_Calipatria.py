import pygmt
import numpy as np
import pandas as pd
import json
import os

in_sta_dir = '../../data/20210605_Calipatria_Data/stations/'
in_loc_dir = '../../data/20210605_Calipatria_Data/location_hypoinverse/'
out_map_dir = '../../data/20210605_Calipatria_Data/mapping_pygmt/'
if not os.path.exists(out_map_dir):
    os.makedirs(out_map_dir)

station_names = []
network = []
channels = []

station_lats = []
station_lons = []
elev = []

#with open('station_list_SCEDC.json') as infile:
with open(in_sta_dir+'station_list_clean.json') as infile:
    stations = json.load(infile)
    
    for i in stations:
        station_names.append(i)
    
    for i in station_names:
        network.append(stations[i]['network'])
        channels.append(stations[i]['channels'])
        station_lats.append(stations[i]['coords'][0])
        station_lons.append(stations[i]['coords'][1])
        elev.append(stations[i]['coords'][2])
#        station_lats.append(stations[i]["latitude"])
#        station_lons.append(stations[i]["longitude"])

station_data = {
    'stations': station_names,
    'lat': station_lats,
    'lon': station_lons
}

station_df = pd.DataFrame(station_data)

# other earthquakes
mag = []
lat = []
lon = []
depth = []


# SCEDC Catalog
#with open("Desktop/SearchResults.txt", "r") as r:
with open(out_map_dir+"scedc_20210605_24hr_events_alltypes.txt", "r") as r:
    for line in r:
        split_line = line.split()
        mag.append(float(split_line[4]))
        lat.append(float(split_line[6]))
        lon.append(float(split_line[7]))
        depth.append(float(split_line[8]))
        
## FAST-SeisBench-HYPOINVERSE Catalog
#with open(in_loc_dir+"events_locations.txt", "r") as r:
#    for line in r:
#        split_line = line.split()
#        mag.append(2.0)
#        lat.append(float(split_line[1]))
#        lon.append(float(split_line[2]))
#        depth.append(float(split_line[3]))
        


lat_arr = np.array(lat)
lon_arr = np.array(lon)
depth_arr = np.array(depth)
mag_arr = np.array(mag)

#grid = '@earth_relief_30s'
grid = '@earth_relief_03s'

mapcpt = 'map_gray.cpt'

fig = pygmt.Figure()

region = [-116.5, -115, 32.5, 34]

pygmt.config(MAP_FRAME_TYPE="plain")
pygmt.config(FORMAT_GEO_MAP="ddd.xx")
pygmt.config(FORMAT_GEO_MAP='D');
pygmt.config(FONT_LABEL='10p,Helvetica,black');

mapcpt = 'map_gray.cpt'

insarcpt = 'insar_cpt.cpt'
pygmt.makecpt(cmap='cyclic', series=[-3.14, 3.14], output=insarcpt)

fig.basemap(region=region, projection='M4i', frame=['a', '+tM 5.3 - 11km W of Calipatria, CA'])

fig.grdimage(
    grid=grid,
    cmap=mapcpt,
    region=region,
    projection='M4i',
    shading=True,
    frame=True
    )

#fig.grdcontour(
#    grid=grid,
#    interval=4000,
#    annotation="4000+f6p",
#    limit="-8000/0",
#    pen="a0.15p"
#    )

fig.coast(water='lightskyblue')


#pygmt.makecpt(cmap='viridis', series=[depth_arr.min(), depth_arr.max()], reverse=True)
pygmt.makecpt(cmap='viridis', series=[0, 20], reverse=True)

rectangle = [[-115.8, 33, -115.4, 33.3]]
fig.plot(data=rectangle, style="r+s", pen="1p,black")

# Plot earthquakes
fig.plot(x=lon_arr, 
         y=lat_arr,
         color=depth_arr,
         cmap=True,
#         style="c0.3c",  
         style="c",  
         pen="black",
         frame='a',
         transparency=0,
         size=0.06 * mag_arr)
#         size=0.02 * (3**mag_arr))

scale = "f-116.2/32.6/20/50+u+lScale:"

with pygmt.config(FONT_TITLE=10):
    fig.basemap(rose="jTL+w1.3c+lO,E,S,N+o-0.1c/3c", 
        map_scale=scale,) 

fig.plot(x=station_df.lon, 
         y=station_df.lat,
         label='Stations',
         style='i0.3c', 
         color='red3', 
         pen='black')

fig.text(x=station_df.lon, y=station_df.lat + 0.028, text=station_df.stations, font='6p')

fig.plot(x=-115.635, y=33.140, style='a0.6c', color='yellow', pen='red3')

fig.colorbar(frame='af+l"Depth (km)"')

# with fig.inset(position="jTL+o0.11c", 
#                box="+p1.5p,black", 
#                region=[-128, -110, 30, 45],
#                projection='M1.5i'):
    
#     fig.coast(region=[-128, -110, 30, 45],
#               projection='M1.5i',
#               land="lightgray", 
#               water="lightskyblue", 
#               borders="a/faint,117/117/117", 
#               shorelines="1/0.5p",

#               )
    
#     rectangle = [-116.5, -115, 32.5, 34]
#     fig.plot(data=rectangle, style="r+s", pen="01p,red")



fig.legend(region=region, 
           projection="M4i", 
           spec='legend_file1.txt', 
           position="jTR+o0.1c",
           box="+gantiquewhite+pthick,black")

#fig.show()
fig.savefig(out_map_dir+'pygmt_Calipatria_map_stations.png')


# ----- Zoomed in map -------
fig = pygmt.Figure()

pygmt.config(MAP_FRAME_TYPE="plain")
pygmt.config(FORMAT_GEO_MAP="ddd.xx")
pygmt.config(FORMAT_GEO_MAP='D');
pygmt.config(FONT_LABEL='10p,Helvetica,black');

region = [-115.8, -115.4, 33.0, 33.3]

mapcpt = 'map_gray.cpt'

fig.basemap(region=region, projection='M4i', frame=['x0.1f', 'y0.1f', '+t2021 Calipatria Swarm'])

# Topography
fig.grdimage(
    grid=grid,
    cmap=mapcpt,
    region=region,
    projection='M4i',
    shading=True
#    frame=True
    )

# Insar
fig.grdimage(
    grid='../../data/20210605_Calipatria_Data/insar/Asc_20210531_20210612/geo_phase.grd',
    cmap=insarcpt,
    region=region,
    projection='M4i',
    transparency=20,
    shading=False
#    frame=True
    )
fig.colorbar(position="JMR+o0.5c/0c+w8c", frame='a1f1+l"Wrapped Phase (rad)"')

fig.grdcontour(
    grid=grid,
    interval=4000,
    annotation="4000+f6p",
    limit="-8000/0",
    pen="a0.15p"
    )

fig.coast(water='lightskyblue')


#pygmt.makecpt(cmap='viridis', series=[depth_arr.min(), depth_arr.max()], reverse=True)
pygmt.makecpt(cmap='viridis', series=[0, 20], reverse=True)

# Plot earthquakes
fig.plot(x=lon_arr, 
         y=lat_arr,
         color=depth_arr,
         cmap=True,
#         style="c0.3c",  
         style="c",  
         pen="black",
#         frame=['x0.1f', 'y0.1f'],
         transparency=50,
         size=0.06 * mag_arr)
#         size=0.02 * (3**mag_arr))

scale = "f-115.7/33.05/20/10+u+lScale:"

with pygmt.config(FONT_TITLE=10):
     fig.basemap(rose="jTL+w1.3c+lO,E,S,N+o-0.1c/3c", 
         map_scale=scale,) 

fig.plot(x=station_df.lon, 
          y=station_df.lat,
          label='Stations',
          style='i0.5c', 
          color='red3', 
          pen='black')

fig.text(x=station_df.lon, y=station_df.lat + 0.01, text=station_df.stations, font='8p')

fig.plot(x=-115.635, y=33.140, style='a0.6c', color='yellow', pen='red3')

fig.colorbar(frame='af+l"Depth (km)"')

fig.legend(region=region, 
           projection="M4i", 
           spec='legend_file1.txt', 
           position="jMR+o0.1c",
           box="+gantiquewhite+pthick,black")

#fig.show()
fig.savefig(out_map_dir+'pygmt_Calipatria_map_earthquakes.png')
