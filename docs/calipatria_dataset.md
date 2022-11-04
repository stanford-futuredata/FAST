# 0.11 Calipatria, June 2021  

![calipatria_maps](img/calipatria_maps.png)  

Get stations and waveform data in directory: `/app/data/20210605_Calipatria_data/  `

```
(eq_fast) root@6006660926e5:/app# cd parameters/preprocess/Calipatria/
```  

Get station data in directory: /app/data/20210605_Calipatria_data/stations/  

```
(eq_fast) root@6006660926e5:/app/parameters/preprocess/Calipatria# python get_station_list_Calipatria.py
```  

For these stations, download waveform data in directory: `/app/data/20210605_Calipatria_data/waveforms/`  

Try the mass downloader first. Then try the get_waveforms function from client directly to get any data missed from mass downloader. You may need to run waveform download scripts multiple times to get all data.  

```
(eq_fast) root@6006660926e5:/app/parameters/preprocess/Calipatria# python get_waveforms_mdl_Calipatria.py
(eq_fast) root@6006660926e5:/app/parameters/preprocess/Calipatria# python get_station_list_Calipatria.py
```  

Not all stations from the original station list will have downloadable waveform data. Clean up the station list so that only stations with downloaded waveform data are included.  

```
(eq_fast) root@6006660926e5:/app/parameters/preprocess/Calipatria# python clean_station_list_Calipatria.py
```  

Need to manually arrange downloaded MSEED data into directories, with one directory per station named as:
`/app/data/20210605_Calipatria_data/waveforms${STATION_NAME}/`  

### **Preprocess**  
apply 4-12 Hz bandpass filter to all MSEED data, decimate to 25 Hz (factor of 4 for 100-sps data; factor of 8 for 200-sps data). This script will output MSEED data named with “Deci..” to be used in FAST.  

```
(eq_fast) root@6006660926e5:/app/parameters/preprocess/Calipatria# cd ../../../utils/preprocess/
(eq_fast) root@6006660926e5:/app/utils/preprocess# ../../parameters/preprocess/Calipatria/bandpass_filter_decimate_Calipatria.sh
```  

### **Fingerprint**  

43 stations, 113 channels  

```
(eq_fast) root@6006660926e5:/app/utils/preprocess# cd ../../fingerprint/
(eq_fast) root@6006660926e5:/app/fingerprint# ../parameters/fingerprint/Calipatria/run_fp_Calipatria.sh
```  

### **Similarity Search**  
Ended up not using 6 PB stations (18 channels). Now 37 stations, 95 channels  

```
(eq_fast) root@6006660926e5:/app/fingerprint# cd ../simsearch/
(eq_fast) root@6006660926e5:/app/simsearch# ../parameters/simsearch/Calipatria/run_simsearch_calipatria.sh
```  

### **Postprocessing**  

```  
(eq_fast) root@6006660926e5:/app/simsearch# cd ../postprocessing/
(eq_fast) root@6006660926e5:/app/postprocessing# ../parameters/postprocess/Calipatria/output_calipatria_pairs.sh
(eq_fast) root@6006660926e5:/app/postprocessing# ../parameters/postprocess/Calipatria/combine_calipatria_pairs.sh
```  

### **Network detection**  
If list index out of range in partition, fails to keep running -> try 1 partition  

```
(eq_fast) root@6006660926e5:/app/postprocessing# python scr_run_network_det.py ../parameters/postprocess/Calipatria/37sta_3stathresh_network_params.json
```  

### **Postprocess: Clean Network Detection Results**

```
(eq_fast) root@6006660926e5:/app/postprocessing# cd ../utils/network/
(eq_fast) root@6006660926e5:/app/utils/network# python arrange_network_detection_results.py
```  
  
Input parameter changes made to `arrange_network_detection_results.py` (from Hector Mine -> Calipatria)  

``` py linenums="4"
det_dir = ‘../../data/20210605_Calipatria_Data/network_detection/’
network_file = ‘37sta_3stathresh_detlist_rank_by_peaksum.txt’
nsta = 37
```

```
(eq_fast) root@6006660926e5:/app/utils/network# ./remove_duplicates_after_network.sh
```  
  

Input parameter changes made to `remove_duplicates_after_network.sh` (from Hector Mine -> Calipatria)  

``` py linenums="4"
cd ../../data/20210605_Calipatria_Data/network_detection/
NETWORK_FILE=NetworkDetectionTimes_37sta_3stathresh_detlist_rank_by_peaksum.txt
```

```
(eq_fast) root@6006660926e5:/app/utils/network# python delete_overlap_network_detections.py
```  
  
Input parameter changes made to `delete_overlap_network_detections.py` (from Hector Mine -> Calipatria)  

``` py linenums="4"
input_dir = ‘../../data/20210605_Calipatria_Data/network_detection/’
allfile_name = input_dir+‘uniquestart_sorted_no_duplicates.txt’
outfile_name = input_dir+‘37sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt’
n_sta = 37
```

```
(eq_fast) root@6006660926e5:/app/utils/network# ./final_network_sort_nsta_peaksum.sh
```  

  
Input parameter changes made to `final_network_sort_nsta_peaksum.sh` (from Hector Mine -> Calipatria)  

``` py linenums="4"
cd ../../data/20210605_Calipatria_Data/network_detection/
NETWORK_FILE=37sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### **Visualize the FAST output (739 events)**  

```
(eq_fast) root@6006660926e5:/app/utils/network# cat ../../data/20210605_Calipatria_Data/network_detection/sort_nsta_peaksum_37sta_3stathresh_FinalUniqueNetworkDetectionTimes.txt
```  