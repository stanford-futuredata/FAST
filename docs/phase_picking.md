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