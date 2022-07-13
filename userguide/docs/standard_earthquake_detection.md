# Standard Earthquake Detection: STA/LTA

<p align="center">
<mark>Ratio: Short Term Average / Long Term Average</mark>
</p>

Traditionally, an earthquake is detected at one station at a time, using an energy detector such as a short-term average (STA)/long-term average (LTA). STA/LTA computes the ratio of the STA energy in a short time window to the LTA energy in a longer time window, as these windows slide through the continuous data. A detection is declared when the STA/LTA ratio exceeds certain thresholds. An association algorithm then determines whether detections at multiple stations across the network are consistent with a seismic source. If a seismic event is detected at a minimum of four stations, it is included in an earthquake catalog, which is a database of the location, origin time, and magnitude of known earthquakes.<br>


STA/LTA successfully identifies earthquakes with impulsive, high signal-to-noise ratio (snr) P-wave and S-wave arrivals presented below. 

<br>
<p align="center">
<img src="../img/sta_s.png" width="700" height="550" align="middle">
</p>
<br>


STA/LTA rates high on general applicability, which we define as the ability to detect a wide variety of earthquakes without prior knowledge of the event waveform or source information. But STA/LTA fails to detect earthquakes, or may produce false detections, in more challenging situations such as low snr, waveforms with emergent arrivals, overlapping events, cultural noise, and sparse station spacing; thus, STA/LTA has low detection sensitivity as shown below. 

<br>
<p align="center">
<img src="../img/sta_unsuccessful.png" width="700" height="550" align="middle">
</p>
<br>

Therefore, earthquake catalogs are incomplete for lower-magnitude events. Read more <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4672764/#__sec1title" target="_blank">here</a>.