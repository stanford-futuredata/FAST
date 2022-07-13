# What is FAST?

FAST is an end-to-end and unsupervised earthquake detection pipeline—-it does not require any examples of known event waveforms or waveform characteristics for detection. This allows FAST to discover new earthquake sources, even if template waveforms (training data) is not available. It takes continuous seismic data from multiple stations as input and outputs a list of time stamps for potential detections. FAST draws on techniques used by content-based audio recognition systems (like the <a href="https://www.toptal.com/algorithms/shazam-it-music-processing-fingerprinting-and-recognition" target="_blank">Shazam app</a>, or Google's <a href="https://www.sciencedirect.com/science/article/abs/pii/S0031320308001702?via%3Dihub" target="_blank">Waveprint</a> algorithm), and adapts these methods for the unique characteristics of seismic waveform data. 

<br>
<p align="center">
<img src="../img/audio_seismic_signals.png" width="800" height="750" align="middle">
</p>

It was designed to complement existing energy-based detection methods like STA/LTA in order to find previously unknown earthquakes, especially small earthquakes, in seismic data.

<br>

![image](img/what-is-fast.png){: style="float: right; width: 200px; height: 400px;"}
<br></br>
<p>The image to the right gives an overview of the FAST pipeline, which involves gathering continuous seismic data, preprocessing the data with a bandpass filter, running FAST for feature extraction to get binary fingerprints, running a similarity search with MinHash and Locality Sensitive Hashing, post-processing to identify events and clean up the data, and outputting the detection results.<p>

<br></br>
<br></br>
<br></br>
<br></br>
<!-- <img src="../img/what-is-fast.png" width="200" height="25" align="right"> -->

