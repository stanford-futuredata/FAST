# Waveform Similarity

Many algorithms have been developed to efficiently search for similar items in massive data sets; applications include identifying similar files in a large file system, finding near-duplicate Web pages, detecting plagiarism in documents, and recognizing similar audio clips for music identification, such as in the Shazam mobile app. We can meet our objective of a fast, efficient, automated blind detection of similar earthquake waveforms in huge volumes of continuous data by leveraging scalable algorithms that are widely used in the computer science community. Seismologists are just beginning to exploit data-intensive search technologies to analyze seismograms; one recent application is an earthquake search engine for fast focal mechanism identification that retrieves a best-fit synthetic seismogram from a large database, whereas another study developed a fast-approximation algorithm to find similar event waveforms within large catalogs.

Rather than directly comparing waveforms, we first perform feature extraction to condense each waveform into a compact “fingerprint” that retains only its key discriminative features. A fingerprint serves as a proxy for a waveform; thus, two similar waveforms should have similar fingerprints, and two dissimilar waveforms should have dissimilar fingerprints. We assign the fingerprints (rather than waveforms) to LSH hash buckets.

Our approach, an algorithm that we call Fingerprint And Similarity Thresholding (FAST), builds on the Waveprint audio fingerprinting algorithm, which combines computer-vision techniques and large-scale data processing methods to match similar audio clips. We modified the Waveprint algorithm based on the properties and requirements of our specific application of detecting similar earthquakes from continuous seismic data. We chose Waveprint for its demonstrated capabilities in audio identification and its ease of mapping the technology to our application. First, an audio signal resembles a seismogram in several ways: they are both continuous time series waveform data, and the signals of interest are often nonimpulsive. Second, Waveprint computes fingerprints using short overlapping audio clips, as in autocorrelation. Third, Waveprint takes advantage of LSH to search through only a small subset of fingerprints. Waveprint also reports fast retrieval results with high accuracy, and its feature extraction steps are easily parallelizable. FAST scores high on three qualitative desirable metrics for earthquake detection methods (detection sensitivity, general applicability, and computational efficiency), whereas other earthquake detection algorithms (STA/LTA, template matching, and autocorrelation) do well on only two of the three.

Waveform similarity allows detection of smaller earthquakes.

<br>
<p align="center">
<img src="../img/supervised_matching.png" width="500" height="500" align="middle">
</p>

<br></br>
With FAST, a comprehensive, exhaustive search for earthquakes with similar waveforms is done by treating each segment of the input waveform data as a "template" for potentional eaerhquakes.

<br>
<p align="center">
<img src="../img/unsupervised_matching.png" width="500" height="500" align="middle">
</p>

<br></br>
