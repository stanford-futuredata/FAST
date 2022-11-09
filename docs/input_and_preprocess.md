# **Input and Preprocessing**

## Input: Continuous Seismic Data

* SAC or MiniSEED formats  
    * Run FAST independently for each component at each station  
      * Filename should have station, component, date-time  

        !!! warning
            Filename ^^must^^ end with “.sac” or “.mseed” – if not, rename it!  

    * FAST uses ObsPy functions to read in data  

* Time gaps ok, but ^^must not be filled with 0’s^^  
    * 0’s are similar to other 0’s --> time gaps overwhelm your earthquake detections, and take forever to run  
    * Run scripts to fill 0’s with random uncorrelated noise; outputs files starting with “Filled*”  
    * `$ python fill_time_gaps_uncorrelated_noise.py` calls `detect_time_gaps.py`  
      * Need to modify for your input data  
      * **Example scripts in:** `parameters/preprocess_utils/`  

## Preprocessing

Bandpass Filter: ^^important parameter^^  

  * FAST uses short sections of spectrogram to create fingerprints  
    * Nyquist upper limit = (Sampling rate)/2  
    * Typically sampling rate is 100 Hz, but depends on data  

  * Frequencies outside passband are cut, thrown away  
  * Demean, detrend data before applying filter  


Decimate to lower sampling rate

  *  Depends on your selected filter band; usually to 50 Hz, 25 Hz, or 20 Hz  

Remove spikes and glitches (write your own script)  

**Example Python scripts in** `parameters/preprocess_utils/` (uses ObsPy):  

  * `bandpass_filter_decimate.py`, `mseed_bandpass_filter_decimate.py`
  * `SaudiMonth_bandpass_filter_decimate.sh`: calls Python script multiple times for different stations and components, different filter bands  

