# FAST tutorial 

### Dataset

Raw SAC files for each station are stored under  ```data/waveforms${STATION}```. Station "HEC" has 3 components so it should have 3 time series data files; the other stations have only 1 component.

### Install 
```sh
~/$ cd quake-tutorial
~/quake-tutorial$ pip install -r requirements.txt
```

### Fingerprint
Parameters for each station is under ```parameters/fingerprint/```. To fingerprint all stations and generate the global index, you can call the wrapper script:
```sh
~/quake-tutorial$ python run_fp.py -c config.json
```
Alternatively, to fingerprint a specific stations, call the fingerprint script with the corresponding fingerprint parameter file:
```sh
~/quake-tutorial$ cd fingerprint/
~/quake-tutorial/fingerprint$ python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
```


### Similarity Search
Compile and build the code for similarity search:
```sh
~/quake-tutorial$ cd simsearch
~/quake-tutorial/simsearch$ cmake .
~/quake-tutorial/simsearch$ make
```

Call the wrapper script to run similarity search for all stations:
```sh
~/quake-tutorial/simsearch$ cd ..
~/quake-tutorial$ python run_simsearch.py -c config.json
```

Alternatively, to run the similarity search for each station individually, copy the config file to the current directory, and uncomment corresponding blocks of parameters:
```sh
~/quake-tutorial$ cd simsearch
~/quake-tutorial/simsearch$ cp ../parameters/simsearch/simsearch_input_HectorMine.sh  .
~/quake-tutorial/simsearch$ ./simsearch_input_HectorMine.sh
```

### Postprocessing
Copy the helper scripts for postprocessing into the folder:
```sh
~/quake-tutorial/simsearch$ cd ../postprocessing
~/quake-tutorial/postprocessing$ cp ../parameters/postprocess/*.sh  .
```
The following scripts parse the binary output from similarity search to text files, and combine the three channel results for Station HEC to a single output. Finally, it copies the parsed outputs to directory ../data/input_network/.
```sh
~/quake-tutorial/postprocessing$ ./output_HectorMine_pairs.sh
~/quake-tutorial/postprocessing$ ./combine_HectorMine_pairs.sh
```

Run network detection:
```sh
~/quake-tutorial/postprocessing$ cp ../parameters/network/* .
~/quake-tutorial/postprocessing$ python scr_run_network_det.py 7sta_2stathresh_network_params.json
```

To clean up the results from network detection:
```sh
~/quake-tutorial/postprocessing$ python arrange_network_detection_results.py
~/quake-tutorial/postprocessing$ ./remove_duplicates_after_network.sh
~/quake-tutorial/postprocessing$ python delete_overlap_network_detections.py
~/quake-tutorial/postprocessing$ ./final_network_sort_nsta_peaksum.sh

```

### Plotting  
To plot the waveforms from network detection:
```sh
~/quake-tutorial/postprocessing$ cd ../parameters/events 
~/quake-tutorial/parameters/events$ python PARTIALplot_hector_detected_waveforms.py 0 50
```
You can view the images at data/network_detection/7sta_2stathresh_NetworkWaveformPlots/

