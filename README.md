# FAST

- Use ```python mat-to-txt.py [filename]``` to convert the binary fingerprint mat files to binary files.
- To compile and run:
```
cd FAST-new/
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
  --input_minhash_sigs_file arg  name of file from which to retrieve minhash
                                 sigs
  --output_minhash_sigs_file arg name of file to store minhash sigs
  --output_pairs_file arg        name of file to store candidate pairs
  --ntbls arg                    Number of hash tables
  --nhash arg                    Number of hash functions
  --ncols arg                    Number of hash functions
  --mrows arg                    Number of rows
  --near_repeats arg             Near repeat limit
  --num_queries arg              Number of indices to query in the similarity
                                 search
  --limit arg                    Limit
  --nvotes arg                   Number of votes
  --batch_size arg               Batch size to read fingerprints
  
  --minhash_threads              Maximum number of threads for minhash
  --simsearch_threads            Maximum number of threads for simsearch and db init
```
