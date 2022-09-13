# Earthquake Location

The phase pick information from `run_seisbench.py` is saved in `event_picks.json` in `/FAST/utils/picking/event_picks.json` and is used as input for finding the earthquake locations, starting with `SeisBench2hypoinverse.py`.  

`SeisBench2hypoinverse.py` will format the needed earthquake information as input for HYPOINVERSE.  

HYPOINVERSE is the standard location program supplied with the Earthworm seismic acquisition and processing system (AQMS). Read more about it [here](https://www.usgs.gov/software/hypoinverse-earthquake-location).  

## Get Station List  

You will need to edit `eqt_get_station_hectormine.py` in `/FAST/utils/location/` for your dataset:  

* Starting with getting the data

```  py linenums="125"
# Hector Mine data
clientlist=["SCEDC"]
minlat=34.1
maxlat=34.9
minlon=-116.7
maxlon=-116
```  

* Choose channels you want to download

```  py linenums="132"
chan_priority_list=["HH[ZNE12]", "BH[ZNE12]", "EH[ZNE12]", "HN[ZNE12]"] # Hector Mine data
```  

* Add event start and end time:

```  py linenums="147"
tstart="1999-10-12 00:00:00.00" # Hector Mine data
```  

```  py linenums="153"
tend="1999-10-17 00:00:00.00" # Hector Mine data
```  