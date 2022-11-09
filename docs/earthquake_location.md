# Earthquake Location

The phase pick information from `run_seisbench.py` is saved in `event_picks.json` in `/FAST/utils/picking/event_picks.json` and is used as input for finding the earthquake locations, starting with `SeisBench2hypoinverse.py`.  

`SeisBench2hypoinverse.py` will format the needed earthquake information as input for HYPOINVERSE.  

HYPOINVERSE is the standard location program supplied with the Earthworm seismic acquisition and processing system (AQMS). Read more about it [here](https://www.usgs.gov/software/hypoinverse-earthquake-location).  

### Make Changes to `SeisBench2hypoinverse.py`  

* Change output file name:  

```  py linenums="24"
out_hinv_phase_file = 'EQT_19991015_test.txt' # Change file name for your dataset
```  

### Get Station List  

You will need to edit `eqt_get_station_list.py` in `/FAST/utils/location/` for your dataset:  

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
## Information About `locate_events.hyp` input files

Input files `locate_events.hyp` relies on:  

* CRH 1 ‘hadley.crh’  
* STA ‘station_list.sta’  
* PHS ‘EQT_19991015_test.txt’  
* SUM ‘locate_events.sum’  
* ARC ‘locate_events.arc’  

`hadley.crh` is the velocity model input file. It approximates the p-wave speed (km/s) underground, at a given depth in km. You’ll need this to calculate earthquake locations from the phase pick times. The first column has p-wave speed in km/s. The second column has depth in km. The p-wave speed is 5.5 km/s at depths from 0 to 5.5 km, 6.3 km/s at depths from 5.5 to 16 km, 6.7 km/s at depths from 16 to 32 km, and 7.8 km/s at depths deeper than 32 km.

```  py linenums="9"
POS 1.73				/P to S ratio
```  

This line in the `locate_events.hyp` file tells you the ratio between p wave and s wave speed.  S wave speed is always slower than p wave speed, so s picks are always later than p picks.  You can divide the first column of numbers in hadley.crh by 1.73 to get the s-wave speeds; that’s what HYPOINVERSE does internally.

`PHS ‘EQT_19991015_test.txt’` - that’s the all-important file your script generated, that has the approximate origin times and phase pick times from SeisBench.  

`STA ‘station_list.sta’` - this is the station file, which has the list of station names and their locations.  There are scripts you can run to create this file shown in [Tutorial](tutorial.md).  


### Change File Name in `locate_events.hyp`  

The output changed above in `SeisBench2hypoinverse.py` is used in `locate_events.hyp`  

* Change file name for your dataset in `locate_events.hyp`:  

```  py linenums="53"
PHS 'EQT_19991015_test.txt' # Change file name for your dataset
```  

## Plotting HYPOINVERSE Location Results With PyGMT  

IMPORTANT - PyGMT needs to be installed and run in a separate `pygmt` conda environment, since it is incompatible with the `eq_fast` conda environment.  

Follow the steps in the [tutorial section](tutorial.md) to user PyGMT.  
