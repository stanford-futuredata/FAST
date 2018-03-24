### Postprocessing 
For performance reason, the output of the similarity search is currently in binary format. Use `parse_results.py` to parse and sort results in the format of [abs(idx1 - idx2), max(idx1, idx2), #hash table matched].
```
usage: parse_results.py [-h] [-d DIR] [-p PREFIX] [-t [THRESH]] [-i [IDX]]
                        [-m MEM] [--parse [PARSE]] [--sort [SORT]]
                        [-c COMBINE]
```
Once the result pairs files are partitioned and *sorted (required)* by ```[abs(idx1 - idx2), max(idx1, idx2)]```, they can be fed into the network detection script for postprocessing.
