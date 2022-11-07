# FAST  

![fast_index](docs/img/fast_index_page.png)  

**FAST** is an end-to-end and unsupervised earthquake detection pipeline. It is a useful tool for seismologists to extract more small earthquakes from continuous seismic data. FAST is able to run on different machines by using Google Colab, Linux, or Docker.  

* To run FAST with Google Colab, click [here](https://ttapparo.github.io/FAST/setup_colab/) for the tutorial.  

* To run FAST with Linux, click [here](https://ttapparo.github.io/FAST/setup_linux/) for the tutorial.  

* To run FAST with Docker, click [here](https://ttapparo.github.io/FAST/setup_docker/) for the tutorial.  

Check out the [user guide](https://ttapparo.github.io/FAST/) to learn more about FAST and how to use it on your own dataset.  

**FAST User Guide Contents**
------------
1.  [FAST Overview](https://ttapparo.github.io/FAST/fast_overview/)  
   **Click here for a summary of the FAST algorithm and why you might want to use it on your seismic data.**

2.  Install  
    **Go here to learn how to install and run the FAST software on your computer.**

    1.  [Google Colab](https://ttapparo.github.io/FAST/setup_colab/)  

    2.  [Linux](https://ttapparo.github.io/FAST/setup_linux/)  

    3.  [Docker](https://ttapparo.github.io/FAST/setup_docker/)  

3.  [Tutorial](https://ttapparo.github.io/FAST/tutorial/)  
    **Learn how FAST detects earthquakes on the Hector Mine data set.**  

4.  How to Set Parameters  
    **Click here to learn how to test FAST on your own data sets.**  

    1.  [FAST Checklist](https://ttapparo.github.io/FAST/FAST_checklist/)  

    2.  [Getting Seismic Data](https://ttapparo.github.io/FAST/get_seismic_data/)  
   
    3.  [Input and Preprocessing](https://ttapparo.github.io/FAST/input_and_preprocess/)  

    4.  [Fingerprint](https://ttapparo.github.io/FAST/f_p/)  

    5.  [Similarity Search](https://ttapparo.github.io/FAST/sim_search/)  

    6.  [Network Detection](https://ttapparo.github.io/FAST/network_detection/)

    7.  [FAST Output](https://ttapparo.github.io/FAST/FAST_output/)  

    8.  [Phase Picking](https://ttapparo.github.io/FAST/phase_picking/)  

    9.  [Earthquake Location](https://ttapparo.github.io/FAST/earthquake_location/)  

    10. [Example Parameters](https://ttapparo.github.io/FAST/ex_params_intro/)  
        **Click here to see data sets FAST has been used on to detect earthquakes.**

5.  [References](https://ttapparo.github.io/FAST/references/)  
    **Read publications about FAST here.**

### References
You can find more details about the pipeline and guidelines for setting parameters in our extended [user guide](https://github.com/stanford-futuredata/quake/blob/master/FAST_userguide_v0.pdf). You may also check out the following papers:
+ **FAST Overview:** [Earthquake detection through computationally efficient similarity search](http://advances.sciencemag.org/content/1/11/e1501057)
+ **Fingerprint Overview:** [Scalable Similarity Search in Seismology: A New Approach to Large-Scale Earthquake Detection](https://link.springer.com/chapter/10.1007/978-3-319-46759-7_23)
+ **Fingerprint Benchmark:** [Earthquake Fingerprints: Extracting Waveform Features for Similarity-Based EarthquakeDetection](https://rdcu.be/8PqQ)
+ **Network Detection:** [Detecting Earthquakes over a Seismic Network using Single-Station Similarity Measures](https://doi.org/10.1093/gji/ggy100)
+ **FAST Application:** [Seismicity During the Initial Stages of the Guy‐Greenbrier, Arkansas, Earthquake Sequence](https://doi.org/10.1002/2017JB014946)
+ **Implementation and Performance:** [Locality-Sensitive Hashing for Earthquake Detection: A Case Study Scaling Data-Driven Science](http://www.vldb.org/pvldb/vol11/p1674-rong.pdf)
