# FAST tutorial

The following instructions were only tested on **Linux** clusters; we do not currently support other operating systems. To efficiently process inputs spanning a long duration, we suggest running the pipeline on a server with multiple processes and sufficient memory. 

### Dependencies
The pipeline is implemented in Python and C++, with the following dependencies:
```
c++ dependency: boost
python dependencies: obspy, pywt, scipy, numpy, skimage, sklearn
```

### Install
Copy the zip file to your home diretory, unzip and install the Python dependencies:
```sh
~/$ unzip FAST.zip
~/$ cd FAST
~/FAST$ pip install -r requirements.txt
```
Install the C++ dependencies:
```sh
~/FAST$ sudo apt-get install cmake, build-essential, libboost-all-dev 
```

### Dataset

Raw SAC files for each station are stored under  ```data/waveforms${STATION}```. Station "HEC" has 3 components so it should have 3 time series data files; the other stations have only 1 component.



### Fingerprint
Parameters for each station is under ```parameters/fingerprint/```. To fingerprint all stations and generate the global index, you can call the wrapper script (Python):
```sh
~/FAST$ python run_fp.py -c config.json
```
Another option for the fingerprint wrapper script (bash):
```sh
~/FAST$ cd fingerprint/
~/FAST/fingerprint$ ../parameters/fingerprint/run_fp_HectorMine.sh
```
The fingerprinting step takes less than 1 minute per waveform file on a 2.60GHz CPU. The generated fingerprints can be found at ```data/waveforms${STATION}/fingerprints/${STATION}${CHANNEL}.fp```. The json file ```data/waveforms${STATION}/${STATION}_${CHANNEL}.json``` contains information about the fingerprint file, including number of fingerprints (`nfp`) and dimension of each fingerprint (`ndim`).

Alternatively, to fingerprint a specific stations, call the fingerprint script with the corresponding fingerprint parameter file:
```sh
~/FAST$ cd fingerprint/
~/FAST/fingerprint$ python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
```

In addition to generating fingerprints, the wrapper script calls the global index generation script automatically. The global index (as opposed to index with a single component) is a consistent way to refer to fingerprint times at different components and stations. Global index generation should only be performed after you've generated fingerprints for *every* component and station that is used in the detection: 
```sh
~/FAST/fingerprint$ python global_index.py  ../parameters/fingerprint/global_indices.json
```
The resulting global index mapping for each component is stored at ```data/global_indices/${STATION}_${CHANNEL}_idx_mapping.txt```, where line `i` in the file represents the global index for fingerprint `i-1` in this component.

### Similarity Search
Compile and build the code for similarity search:
```sh
~/FAST$ cd simsearch
~/FAST/simsearch$ cmake .
~/FAST/simsearch$ make
```

Call the wrapper script to run similarity search for all stations:
```sh
~/FAST/simsearch$ cd ..
~/FAST$ python run_simsearch.py -c config.json
```
Another option for the similarity search wrapper script (bash):
```sh
~/FAST$ cd simsearch/
~/FAST/simsearch$ ../parameters/simsearch/run_simsearch_HectorMine.sh
```
Alternatively, to run the similarity search for each station individually:
```sh
~/FAST$ cd simsearch
~/FAST/simsearch$ ../parameters/simsearch/simsearch_input_HectorMine.sh CDY EHZ
```

### Postprocessing
The following scripts parse the binary output from similarity search to text files, and combine the three channel results for Station HEC to a single output. Finally, it copies the parsed outputs to directory ```../data/input_network/```.
```sh
~/FAST$ cd postprocessing/
~/FAST/postprocessing$ ../parameters/postprocess/output_HectorMine_pairs.sh
~/FAST/postprocessing$ ../parameters/postprocess/combine_HectorMine_pairs.sh
```

Run network detection:
```sh
~/FAST/postprocessing$ python scr_run_network_det.py ../parameters/postprocess/7sta_2stathresh_network_params.json
```
Results from the network detection are under ```data/network_detection/7sta_2stathresh_network_detlist*```. The file contains a list of potential detections including information about starting fingerprint index (global index, or time) at each station, number of stations where we found other events similar to this event (`nsta`), total number of similar fingerprint pairs mapped to the event (`tot_ndets`), total sum of the similarity values (`tot_vol`). Detailed format of the output can be found in the user guide. 

Optionally, to clean up the results from network detection (need to modify inputs within each script file):
```sh
~/FAST$ cd utils/network/
~/FAST/utils/network$ python arrange_network_detection_results.py
~/FAST/utils/network$ ./remove_duplicates_after_network.sh
~/FAST/utils/network$ python delete_overlap_network_detections.py
~/FAST/utils/network$ ./final_network_sort_nsta_peaksum.sh
```
The results from the above scripts can be found at ```data/network_detection/7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt```

### Plotting
To plot the waveforms from network detection:
```sh
~/FAST$ cd utils/events/ 
~/FAST/utils/events$ python PARTIALplot_hector_detected_waveforms.py 0 50
```
The above script plots the first 50 waveforms from the output.
The plot file names are sorted in descending order by: num_sta (number of stations that detected this event), peaksum (peak total similarity) 
You can view the images at data/network_detection/7sta_2stathresh_NetworkWaveformPlots/
Inspect the waveforms in order to set detection thresholds.


### References
You can find more details about the pipeline and guidelines for setting parameters in our extended [user guide](https://github.com/stanford-futuredata/quake/blob/master/FAST_userguide_v0.pdf). You may also check out the following papers:
+ **FAST Overview:** [Earthquake detection through computationally efficient similarity search](http://advances.sciencemag.org/content/1/11/e1501057)
+ **Fingerprint Overview:** [Scalable Similarity Search in Seismology: A New Approach to Large-Scale Earthquake Detection](https://link.springer.com/chapter/10.1007/978-3-319-46759-7_23)
+ **Fingerprint Benchmark:** [Earthquake Fingerprints: Extracting Waveform Features for Similarity-Based EarthquakeDetection](https://rdcu.be/8PqQ)
+ **Network Detection:** [Detecting Earthquakes over a Seismic Network using Single-Station Similarity Measures](https://doi.org/10.1093/gji/ggy100)
+ **FAST Application:** [Seismicity During the Initial Stages of the Guy‐Greenbrier, Arkansas, Earthquake Sequence](https://doi.org/10.1002/2017JB014946)
+ **Implementation and Performance:** [Locality-Sensitive Hashing for Earthquake Detection: A Case Study Scaling Data-Driven Science](http://www.vldb.org/pvldb/vol11/p1674-rong.pdf)
