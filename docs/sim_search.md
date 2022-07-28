# **Similarity Search**  

![simsearch_overview](img/simsearch_overview.png)  

## Hashing  

### Min-Hash*

![minhash](img/minhash.png)

### **Example:** Min-Hash Signature (MHS)  

![minhash_prob](img/mh_prob.png)

![minhash_ex](img/minh_ex.png)

### LSH* Example: Constructing Database

![lsh_ex](img/lsh_ex.png)

### Similarity Search in Fingerprint Database

![simsearch_database](img/simsearch_database.png)

### Probability of Detection  

![prob_detection](img/prob_detection.png)  

```
    "lsh_param": {
        "ntbl": 100,        # b: Number of hash tables  
        "nhash": 4,         # r: Number of hash functions per table  
        "nvote": 2,         # v: Number of votes  
        "nthread": 8,       # Number of threads for parallel processing  
        "npart": 1,         # Number of partitions for the database  
        "repeat": 5         # Near-repeat exclusion parameter (samples)  
    },
```

![jaccard_sim](img/jaccard_sim.png)  

<figcaption> Jaccard Similarity</figcaption>  

### LSH Parameter Guidance  

* `ntbl` (b): Number of hash tables
    * **100** is good default value

* `nhash` (r): Number of hash functions per table  
    * ^^Most sensitive parameter; significant effect on detection performance^^  
    * **Lower values:** fewer missed detections, more false detections, longer runtime  
    * **Higher values:** more missed detections, fewer false detections, shorter runtime  
    * Suggested values (only possibilities are 1,2,3,4,5,6,7,8):  
        * `nhash`=4 for shorter duration data sets (days – weeks)  
        * `nhash`=5 for longer data sets (months – year)  
        * `nhash`=6 for longest data sets (5-10 years)  

* `nvote` (v): Number of votes (pair of similar fingerprints must be in same hash bucket in at least v out of b hash tables)  
    * Can use `nvote` as threshold for single station detection  
    * `nvote`=2 is good starting value; initially set low, can increase threshold later during network detection  

* `repeat`: Near-repeat exclusion parameter  
    * Avoid detecting any fingerprint with itself (or slight offset to itself), which is guaranteed to be similar  
    * 5 samples is good default value (Multiply by `dt_fp` to get value in seconds)  