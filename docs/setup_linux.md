# **Installation for Linux**

## Requirements

FAST is written in Python and C++ and is designed to run on Linux clusters.  

Install instructions might not work for Windows and macOS machines. Refer to the installation instructions for [Google Colab](setup_colab.md) or [Docker](setup_docker.md) if you want to run FAST on a machine other than Linux.  

The code will benefit from running on machines with more memory and CPUs.  

* Consider using instances from Amazon AWS or Google Cloud  

## Install

Clone the FAST repository from GitHub into a local directory named `./FAST/`
```
(base) ~$ git clone https://github.com/stanford-futuredata/FAST.git ./FAST/
```  

Install utilities (if not already installed)
```
(base) ~$ sudo apt-get install -y wget
(base) ~$ sudo apt-get install -y jq
```  

Install C++ dependencies
```
(base) ~$ sudo apt-get install -y cmake
(base) ~$ sudo apt-get install -y build-essential
(base) ~$ sudo apt-get install -y libboost-all-dev
```

Install Python dependencies in the `eq_fast` conda environment
This requires having [Anaconda](https://docs.anaconda.com/anaconda/install/linux/) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html) already installed on your computer
```
(base) ~$ cd FAST/
(base) ~/FAST$ conda env create -f environment.yml -n eq_fast
```  

Activate `eq_fast` conda environment before running FAST
```
(base) ~/FAST$ conda activate eq_fast
(eq_fast) ~/FAST$
```

### Dataset

Raw SAC files for each station are stored under `data/waveforms${STATION}`. Station "HEC" has 3 components so it should have 3 time series data files; the other stations have only 1 component.  

### Fingerprint  

Parameters for each station are under `parameters/fingerprint/`. To fingerprint all stations and generate the global index, you can call the wrapper script (Python):  

```
(eq_fast) ~/FAST$ python run_fp.py -c config.json
```  

An alternate option for the fingerprint wrapper script (bash):

```
(eq_fast) ~/FAST$ cd fingerprint/
(eq_fast) ~/FAST/fingerprint$ ../parameters/fingerprint/run_fp_HectorMine.sh
```  

The fingerprinting step takes less than 1 minute per waveform file on a 2.60GHz CPU.

The generated fingerprints can be found at `data/waveforms${STATION}/fingerprints/${STATION}${CHANNEL}.fp`.

The json file `data/waveforms${STATION}/${STATION}_${CHANNEL}.json` contains information about the fingerprint file, including number of fingerprints (`nfp`) and dimension of each fingerprint (`ndim`).

To fingerprint a specific channel/station, call the fingerprint script with the corresponding fingerprint parameter file (this is one line from `run_fp_HectorMine.sh`):

```
(eq_fast) ~/FAST$ cd fingerprint/
(eq_fast) ~/FAST/fingerprint$ python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
```  

In addition to generating fingerprints, the wrapper script calls the global index generation script automatically. The global index (as opposed to index with a single component) is a consistent way to refer to fingerprint times at different components and stations. Global index generation should only be performed after you've generated fingerprints for every component and station that is used in the detection:  

```
(eq_fast) ~/FAST/fingerprint$ python global_index.py  ../parameters/fingerprint/global_indices.json
```  

The resulting global index mapping for each component is stored at `data/global_indices/${STATION}_${CHANNEL}_idx_mapping.txt`, where line i in the file represents the global index for fingerprint i-1 in this component.  

### Similarity Search  

Compile and build the code for similarity search:  

```
(eq_fast) ~/FAST$ cd simsearch
(eq_fast) ~/FAST/simsearch$ cmake .
(eq_fast) ~/FAST/simsearch$ make
```  

Call the wrapper script to run similarity search for all stations:  

```
(eq_fast) ~/FAST/simsearch$ cd ..
(eq_fast) ~/FAST$ python run_simsearch.py -c config.json
```  

An alternate option for the similarity search wrapper script (bash):

```
(eq_fast) ~/FAST$ cd simsearch/
(eq_fast) ~/FAST/simsearch$ ../parameters/simsearch/run_simsearch_HectorMine.sh
```

To run the similarity search for each channel/station individually:

```
(eq_fast) ~/FAST$ cd simsearch/
(eq_fast) ~/FAST/simsearch$ ../parameters/simsearch/simsearch_input_HectorMine.sh CDY EHZ
```  

### Postprocess: Parse FAST Similarity Search Output

The following scripts parse the binary output from similarity search to text files, and combine the three channel results for station HEC to a single output. Finally, it copies the parsed outputs to directory `../data/inputs_network/`.

```
(eq_fast) ~/FAST$ cd postprocessing/
(eq_fast) ~/FAST/postprocessing$ ../parameters/postprocess/output_HectorMine_pairs.sh
(eq_fast) ~/FAST/postprocessing$ ../parameters/postprocess/combine_HectorMine_pairs.sh
```  

### Postprocess: Network detection

```
(eq_fast) ~/FAST/postprocessing$ python scr_run_network_det.py ../parameters/postprocess/7sta_2stathresh_network_params.json
```  

Results from the network detection are under `data/network_detection/7sta_2stathresh_detlist*`. The file contains a list of potential detections including information about starting fingerprint index (global index, or time) at each station, number of stations where we found other events similar to this event (`nsta`), total number of similar fingerprint pairs mapped to the event (`tot_ndets`), total sum of the similarity values (`tot_vol`). Detailed format of the output can be found in the user guide.

### Postprocess: Clean Network Detection Results
Need to modify inputs within each script file to your data set.

```
(eq_fast) ~/FAST$ cd utils/network/
(eq_fast) ~/FAST/utils/network$ python arrange_network_detection_results.py
(eq_fast) ~/FAST/utils/network$ ./remove_duplicates_after_network.sh
(eq_fast) ~/FAST/utils/network$ python delete_overlap_network_detections.py
(eq_fast) ~/FAST/utils/network$ ./final_network_sort_nsta_peaksum.sh
```  

The results from the above scripts can be found at `data/network_detection/sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt`

The above section only works with detection results with ^^multiple stations^^. For single station detections, you can parse the results in the ==output file==. The schema of the output file is: event_start (starting fingerprint index), event_dt, ndets (total number of event-pairs that include this event), peaksum (peak total similarity), and volume (sum of all similarity values for all event-pairs containing this event). Large peaksums usually correspond to higher confidence.  

### Visualize the FAST Output

```
(eq_fast) ~/FAST/utils/network$ cat ../../data/network_detection/sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Display Waveforms for FAST Detections in Descending Order of "peaksum" Similarity

This example outputs png images for 100 event waveforms. The plot file names are sorted in descending order by: `num_sta` (number of stations that detected this event), `peaksum` (peak total similarity)

```
(eq_fast) ~/FAST/utils/network$ cd ..
(eq_fast) ~/FAST/utils$ cd events/
(eq_fast) ~/FAST/utils/events$ python PARTIALplot_detected_waveforms_HectorMine.py 0 100
```

!!! note
    View waveform images — to manually determine detection threshold
    ```
    $ ls ../../data/network_detection/7sta_2stathresh_NetworkWaveformPlots/
    event_rank00000_nsta7_peaksum1015_ind6204_time6204.0_1999-10-15T14:43:24.676000.png
    event_rank00001_nsta7_peaksum1015_ind3842_time3842.0_1999-10-15T14:04:02.676000.png
    event_rank00002_nsta7_peaksum920_ind7488_time7488.0_1999-10-15T15:04:48.676000.png
    event_rank00003_nsta7_peaksum823_ind5286_time5286.0_1999-10-15T14:28:06.676000.png
    event_rank00004_nsta7_peaksum718_ind20202_time20202.0_1999-10-15T18:36:42.676000.png
    event_rank00005_nsta7_peaksum713_ind46536_time46536.0_1999-10-16T01:55:36.676000.png
    ...
    ```

Similarly, to plot results for single station detection, we need a global start time (t0) from global_idx_stats.txt, dt_fp in seconds:  

* Event time = t0 + dt_fp * (start fingerprint index)

### Set Detection Threshold

!!! note
    Everything above the detection threshold is deemed an earthquake. In this example, the first 50 events with the highest "peaksum" similarity are identified as earthquakes, while the remaining events are not earthquakes.

```
(eq_fast) ~/FAST/utils/events$ cd ../../data/network_detection/
(eq_fast) ~/FAST/data/network_detection$ head -50 sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt > EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Output Final FAST Detected Event List

```
(eq_fast) ~/FAST/data/network_detection$ cd ../../utils/events/
(eq_fast) ~/FAST/utils/events$ python output_final_detection_list.py
(eq_fast) ~/FAST/utils/events$ cat ../../data/network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt
```

<br></br>

!!! info
    The following tutorials are not a part of FAST but are optional steps to take for phase picking and earthquake location using SeisBench, HYPOINVERSE, and PyGMT.

## **Phase Picking**  

### Cut SAC Files  

* Cut short event waveform files in SAC format from the continuous seismic data at all stations, based on the detection results from FAST.
* Cut from the original unfiltered continuous seismic data at full sampling rate (usually 100 sps), not the decimated filtered continuous seismic data used to run FAST.
* In this example, the event waveform time windows are 180 seconds long, 60 seconds before detection time, 120 seconds after detection time.

```
(eq_fast) ~/FAST/utils/events$ python cut_event_files.py
```  

* Check for cut files in:  

```
(eq_fast) ~/FAST/data/event_ids
```

* Example:  

![ex_files](img/ex_files.png)

### Install SeisBench  

```
(eq_fast) ~/FAST/utils/events$ cd ../..
(eq_fast) ~/FAST$ pip install seisbench
```

### Pick Phases (automatically)  

* Run SeisBench script for all events and all stations. This can take a few minutes to finish running.

```
(eq_fast) ~/FAST$ cd utils/picking
(eq_fast) ~/FAST/utils/picking$ python run_seisbench.py
```  

* Annotated plots are found in:  

```
(eq_fast) ~/FAST/data/seisbench_picks/
```  

![example_pics](img/example_picks.png)

* Example annotated plot from event 00000000:  

![example_pick_1](img/example_pick_1.png)

Output saved in:
```
(eq_fast) ~/FAST/data/seisbench_picks/event_picks.json
```  

Example output:  

![json_file_picks](img/json_file_picks.png)

* "peak_time": Arrival time of pick
* "peak_value": Probability of pick

## **Earthquake Location**  

The output from `run_seisbench.py` in the `event_picks.json` file contains the information needed to locate the detected earthquakes from the FAST final detection list. We use HYPOINVERSE to locate earthquakes from the picks found with `run_seisbench.py`.  

HYPOINVERSE is the standard location program supplied with the Earthworm seismic acquisition and processing system (AQMS). Read more about it [here](https://www.usgs.gov/software/hypoinverse-earthquake-location).  

### Formatting input data for HYPOINVERSE

To begin earthquake location run the following to format the phase picks for HYPOINVERSE:  

```
(eq_fast) ~/FAST/utils/picking$ cd ../location/
(eq_fast) ~/FAST/utils/location$ python SeisBench2hypoinverse.py
```  

Output:
```
~/FAST/data/location_hypoinverse/EQT_19991015_test.txt
```

The script `SeisBench2hypoinverse.py` will also copy the following files from `~/FAST/utils/location/` to the directory `~/FAST/data/location_hypoinverse/` where we will run HYPOINVERSE:
```
   *   hadley.crh
   *   locate_events.hyp
```

Get Hector Mine Station List as a json file:
```
(eq_fast) ~/FAST/utils/location$ cd ../preprocess/
(eq_fast) ~/FAST/utils/preprocess$ python get_station_list.py
```

Output:
```
~/FAST/data/stations/station_list.json
```

Convert `station_list.json` to HYPOINVERSE station input format in `station_list.sta`:
```
(eq_fast) ~/FAST/utils/preprocess$ cd ../location/
(eq_fast) ~/FAST/utils/location$ python output_station_file.py
```

Output:
```
~/FAST/data/location_hypoinverse/station_list.sta
```

### Install and Run HYPOINVERSE

Check that GFortran is installed, since it is required to compile the HYPOINVERSE program from source:
```
(eq_fast) ~/FAST$ gfortran --version
```  

Example expected output:  
==GNU Fortran (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0==  

If GFortran is not installed, run:  
```
(eq_fast) ~/FAST$ apt-get update && apt-get upgrade
(eq_fast) ~/FAST$ apt-get install gfortran
```

Download HYPOINVERSE [here](https://www.usgs.gov/software/hypoinverse-earthquake-location), expand the `hyp1.40.tar` file,
move the resulting `hyp1.40/` directory to `~/FAST/utils/location/hyp1.40/`. This can be done with the following commands:
```
(eq_fast) ~/FAST/utils/location$ wget -c https://escweb.wr.usgs.gov/content/software/HYPOINVERSE/hyp1.40.tar
(eq_fast) ~/FAST/utils/location$ mkdir hyp1.40
(eq_fast) ~/FAST/utils/location$ cd hyp1.40
(eq_fast) ~/FAST/utils/location/hyp1.40$ tar -xvf ../hyp1.40.tar
(eq_fast) ~/FAST/utils/location/hyp1.40$ ls -l
drwxr-xr-x  4 10003  124   128 Sep 10  2014 doc
-rw-r--r--  1 root  root 77392 Sep 10  2014 hyp1.40-release-notes.pdf
-rw-r--r--  1 root  root  3258 Sep 10  2014 hyp1.40-release-notes.txt
drwxr-xr-x 54 10003  124  1728 Sep 10  2014 source
drwxr-xr-x 13 10003  124   416 Aug 26  2014 testone
```

Before compiling HYPOINVERSE, we need to make changes to `makefile` in `~/FAST/utils/location/hyp1.40/source/`:
```
(eq_fast) ~/FAST/utils/location/hyp1.40$ cd source
(eq_fast) ~/FAST/utils/location/hyp1.40/source$ sed -i '/calnet/d' makefile
(eq_fast) ~/FAST/utils/location/hyp1.40/source$ sed -i 's/g77/gfortran/g' makefile
```

* Remove lines **16** and **230**

```  py linenums="16"
cp hyp1.40 /home/calnet/klein/bin
```  

```  py linenums="230"
cp p2sdly /home/calnet/klein/bin
```  

* Find and replace: `g77` with `gfortran`

**Check that HYPOINVERSE runs**:

* Compile HYPOINVERSE:
```
(eq_fast) ~/FAST/utils/location/hyp1.40/source$ make
```  

* Make it executable:  
```
(eq_fast) ~/FAST/utils/location/hyp1.40/source$ chmod +x hyp1.40
```  

* Run HYPOINVERSE:  
```
(eq_fast) ~/FAST/utils/location/hyp1.40/source$ ./hyp1.40
```  

* Expected output:
```
HYPOINVERSE 2000 STARTING
6/2014 VERSION 1.40 (geoid depth possible)
 COMMAND?
```   

If you have this output, HYPOINVERSE is running correctly. Press ctrl-c to exit.

### Run HYPOINVERSE

Run HYPOINVERSE within the directory `~/FAST/data/location_hypoinverse/`:
```
(eq_fast) ~/FAST/utils/location$ cd ../../data/location_hypoinverse/
(eq_fast) ~/FAST/data/location_hypoinverse$ ../../utils/location/hyp1.40/source/hyp1.40
```  

Use **@locate_event.hyp** as input:
```
HYPOINVERSE 2000 STARTING
6/2014 VERSION 1.40 (geoid depth possible)
 COMMAND? @locate_events.hyp
```  

Expected output:
![hypo_output](img/hypo_output.png)   

You should see output files called `locate_events.sum` and `locate_events.arc` in HYPOINVERSE Y2000 summary format, but these are difficult to read.

!!! note
    `locate_events.arc` has the event info, and phase pick info for each event. `locate_events.sum` has only the event info, no phase pick info.

Use `output_hypoinverse_as_text.py` to output `locate_events.sum` in a more readable format to use for plotting and visualization.

```
(eq_fast) ~/FAST/data/location_hypoinverse$ cd ../../utils/location/
(eq_fast) ~/FAST/utils/location$ python output_hypoinverse_as_text.py
```

## **Plotting Earthquake Locations with PyGMT**

### Install PyGMT

IMPORTANT - PyGMT needs to be installed and run in a separate `pygmt` conda environment, since it is incompatible with the `eq_fast` conda environment.

First, exit the `eq_fast` conda environment
```
(eq_fast) ~/FAST/utils/location$ conda deactivate
```

Next, create the `pygmt` conda environment with its dependencies, as described in the [PyGMT install page](https://www.pygmt.org/latest/install.html)
```
(base) ~/FAST/utils/location$ conda config --prepend channels conda-forge
(base) ~/FAST/utils/location$ conda create --name pygmt python=3.9 numpy pandas xarray netcdf4 packaging gmt
```

Finally, enter the `pygmt` conda environment and install PyGMT
```
(base) ~/FAST/utils/location$ conda activate pygmt
(pygmt) ~/FAST/utils/location$ conda install pygmt
```  

### Create a PyGMT map of earthquake locations and seismic stations

```
(pygmt) ~/FAST/utils/location$ cd ../mapping/
(pygmt) ~/FAST/utils/mapping$ python hypoinverse_to_pygmt.py
```  

Figure saved as `pygmt_hectormine_map.png` in `~/FAST/data/mapping_pygmt/`

**Map Output**:  

#![hectormine_pygmt|10x20](img/hectormine_pygmt.png)
