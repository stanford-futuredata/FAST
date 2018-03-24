### Similarity Search
To compile and run the similarity search code:
```
cd simsearch/
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
  --nvotes arg                   Number of matches in hash tables
  --ncols arg                    Number of fingerprints
  --mrows arg                    Dimension of each fingerprint
  --near_repeats arg             Near repeat limit

  --batch_size arg               Batch size to read fingerprints
  --ncores                       Maximum number of processes for minhash and simsearch

  --num_partitions               Number of (equally divided) partitions for similarity search (default to 5)
  --start_index                  Start fingerprint index for the all-to-some search
  --end_index                    End fingerprint index for the all-to-some search
                                 (start_index and end_index overwrites the num_partition setting)

  --filter_file                  Name of fingerprint binary filter file (each line represents whether 
                                 the corresponding fingerprint should be put in the hash table or not)
  --noise_freq                   Frequency above which fingerprints will be filtered out 
                                 as correlated noise
```