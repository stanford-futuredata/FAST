# **Tutorial**

## **Example Data: Hector Mine Foreshocks**

![hector_mine_plot](img/hector_mine_plot.png)

<br></br>

* 20 hours of continuous data from 7 stations (9 components). <br>
* The data is already bandpass filtered, decimated to 20 Hz. HEC is 3-components; other stations are 1-component.

<br></br>

<p align="center">waveform data: <span style="color: red;">data/waveforms${STATION}/Deci5*</span></p>

## **File Structure Overview**

### *Code*  

    fingerprint/          # Fingerprint
    simsearch/            # Similarity Search
    postprocessing/       # Postprocessing
    utils/                # Utility Functions
        preprocess/       
        network/          
        events/           
        run_fp.py         
        run_simsearch.py  


### *Configuration and Parameters*  

    parameters/            
        fingerprint/       
        simsearch/         
        postprocess/       

### *Data*  

    data/
        waveforms${STATION}/
            Deci5*

## **Feature Extraction**  

![fp_step](img/fp_step.png)

### Generate Fingerprints

* Create fingerprints for each of the 9 channels (7 stations) + global index, using wrapper
  
``` bash
~/quake_tutorial$ python run_fp.py -c config.json
```

* Alternatively, to fingerprint a specific station, call the fingerprint script with the corresponding fingerprint parameter file:

``` bash
~/quake_tutorial$ cd fingerprint/
~/quake_tutorial/fingerprint$ python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
```

### Global Index

!!! note
    Global index is already called by run_fp.py wrapper  

* Complete this step only ^^after^^ you have finished computing ^^fingerprints^^ for ^^every^^ component and station you want to use for detection.  
  
``` bash
$ python global_index.py global indices.json
```

  - `global_index.py` **in** `fingerprint/`
  - `global_indices.json` **in** `parameters/fingerprint/`  
<br>
* Continuous data start/end times may be different, and time gaps may happen at different times, at different components and stations.  
* Global index: consistent way to refer to times of fingerprints at different components and stations.  

## **Similarity Search**

![simsearch_step](img/simsearch_step.png)

### Search for Similar Earthquake Pairs

* Compile and build C++ similarity search code.

``` bash
~/quake_tutorial$ cd simsearch/
~/quake_tutorial$ cmake .
~/quake_tutorial$ make
```  

* Similarity search for each of the 9 channels (7 stations), using wrapper  

``` bash
~/quake_tutorial/simsearch$ cd ..
~/quake_tutorial$ python run_simsearch.py -c config.json
```  

* Alternatively, to use similarity search for a specific station, call the similarity search script with the corresponding similarity search parameter file:

``` bash
~/quake_tutorial$ cd simsearch/
~/quake_tutorial$ cp ../parameters/simsearch/simsearch_input_HectorMine.sh .
~/quake_tutorial$ ./simsearch_input_HectorMine.sh
```

### FAST Similarity Search Output (1 Channel)  

`data/waveforms${STATION}/fingerprints`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; — MinHash Signatures (can delete these later)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• `mh_${STATION}_${CHANNEL}_${nhash}.bin`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Example: `mh_CDY_EHZ_4.bin`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; — Binary files with similarity search output (npart files, one per partition, with first and last fingerprint index for the partition in filename):  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• `candidate_pairs_${STATION}_${CHANNEL}_${nhash},${ntbl}(${FIRST_FP_INDEX},${LAST_FP_INDEX})`   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• Example: `andiate_pairs_CDY_EHZ_4,2(0,74793)`  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• For efficiency, the output is binary format; need parsing to convert similarity search &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;output to text files

### Parse FAST Similarity Search Output: [Binary --> Text File]

* Use the wrapper script to parse all 9 channels (7 stations)
```
~/quake_tutorial$ cd postprocessing
~/quake_tutorial/postprocessing$ cp ../parameters/postprocess/*.sh .
~/quake_tutorial/postprocessing$ ./output_HectorMine_pairs.sh
```

* Parse a Specific Channel
```
python parse_results.py –d <folder_with_binary_sim_search_files> -p <sim_search_filename_prefix> -i <global_index_file>
```

* **Example input file:** `candidate_pairs_CDY_EHZ_4,2(0,74793)`  
* **Example command:** 
```
$ python parse_results.py –d ../data/waveformsCDY/fingerprints/ candidate_pairs_CDY_EHZ –i ../data/global_indices/CDY_EHZ_idx_mapping.txt
```

## **Postprocessing**

![postproc_step](img/postproc_step.png)

### Postprocess: Combine FAST Similarity Search Output (3 Components @ 1 Station)  

* Combine similarity matrix from all components in each station, and copy outputs to `../data/inputs_network/` using wrapper script:  
    * `~/quake_tutorial/postprocessing$ cp ../parameters/postprocess/*.sh .`  
    * `~/quake_tutorial/postprocessing$ ./combine_HectorMine_pairs.sh`  

* Alternatively, to combine outputs (add “FAST similarity” for same fingerprint pair (index1, index2) ) from a specific station:  
    * `$ python parse_results.py –d <folder_with_text_sim_search_files> -p <text_sim_search_file_prefix> --sort true –parse false –c true –t <threshold>`  
    * **Example:** ` $ python parse_results.py –d ../data/inputs_network/ -p candidate_pairs_HEC --sort true –parse false –c true –t 6` 
        * Adds FAST similarity for same fingerprint pairs on HEC components: `candidate_pairs_HEC_BHE_merged.txt`, `candidate_pairs_HEC_BHN_merged.txt`, `candidate_pairs_HEC_BHZ_merged.txt`  
        * Output (one file per station): `candidate_pairs_HEC_combined.txt`  

        !!! warning
            By default, the *merged.txt files for all 3 components are deleted after combining! Copy them before this step if you want to keep them.

    * Usually set threshold=number of components * v, where v=nvote at a single component  
        * The threshold helps filter out matches generated from noise, since we require either strong matches at a single component, or weak matches at multiple components
        * May want to set threshold slightly lower (e.g., 2*v) if the output size is too small after combining

### Postprocess: Weight Stations Equally

* ‘Equalize’ across network: weighting stations with different number of components equally
    * Hector Mine example: one 3-component station (HEC) with similarity threshold at 6 votes, and 6 1-component stations with similarity threshold at 2 votes.
    * Want to weight each station equally, so multiply similarity in each 1-component station by 3
        * `$ awk ‘{print$1,$2,3*$3}’ candidate_pairs_CDY_EHZ_merged.txt > candidate_pairs_CDY_combined.txt`

* Another option: use only part of the data (e.g. vertical component at each station)

![postproc_weight](img/postprocess_weight.png)

### Postprocess: Network Detection

* Run network detection (combine FAST results from all 7 stations):  
    * `~/quake_tutorial/postprocessing$ cp ../parameters/network/* .`  
    * `~/quake_tutorial/postprocessing$ python scr_run_network_det.py 7sta_2stathresh_network_params.json`  

Input file: `7sta_2stathresh_network_params.json`

![input)file_network](img/input_file_network.png)

### Network Detection Outputs

* Network Detection Output (text file with labeled columns)
    * Example (ranked in descending order of ‘peaksum’): `7sta_2stathresh_detlist_rank_by_peaksum.txt`  
    * First (num_sta=number of stations) columns: starting fingerprint index at each station (time information)  
        * Outputs “nan” if not observed at a particular station
    * `dL`: Maximum length (samples) along diagonal, over all event-pairs containing this event  
    * `nevents`: Number of other events ‘linked’ to (similar to) this event
    * `nsta`: Number of stations over which other events are similar to this event
    * `tot_ndets`: Total number of fingerprint-pairs (pixels) containing this event, over all event-pair clusters, over all stations
    * `max_ndets`: Maximum number of fingerprint-pairs (pixels) containing this event, over all event-pair clusters, over all stations
    * `tot_vol`: Total sum (or ‘volume’) of all similarity values (added over all stations), over all event-pairs containing this event
    * `max_vol:` Maximum sum (or ‘volume’) of all similarity values (added over all stations), over all event-pairs containing this event
    * `max_peaksum`: Maximum similarity value (added over all stations), over all event-pairs containing this event

### Example Custom Scripts to Clean up and Visualize Network Detection Results

* Depending on the parameters, network detection output text file might still have duplicate events
* We provide some example post-processing scripts to remove these duplicate events and come up with a final list of event detections
    * `cp ../utils/network/* .`
  
    !!! note
        These have not been fully tested. You may want
        to write your own instead! Need to modify input/output parameters within each script. 4 scripts: outputs of each script are inputs to the next script.

1. `~/quake_tutorial/postprocessing$ python arrange_network_detection_results.py`  
    1. Save only start and end fingerprint indices for each event (Firstnum_stacolumns --> 2 columns)
    2. Output 2 more columns at end
        1. `Num_sta`: number of stations that detected event
        2. `Diff_ind`: Difference between first and last fingerprint index
    3. **Example output:** `NetworkDetectionTimes_7sta_2stathresh_detlist_rank_by_peaksum.txt`

1. `~/quake_tutorial/postprocessing$ ./remove_duplicates_after_network.sh`  
    1. Remove events with duplicate start fingerprint index (keep events with highest num_sta then peaksum)
    2. **Example output:** `uniquestart_sorted_no_duplicates.txt`

2. `~/quake_tutorial/postprocessing$ python delete_overlap_network_detections.py`  
    1. Remove events with overlapping times: where start time of one event is before end time of another event
    2. **Example output:** `7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt`

3. `~/quake_tutorial/postprocessing$ ./final_network_sort_nsta_peaksum.sh`  
    1. Sort events in descending order of num_sta (number of stations that detected event), then peaksum (maximum similarity for this event)
    2. Should no longer have duplicate events
    3. **Example output:** `sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt`