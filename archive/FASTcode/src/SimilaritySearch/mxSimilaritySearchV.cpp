/*=================================================================
 * mxSimilaritySearch.cpp
 * Similarity Search for min-Hash
 * @author Ossian O'Reilly ooreilly@stanford.edu 
 *=================================================================*/ 
#include <limits.h>
#include <assert.h>
#include "SimilaritySearch.h"
#include "MinHash.h"

table *t = NULL;
UINT64_T *keys = NULL;


void is_num_queries_consistent(int32_t const nquery, int32_t const ncols);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    
	/* Check for proper number of arguments. */
    if ( nrhs != 10 ) {
        mexErrMsgIdAndTxt("mxSimilaritySearch:",
                "This function takes ten input arguments.");
    }

    //Number of values per fingerprint 
    size_t mrows = mxGetM(prhs[0]);
    //Number of fingerprints
    size_t ncols = mxGetN(prhs[0]); 

    //@todo: Perhaps we should go OOP? this is starting to look messy
    bool *fingerprints    = (bool*)mxGetLogicals(prhs[0]); // fingerprints
    UINT32_T nfp          =   (UINT32_T)*mxGetPr(prhs[1]); // number of fingerprints
    UINT8_T ntbls         =    (UINT8_T)*mxGetPr(prhs[2]); // number of tables
    UINT8_T nhashfuncs    =    (UINT8_T)*mxGetPr(prhs[3]); // number of hash functions
    uint32_t seed         =             *mxGetPr(prhs[4]); // seed for min-hash
    UINT32_T *query       =   (UINT32_T*)mxGetPr(prhs[5]); // query indices
    UINT32_T near_repeats =   (UINT32_T)*mxGetPr(prhs[6]); // number of near-repeats 
    UINT32_T threshold    =   (UINT32_T)*mxGetPr(prhs[7]); // number of votes 
    UINT32_T limit        =   (UINT32_T)*mxGetPr(prhs[8]); // maximum elements to retrieve from a bucket
    int      mode         =       (int)*mxGetPr(prhs[9]);  // mode (index, or search)

    // Get number of items in each bucket
    vec numItemsPerBucket;
    if(mode == 0){
        if (nfp != ncols) {
  	   mexErrMsgIdAndTxt("mxSimilaritySearch:", "Number of fingerprints does not match");
        }

        mexLock();
        t = new table[ntbls];
        keys = new UINT64_T[ncols*ntbls];

        // Storage for min-hash signatures
        int ntimes = ntbls*nhashfuncs;    //number of min-hash permutations
        uint8_t *min_hash_sigs = new uint8_t[ncols*ntimes];
    
        // Allocate time outputs
        plhs[0] = mxCreateNumericMatrix(3, 1, mxDOUBLE_CLASS, mxREAL);
        double *out_time = mxGetPr(plhs[0]);
        
        //Initialize timing
        out_time[0] = 0; // MinHash  
        out_time[1] = 0; // Populate

        MinHashMM_Block_32(fingerprints, ncols, mrows, ntimes, seed, min_hash_sigs, &out_time[0]);  
        // Populate database
        InitializeDatabase(ntimes, ncols, min_hash_sigs, ntbls, nhashfuncs,
                           t, keys, &out_time[1]);
    	
	delete[] min_hash_sigs;
    }
    
    if(mode == 1){
    
        size_t nquery = mxGetM(prhs[5]);  //number of queries
        is_num_queries_consistent(nquery,nfp);

        if(t == NULL){
            mexErrMsgTxt("Database has not been initialized.");  
        }
        // Search LSH-database and store results in results
        double out_time_ = 0;
        // All unique pairs found and number of times each per is found 
        map results;
        SearchDatabase_voting(nquery, nfp, query, ntbls, near_repeats, t, keys, &results, threshold, limit, &out_time_);
        
	// Get number of buckets per table
	vec maxItemsInBucket;
	vec numBucketsPerTable = CountBucketsPerTable(ntbls, t, maxItemsInBucket);


        // Start outputting data
        plhs[0] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxREAL); 
        plhs[1] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxREAL); 
        plhs[2] = mxCreateNumericMatrix(results.size(), 1, mxUINT32_CLASS, mxREAL); 
        plhs[3] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, mxREAL);
        plhs[4] = mxCreateNumericMatrix(numBucketsPerTable.size(), 1, mxUINT32_CLASS, mxREAL);
        plhs[5] = mxCreateNumericMatrix(maxItemsInBucket.size(), 1, mxUINT32_CLASS, mxREAL);
        
        // pairs (i,j) with values k
        UINT32_T *out_i = (UINT32_T*)mxGetPr(plhs[0]); 
        UINT32_T *out_j = (UINT32_T*)mxGetPr(plhs[1]); 
        UINT32_T *out_k = (UINT32_T*)mxGetPr(plhs[2]); 
        double *out_time = (double*)mxGetPr(plhs[3]);
       UINT32_T *num_ptr = (UINT32_T*)mxGetPr(plhs[4]);
       UINT32_T *max_ptr = (UINT32_T*)mxGetPr(plhs[5]);

        
        // Timing
        *out_time = out_time_;
        
        // Copy results to output
        size_t i = 0;
        for(map_cit it = results.begin(); it != results.end(); ++it){
            UINT64_T key = it->first;
            UINT32_T value = it->second;
            out_i[i] = key / nfp;  // compute index i from key
            out_j[i] = key % nfp;  // compute index j from key
            out_k[i] = value;
            i++;
        }
       
        //------------------------------------
        
	// Get bucket data
	for (size_t i = 0; i < ntbls; ++i)
	{
	   num_ptr[i] = numBucketsPerTable[i];
	   max_ptr[i] = maxItemsInBucket[i];
	}
    

    }

    if(mode == 2){
        
        if(t == NULL){
            mexErrMsgTxt("Database has not been initialized.");  
        }

        mexUnlock();

        // Clear LSH-database
        ClearDatabase(ntbls, t);
        delete[] keys;
        delete[] t;
    }

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
