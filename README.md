# FAST

- To compile and run:
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
For performance reason, the output of the similarity search is currently in binary format. Use ```python parse_results.py [output filename]``` to parse results in the format of [index 1, index 2, #hash table matched].

See the full list of command line arguments through ```./main --help```
```
Allowed options:
  --help                         produce help message
  --verbose                      verbose
  --input_fp_file arg            name of input fingerprint file
  --input_minhash_sigs_file arg  name of file from which to retrieve minhash
                                 sigs
  --output_minhash_sigs_file arg name of file to store minhash sigs
  --output_pairs_file arg        name of file to store candidate pairs
  --ntbls arg                    Number of hash tables
  --nhash arg                    Number of hash functions
  --ncols arg                    Number of fingerprints
  --mrows arg                    Dimension of each fingerprint
  --near_repeats arg             Near repeat limit
  --num_queries arg              Number of indices to query in the similarity
                                 search
  --limit arg                    Limit
  --nvotes arg                   Number of votes
  --batch_size arg               Batch size to read fingerprints
  
  --minhash_threads              Maximum number of threads for minhash
  --simsearch_threads            Maximum number of threads for simsearch and db init
  
  --num_partitions               Number of (equally divided) partitions for similarity search, default is 5
  --start_index                  Start fingerprint index for the all-to-some search
  --end_index                    End fingerprint index for the all-to-some search 
                                 (start_index and end_index overwrites the num_partition setting)
  --filter_file                  Name of fingerprint binary filter file (each line represents whether 
                                 the corresponding fingerprint should be put in the hash table or not)
```
