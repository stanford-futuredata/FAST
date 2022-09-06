# Phase Picking  

The FAST output is interfaced with SeisBench to pick the arrival time of phases automatically with machine learning models.

SeisBench is an open-source python toolbox for machine learning in seismology. Learn more about SeisBench [here](https://seisbench.readthedocs.io/en/stable/index.html).

## Cut SAC Files

In `cut_event_files.py`, change the station list on line 14 to list the stations in your dataset and the name of the final detection list on line 16.  

Example in `cut_event_files`:  

``` py linenums="14"  
stations = ['CDY', 'CPM', 'GTM', 'HEC', 'RMM', 'RMR', 'TPC']  # Change station list
in_mseed_dir = '../../data/'  
in_FINAL_Detection_List = 'network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt'  # Change final detection list
out_dir = 'event_ids'  
```  
  
Your continuous seismic data should be found in `/FAST/data/waveforms*/Deci5.Pick.*`  

## Pick Phases Over All Input  

!!! note
    If stations in your dataset do not have 3 channels, you will need to alter `run_seisbench.py` to make .sac file copies for stations without 3 channels.

In the Hector Mine dataset, only the HEC station has 3 channels. On line 20 of `run_seisbench.py`, the stations that only have one component are in a list, which is iterated through to make channel copies for phase picking.  

``` py linenums="20"
stations = ['CDY', 'CPM', 'GTM', 'RMM', 'RMR', 'TPC'] # List of stations that do not have 3 components
```  

To make sure `run_seisbench.py` runs correctly on your dataset, edit the following code in the script to account for missing station channels:  


``` py linenums="64"  
if stream[i].stats.station in stations:
    st_temp = Stream()
    tr_temp_e = stream[i].copy()
    tr_temp_n = stream[i].copy()
    tr_temp_z = stream[i].copy()
    tr_temp_e.stats.channel = 'EHE'
    st_temp.append(tr_temp_e)
    tr_temp_n.stats.channel = 'EHN'
    st_temp.append(tr_temp_n)
    tr_temp_z.stats.channel = 'EHZ'
    st_temp.append(tr_temp_z)
    
    st += st_temp
else:
    st += stream[i] 
```  

Run the SeisBench script:  

```
~/FAST/utils/events$ cd ..
~/FAST/utils$ cd picking
~/FAST/utils/picking$ python run_seisbench.py
```   

The plotted annotations with each station's waveform and EQTransformer's picks and detections for every event is found in:  

```
~/quake_tutorial/data/seisbench_picks
```

Example annotated plot from one event in the Hector Mine dataset:  

![example_pick_1](img/example_pick_1.png)

The phase pick information found from SeisBench is found in:  

```
~/quake_tutorial/utils/picking/event_picks.json/
```  

Example output:  

![json_file_picks](img/json_file_picks.png)

* "peak_time": Arrival time of pick
* "peak_value": Probability of pick