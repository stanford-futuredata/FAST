# FAST tutorial 

### Dataset

Raw SAC files for each station are stored under  ```data/waveforms${STATION}```. Station "HEC" has 3 components so it should have 3 time series data files; the other stations have only 1 component.

### Install 
```sh
$ cd quake
$ pip install -r requirements.txt
```

### Fingerprint
Parameters for each station is under ```parameters/fingerprint/```. To run the fingerprinting script:
```sh
$ python run_fp.py -c config.json
```

### Similarity Search
Compile and build the code for similarity search:
```sh
$ cd simsearch
$ cmake .
$ make
```

Call the wrapper script to run similarity search for all stations:
```sh
$ cd ..
$ python run_simsearch.py -c config.json
```

Alternatively, to run the similarity search for each station individually, copy the config file to the current directory, and uncomment corresponding blocks of parameters:
```sh
$ cd simsearch
$ cp ../parameters/simsearch/simsearch_input_HectorMine.sh  .
$ ./simsearch_input_HectorMine.sh
```

### Postprocessing