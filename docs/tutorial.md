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

### **Generate Fingerprints**

* Create fingerprints for each of the 9 channels (7 stations) + global index, using wrapper
  
``` bash
~/quake_tutorial$ python run_fp.py -c config.json
```

* Alternatively, to fingerprint a specific station, call the fingerprint script with the corresponding fingerprint parameter file:

``` bash
~/quake_tutorial$ cd fingerprint/
~/quake_tutorial/fingerprint$ python gen_fp.py ../parameters/fingerprint/fp_input_CI_CDY_EHZ.json
```

### **Global Index**

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

### **Search for Similar Earthquake Pairs**

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
~/quake_tutorial/postprocessing$ ../parameters/postprocess/*.sh .
~/quake_tutorial/postprocessing$ ./output_HectorMine_pairs.sh
```

* Parse a Specific Channel
```
python parse_results.py –d <folder_with_binary_sim_search_files> -p <sim_search_filename_prefix> -i <global_index_file>
```

* Example input file: `candidate_pairs_CDY_EHZ_4,2(0,74793)`  
* Example command: 
```
$ python parse_results.py –d ../data/waveformsCDY/fingerprints/ candidate_pairs_CDY_EHZ –i ../data/global_indices/CDY_EHZ_idx_mapping.txt
```

## **Postprocessing**

![postproc_step](img/postproc_step.png)

