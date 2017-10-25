/*=================================================================
 * min-Hash using Murmurhash
 * @author Ossian O'Reilly
 *=================================================================*/ 
#include "mex.h"
#include "MinHash.h"
#include "MurmurHash3.h"

#define assert( isOK )        ( (isOK) ? (void)0 : (void) mexErrMsgTxt("assert failed\n") )

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {                    

	/* Check for proper number of arguments. */
    if ( nrhs != 3 ) {
        mexErrMsgIdAndTxt("Minhash:rhs",
                "This function takes three input arguments.");
    }
    
    size_t mrows = mxGetM(prhs[0]);  //Number of values
    size_t ncols = mxGetN(prhs[0]);  //Number of fingerprints
    
    /* Get keys to hash */ 
    bool *keys = (bool*)mxGetLogicals(prhs[0]);

    /* Get number of permutations to do */
    int ntimes = *mxGetPr(prhs[1]); 

    /* Get seed for hash */
    uint32_t seed = *mxGetPr(prhs[2]);

    /* Create a local array and start min-Hashing */
    plhs[0] = mxCreateNumericMatrix(ntimes, ncols, mxUINT8_CLASS, mxREAL);
    uint8_t *out = (uint8_t*)mxGetPr(plhs[0]);  
    MinHashMM_Block_32(keys, ncols, mrows, ntimes, seed, out);
   
    return;
}                     
