import obspy
from obspy.clients.fdsn.mass_downloader import RectangularDomain, \
    Restrictions, MassDownloader

#--------------------------START OF INPUTS------------------------
### Calipatria data
#clientlist=["SCEDC"]
clientlist=["SCEDC","IRIS"]
minlat=32.7
maxlat=33.7
minlon=-116.1
maxlon=-115.1

### Time duration should be for entire time period of interest
tstart="2021-06-05 00:00:00"
tend="2021-06-06 00:00:00"

# Download these channels, not ALL channels
chan_priority_list=["HH[ZNE12]", "BH[ZNE12]", "EH[ZNE12]", "HN[ZNE12]"]
#chan_priority_list=["EH[ZNE12]"]

# Output directories
out_dir_wf = '../../../Calipatria/waveforms'
out_dir_sta = '../../../Calipatria/stations'


domain = RectangularDomain(minlatitude=minlat, maxlatitude=maxlat,
                           minlongitude=minlon, maxlongitude=maxlon)

restrictions = Restrictions(
    starttime=tstart,
    endtime=tend,
    network="CI",
    station="SAL",
#    network="NP",
#    network="PB",
#    network="SB",
#    network="CE",
#    network="EN",
#    network="ZY",
    chunklength_in_sec=86400,
    reject_channels_with_gaps=False,
    minimum_interstation_distance_in_m=0.0,
    channel_priorities=chan_priority_list,
    minimum_length=0.0)

mdl = MassDownloader(providers=clientlist)
mdl.download(domain, restrictions, mseed_storage=out_dir_wf,
             stationxml_storage=out_dir_sta)
