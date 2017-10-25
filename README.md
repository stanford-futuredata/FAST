# FAST Detection Pipeline

### Fingerprint
Input time series files and fingerprint parameters are specified in a JSON format. See [sample_params.json](https://github.com/stanford-futuredata/quake/blob/master/pyFAST/fingerprint/sample_params.json) for an example. To generate fingerprints:
```
cd pyFAST/fingerprint/
python gen_fp.py sample_params.json
```
In case of processing files from multiple stations, you can generate a mapping from local to global indices for each station by passing in all JSON files used for fingerprint generation to [global_index.py](https://github.com/stanford-futuredata/quake/blob/master/pyFAST/fingerprint/global_index.py).

### Similarity Search
To compile and run the similarity search code:
```
cd FAST-new/
cmake .
make
./main
```
To change the parameters (input filename, number of hash tables, number of hash functions etc), you can run ```main``` with different command line arguments. For example
```
./main --input_fp_file=24hr.bin \
        --output_pairs_file=candidate_pairs.txt \
        --output_minhash_sigs_file=mh.bin 
```

See the full list of command line arguments through ```./main --help```
```
Allowed options:
  --help                         produce help message
  --verbose                      verbose
  --input_fp_file arg            name of input fingerprint file
  --input_minhash_sigs_file arg  name of file from which to retrieve minhash sigs
  --output_minhash_sigs_file arg name of file to store minhash sigs
  --output_pairs_file arg        name of file to store candidate pairs
  
  --ntbls arg                    Number of hash tables
  --nhash arg                    Number of hash functions
  --ncols arg                    Number of fingerprints
  --mrows arg                    Dimension of each fingerprint
  --near_repeats arg             Near repeat limit
  --num_queries arg              Number of indices to query in the similarity search
  --limit arg                    Limit
  --nvotes arg                   Number of votes
  
  --batch_size arg               Batch size to read fingerprints
  --minhash_threads              Maximum number of threads for minhash
  --simsearch_threads            Maximum number of threads for simsearch and db init
  
  --num_partitions               Number of (equally divided) partitions for similarity search (default to 5)
  --start_index                  Start fingerprint index for the all-to-some search
  --end_index                    End fingerprint index for the all-to-some search 
                                 (start_index and end_index overwrites the num_partition setting)
  --filter_file                  Name of fingerprint binary filter file (each line represents whether 
                                 the corresponding fingerprint should be put in the hash table or not)
  --noise_freq                   Frequency above which fingerprints will be filtered out 
                                 as correlated noise
```

### Postprocessing 
For performance reason, the output of the similarity search is currently in binary format. Use [parse_results.py](https://github.com/stanford-futuredata/quake/blob/master/pyFAST/postprocessing/parse_results.py) to parse and sort results in the format of [abs(idx1 - idx2), max(idx1, idx2), #hash table matched].
```
usage: parse_results.py [-h] [-d DIR] [-p PREFIX] [-t [THRESH]] [-i [IDX]]
                        [-m MEM] [--parse [PARSE]] [--sort [SORT]]
                        [-c COMBINE]
```
Once the result pairs files are partitioned and *sorted (required)* by ```[abs(idx1 - idx2), max(idx1, idx2)]```, they can be fed into the [network detection script](https://github.com/stanford-futuredata/quake/blob/master/pyFAST/postprocessing/network/scr_run_network_det.py) for postprocessing.
