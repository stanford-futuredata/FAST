# Checklist for running FAST on Your Own Dataset

* Follow install instructions: [Google Colab](setup_colab.md), [Linux](setup_linux.md), or [Docker](setup_docker.md)
* [Get seismic data](get_seismic_data.md)
* Put seismic data folder in `~/FAST/data/`
* Plot sample spectrograms to decided decimate factor and min/max frequency. Python script found in `~/FAST/utils/preprocess`: `plot_sample_spectrograms.py`

![spectrogram](img/spectrogram.png)

* Check sampling rate of waveform data for decimate value

```
>>> st = read(“AZ.TONN*“)
>>> print(st)
3 Trace(s) in Stream:
AZ.TONN..HNE | 2021-06-05T00:00:00.001900Z - 2021-06-05T23:59:59.990308Z | 200.0 Hz, 17280000 samples
AZ.TONN..HNN | 2021-06-05T00:00:00.001900Z - 2021-06-05T23:59:59.990308Z | 200.0 Hz, 17280000 samples
AZ.TONN..HNZ | 2021-06-05T00:00:00.001900Z - 2021-06-05T23:59:59.990308Z | 200.0 Hz, 17280000 samples
```  

```
>>> st = read(“CI.CRR*“)
>>> print(st)
3 Trace(s) in Stream:
CI.CRR..HHE | 2021-06-05T00:00:00.008300Z - 2021-06-05T23:59:59.998300Z | 100.0 Hz, 8640000 samples
CI.CRR..HHN | 2021-06-05T00:00:00.008300Z - 2021-06-05T23:59:59.998300Z | 100.0 Hz, 8640000 samples
CI.CRR..HHZ | 2021-06-05T00:00:00.008300Z - 2021-06-05T23:59:59.998300Z | 100.0 Hz, 8640000 samples
```

* Choose sampling rate for fingerprinting:  

     * If chosen sampling rate is 25 Hz, and trace sampling rate is 200 Hz, choose a decimate factor of 8
     * If chosen sampling rate is 25 Hz, and trace sampling rate is 100 Hz, choose a decimate factor of 4  
   
* Use `~/FAST/utils/preprocess/bandpass_filter_decimate.py` and create a bash script similar to `~/FAST/utils/preprocess/mdl_bandpass_filter.sh` to filter waveforms

```
python bandpass_filter_decimate.py AZ TONN HNZ 5 12 5

# 5: min frequency
# 12: max frequency
# 5: decimate value
```

4 - 12 Hz is a good general min/max frequency range for most waveform files. The decimate value depends on the sampling rate. Follow the guide above to choose this value.

* sfsdfdsfd 