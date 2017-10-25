/*=================================================================
 * mxAddSimilarityMatrix.cpp
 * Add similarity matrix from multiple channels
 * @author Clara Yoon ceyoon@stanford.edu 
 *=================================================================*/ 
#include <iostream>
#include "../SimilaritySearch/SimilaritySearch.h"

dmap totalMatrix;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
   // Check for proper number of arguments
   if (nrhs != 6)
   {
      mexErrMsgIdAndTxt("mxAddSimilarityMatrix:", "This function takes 6 input arguments");
   }

   // Number of pairs
   size_t npairs = mxGetM(prhs[0]);

   // Fingerprint pairs with similarity, for all channels
   UINT32_T *input_i = (UINT32_T *)mxGetPr(prhs[0]); // index of first fingerprint in pair
   UINT32_T *input_j = (UINT32_T *)mxGetPr(prhs[1]); // index of second fingerprint in pair
   float *input_k = (float *)mxGetPr(prhs[2]); // similarity metric (fraction of hash tables)
   UINT64_T nfp = (UINT64_T)*mxGetPr(prhs[3]); // number of fingerprints
   float thresh = (float)*mxGetPr(prhs[4]); // threshold for total similarity matrix
   int mode = (int)*mxGetPr(prhs[5]);  // mode (0: add, or 1: threshold)
  
   // Mode 0: Add similarity matrix from each channel
   if (mode == 0)
   {
      mexLock();

      // Allocate time output
      plhs[0] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, mxREAL);
      double *out_time = mxGetPr(plhs[0]);

      // Initialize timing
      *out_time = 0.0; // Add similarity matrix from each channel

      // Store total similarity matrix as a dmap: unordered_map<UINT64_T, float>
      AddSimMatrix(npairs, nfp, input_i, input_j, input_k, &totalMatrix, out_time);
      std::cout << "totalMatrix.size = " << totalMatrix.size() << std::endl;
   }

   // Mode 1: Threshold total similarity matrix
   if (mode == 1)
   {
      // Allocate time output
      plhs[0] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, mxREAL);
      double *out_time = mxGetPr(plhs[0]);
   
      // Initialize timing
      *out_time = 0.0; // Threshold total similarity matrix

      dmap threshMatrix;
      ThresholdTotalSimMatrix(thresh, &totalMatrix, &threshMatrix, out_time);
      std::cout << "threshMatrix.size = " << threshMatrix.size() << std::endl;
      totalMatrix.clear();

      // Output data
      plhs[1] = mxCreateNumericMatrix(threshMatrix.size(), 1, mxUINT32_CLASS, mxREAL);
      plhs[2] = mxCreateNumericMatrix(threshMatrix.size(), 1, mxUINT32_CLASS, mxREAL);
      plhs[3] = mxCreateNumericMatrix(threshMatrix.size(), 1, mxSINGLE_CLASS, mxREAL);

      UINT32_T *out_i = (UINT32_T *)mxGetPr(plhs[1]);
      UINT32_T *out_j = (UINT32_T *)mxGetPr(plhs[2]);
      float *out_k = (float *)mxGetPr(plhs[3]);

      // Copy results to output
      size_t i = 0;
      for (dmap::const_iterator it = threshMatrix.begin(); it != threshMatrix.end(); ++it)
      {
	 UINT64_T key = it->first;
	 out_i[i] = static_cast<UINT32_T>(key / nfp); // compute index i (first fingerprint) from key
	 out_j[i] = static_cast<UINT32_T>(key % nfp); // compute index j (second fingerprint) from key
	 out_k[i] = it->second;
	 ++i;
      }
      threshMatrix.clear();

      mexUnlock();
   }
}
