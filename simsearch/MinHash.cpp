//-----------------------------------------------------------------------------
// 
#include "MinHash.h"
#include "MurmurHash3.h"
#include <limits.h>
#include <ctime>
#include <iostream>
#include <boost/functional/hash.hpp>

#define MURMUR_HASH_LEN 4
//-----------------------------------------------------------------------------

void calculate_hash(int ny, int ntimes, uint32_t seed, uint32_t* hashes) {
   for(int i = 0; i != ny; ++i)
    for(int j = 0; j != ntimes; ++j)
      MurmurHash3_x86_32( &i, 4, seed + j, &hashes[j + i * ntimes]);
}

void MinHashMM_Block_32(const boost::dynamic_bitset<> &block, int nx, int ny, int ntbls,
  int ntotfunc, const uint32_t* hashes, uint64_t *out, uint64_t fp_index) {

   //For each fingerprint
   int nhashfuncs = (ntotfunc + 1) / 2;
   int ntimes = ntbls * nhashfuncs;
   uint64_t block_index = 0;
   uint64_t offset = fp_index;
   uint32_t *minhash = (uint32_t *) calloc(ntimes, sizeof(uint32_t));
   uint32_t *maxhash = (uint32_t *) calloc(ntimes, sizeof(uint32_t));
   for (int i = 0; i < ntimes; i ++) {
      minhash[i] = UINT_MAX;
   }

   for (int i = 0; i < nx; ++i) {
       //Locate non-zero entries
       for (int j = 0; j != ny; ++j) {
           if ((bool)block[block_index]) {
                for (int k =0; k < ntimes; k ++) {
                  minhash[k] = std::min(minhash[k],
                    hashes[k + j * ntimes]);
                  maxhash[k] = std::max(maxhash[k],
                    hashes[k + j * ntimes]);
                }
           }
           block_index ++;
       }

       for (int j = 0; j < ntbls; j ++ ) {
          size_t key = 0;
          for (int k = 0; k < ntotfunc; k ++) {
            if (k < nhashfuncs) {
              boost::hash_combine(key, minhash[nhashfuncs * j + k]);
            } else {
              boost::hash_combine(key, maxhash[nhashfuncs * j + k - nhashfuncs]);
            }
          }
          out[offset] = key;
          offset += 1;
       }
       for (int k = 0; k < ntimes; k++) {
          minhash[k] = UINT_MAX;
          maxhash[k] = 0;
       }
   } //End for each fingerprint

   free(minhash);
   free(maxhash);
}


