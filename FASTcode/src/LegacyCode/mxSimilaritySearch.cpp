/*=================================================================
 * mxSimilaritySearch.cpp
 * Similarity Search for min-Hash
 * @author Ossian O'Reilly ooreilly@stanford.edu 
 *=================================================================*/ 
#include <limits.h>
#include <assert.h>
#include "SimilaritySearch.h"
#include "MinHash.h"


void is_num_queries_consistent(int32_t const nquery, int32_t const ncols);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    
	/* Check for proper number of arguments. */
    if ( nrhs != 7 ) {
        mexErrMsgIdAndTxt("toint64:rhs",
                "This function takes five input arguments.");
    }

    //Number of values per fingerprint 
    size_t mrows = mxGetM(prhs[0]);
    //Number of fingerprints
    size_t ncols = mxGetN(prhs[0]); 

    //@todo: Perhaps we should go OOP? this is starting to look messy
    bool *fingerprints    = (bool*)mxGetLogicals(prhs[0]); // fingerprints
    UINT8_T ntbls         =    (UINT8_T)*mxGetPr(prhs[1]); // number of tables
    UINT8_T nhashfuncs    =    (UINT8_T)*mxGetPr(prhs[2]); // number of hash functions
    UINT32_T trials       =             *mxGetPr(prhs[3]); // number of trials
    uint32_t seed         =             *mxGetPr(prhs[4]); // seed for min-hash
    UINT32_T *query       =   (UINT32_T*)mxGetPr(prhs[5]); // query indices
    UINT32_T near_repeats =   (UINT32_T)*mxGetPr(prhs[6]); // number of near-repeats 

    size_t nquery = mxGetM(prhs[5]);  //number of queries
    int ntimes = ntbls*nhashfuncs;    //number of min-hash permutations

    is_num_queries_consistent(nquery,ncols);

    // Storage for min-hash signatures
    uint8_t *min_hash_sigs = new uint8_t[ncols*ntimes];
    
    // LSH Tables 
    table *t = new table[ntbls];
    UINT64_T *keys = new UINT64_T[ncols*ntbls];

    /* All unique pairs found and number of times each per is found */
    map results;         
    results.rehash(ncols*EST_NUM_ITEMS_PER_BUCKET);
    /* Filtered pairs; each pair is found at least _threshold times */
    map final_results;


    

    // Allocate time outputs
    plhs[3] = mxCreateNumericMatrix(3, 1, mxDOUBLE_CLASS, mxREAL);
    double *out_time = mxGetPr(plhs[3]);
    
    //Initialize timing
    out_time[0] = 0;   
    out_time[1] = 0;
    out_time[2] = 0;
     // Get number of items in each bucket
    vec numItemsPerBucket;

    for (int i = 0; i != trials; i++){
      // Generate min-hash signatures
      seed = seed + ncols*ntimes*i;
      MinHashMM_Block_32(fingerprints, ncols, mrows, ntimes, seed, min_hash_sigs, &out_time[0]);  
      // Populate database
      InitializeDatabase(ntimes, ncols, min_hash_sigs, ntbls, nhashfuncs,
                         t, keys, &out_time[1]);
      // Search LSH-database and store results in results
      SearchDatabase(nquery, ncols, query, ntbls, near_repeats, t, keys, &results, &out_time[2]);
      // Get number of items in each bucket
      numItemsPerBucket = CountBucketItems(t);
      // Clear LSH-database
      ClearDatabase(ntbls, t);
    }

    //------------------------------------
    
    // Get number of items in each bucket
    plhs[4] = mxCreateNumericMatrix(numItemsPerBucket.size(), 1, mxUINT32_CLASS, mxREAL);
    UINT32_T *num_ptr = (UINT32_T*)mxGetPr(plhs[4]);
    size_t i = 0;
    for(vec::iterator it = numItemsPerBucket.begin(); it != numItemsPerBucket.end(); ++it){
        num_ptr[i] = *it;
        i++;
    }


    // Start outputting data

    plhs[0] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxUINT32_CLASS); 
    plhs[1] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxUINT32_CLASS); 
    plhs[2] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxUINT32_CLASS); 
    
    // pairs (i,j) with values k
    UINT32_T *out_i = (UINT32_T*)mxGetPr(plhs[0]); 
    UINT32_T *out_j = (UINT32_T*)mxGetPr(plhs[1]); 
    UINT32_T *out_k = (UINT32_T*)mxGetPr(plhs[2]); 
    
    // Copy results to output
    i = 0;
    for(map_cit it = results.begin(); it != results.end(); ++it){
        UINT64_T key = it->first;
        UINT32_T value = it->second;
        out_i[i] = key / ncols;  // compute index i from key
        out_j[i] = key % ncols;  // compute index j from key
        out_k[i] = value;
        i++;
    }
    
    delete[] keys;
    delete[] t;

    return;
}                        

void is_num_queries_consistent(int32_t const nquery, int32_t const ncols){
    /* Check that number of query points are fewer than number of signatures to
     * hash
     * */
    if ( nquery > ncols  ) {
        mexErrMsgIdAndTxt("mxSimilaritySearch:dimensions",
                "Number of queries > Number of fingerprints!");
    }   
} 
