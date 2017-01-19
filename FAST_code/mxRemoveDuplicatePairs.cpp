/*=================================================================
 * mxRemoveDuplicatePairs.cpp
 * Remove duplicate pairs
 * @author Clara Yoon ceyoon@stanford.edu 
 *=================================================================*/ 
#include <iostream>
#include <map>
#include <utility>
#include <vector>

#include <stdint.h>

#include "mex.h"

typedef struct
{
   int32_t i;
   int32_t j;
   float k;
} DetPair;

typedef std::pair<uint32_t, uint32_t> item_upair;

// Function definition
bool FoundSimilarIndex_i(int32_t index, uint32_t skip_samples, std::vector<DetPair> const & topPairs)
{
   bool foundSimIndex = false;
   for (std::vector<DetPair>::const_iterator it = topPairs.begin(); it != topPairs.end(); ++it)
   {
      uint32_t diff = abs(it->i - index);
      if (diff < skip_samples)
      {
	 foundSimIndex = true;
	 break;
      }
   }
   return foundSimIndex;
}

// Function definition
bool FoundSimilarIndex_j(int32_t index, uint32_t skip_samples, std::vector<DetPair> const & topPairs)
{
   bool foundSimIndex = false;
   for (std::vector<DetPair>::const_iterator it = topPairs.begin(); it != topPairs.end(); ++it)
   {
      uint32_t diff = abs(it->j - index);
      if (diff < skip_samples)
      {
	 foundSimIndex = true;
	 break;
      }
   }
   return foundSimIndex;
}

// // Check i and j at same time. Slower, but do this if we want to preserve similar pairs.
// bool FoundSimilarIndex(int32_t index_i, int32_t index_j, uint32_t skip_samples, std::vector<DetPair> const & topPairs)
// {
//    bool foundSimIndex = false;
//    for (std::vector<DetPair>::const_iterator it = topPairs.begin(); it != topPairs.end(); ++it)
//    {
//       uint32_t diff_i = abs(it->i - index_i);
//       uint32_t diff_j = abs(it->j - index_j);
//       if ((diff_i < skip_samples) && (diff_j < skip_samples))
//       {
// 	 foundSimIndex = true;
// 	 break;
//       }
//    }
//    return foundSimIndex;
// }


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
   // Check for proper number of arguments
   if (nrhs != 4)
   {
      mexErrMsgIdAndTxt("mxRemoveDuplicatePairs:", "This function takes 4 input arguments");
   }

   // Number of pairs
   size_t npairs = mxGetM(prhs[0]);
   
   // Fingerprint pairs with similarity, for all channels
   UINT32_T *input_i = (UINT32_T *)mxGetPr(prhs[0]); // index of first fingerprint in pair
   UINT32_T *input_j = (UINT32_T *)mxGetPr(prhs[1]); // index of second fingerprint in pair
   float *input_k = (float *)mxGetPr(prhs[2]); // similarity metric (fraction of hash tables)
   UINT32_T skip_samples = (UINT32_T)*mxGetPr(prhs[3]); // consider as duplicate if within skip_samples

   std::cout << "npairs = " << npairs << std::endl;
   std::cout << "skip_samples = " << skip_samples << std::endl;


   // Create map of all pairs
   std::multimap<float, item_upair> allPairs;
   for (size_t k = 0; k < npairs; ++k)
   {
      item_upair thispair(input_i[k], input_j[k]);
      allPairs.insert(std::pair<float, item_upair>(input_k[k], thispair));
   }
   std::cout << "allPairs.size() = " << allPairs.size() << std::endl;
  

   // Keep only top pairs (remove duplicate pairs)
   std::vector<DetPair> topPairs;
   for (std::multimap<float, item_upair>::const_iterator it = allPairs.end(); it != allPairs.begin(); )
   {
      --it;
      int32_t ind_i = static_cast<int32_t>((it->second).first);
      int32_t ind_j = static_cast<int32_t>((it->second).second);

      bool found_sim_i = FoundSimilarIndex_i(ind_i, skip_samples, topPairs);
      bool found_sim_j = FoundSimilarIndex_j(ind_j, skip_samples, topPairs);

      if (found_sim_i && found_sim_j)
      {
	 continue;
      }
      else
      {
	 DetPair newPair;
	 newPair.i = ind_i;
	 newPair.j = ind_j;
	 newPair.k = it->first;
	 topPairs.push_back(newPair);
      }
   }
   std::cout << "topPairs.size() = " << topPairs.size() << std::endl;

   // Output data
   plhs[0] = mxCreateNumericMatrix(topPairs.size(), 1, mxINT32_CLASS, mxREAL);
   plhs[1] = mxCreateNumericMatrix(topPairs.size(), 1, mxINT32_CLASS, mxREAL);
   plhs[2] = mxCreateNumericMatrix(topPairs.size(), 1, mxSINGLE_CLASS, mxREAL);

   INT32_T *out_i = (INT32_T *)mxGetPr(plhs[0]);
   INT32_T *out_j = (INT32_T *)mxGetPr(plhs[1]);
   float *out_k = (float *)mxGetPr(plhs[2]);

   // Copy results to output
   size_t i = 0;
   for (std::vector<DetPair>::const_iterator it = topPairs.begin(); it != topPairs.end(); ++it)
   {
      out_i[i] = it->i;
      out_j[i] = it->j;
      out_k[i] = it->k;
      ++i;
   }

}
