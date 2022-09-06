# Earthquake Location

The phase pick information from `run_seisbench.py` is saved in `event_picks.json` in `/FAST/utils/picking/event_picks.json` and is used as input for finding the earthquake locations, starting with `SeisBench2hypoinverse.py`.  

`SeisBench2hypoinverse.py` will format the needed earthquake information as input for HYPOINVERSE.  

HYPOINVERSE is the standard location program supplied with the Earthworm seismic acquisition and processing system (AQMS). Read more about it [here](https://www.usgs.gov/software/hypoinverse-earthquake-location).