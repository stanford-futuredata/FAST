//-----------------------------------------------------------------------------
// 
#include "MinHash.h"
#include "MurmurHash3.h"
#include <limits.h>
#include <ctime>
#include <stdlib.h>
#include <iostream>
#include "toint64.h"

#define MURMUR_HASH_LEN 4
//-----------------------------------------------------------------------------

void calculate_hash(int ny, int ntimes, uint32_t seed, uint32_t* hashes) {
   for(int i = 0; i != ny; ++i)
    for(int j = 0; j != ntimes; ++j)
      MurmurHash3_x86_32( &i, 4, seed + j, &hashes[j + i * ntimes]);
}

void MinHashMM_Block_32(boost::dynamic_bitset<> *block, int nx, int ny, int ntbls,
  int nhashfuncs, uint32_t* hashes, uint64_t *out, uint64_t *fp_index, double * out_time) {
   clock_t begin = clock();

   //For each fingerprint
   int ntimes = ntbls * nhashfuncs;
   uint64_t block_index = 0;
   uint32_t *minhash = (uint32_t *) calloc(ntimes, sizeof(uint32_t));
   uint8_t *minhash_8 = (uint8_t *) calloc(ntimes, sizeof(uint8_t));
   for (int i = 0; i < ntimes; i ++) {
      minhash[i] = UINT_MAX;
   }
   for (int i = 0; i != nx; ++i) {
       //Locate non-zero entries
       for (int j = 0; j != ny; ++j) {
           if ((bool)(*block)[block_index]) {
                for (int k =0; k < ntimes; k ++) {
                  minhash[k] = std::min(minhash[k],
                    hashes[k + j * ntimes]);
                }
           }
           block_index ++;
       }
       for (int k = 0; k < ntimes; k++) {
          minhash_8[k] = minhash[k] % 255;
          minhash[k] = UINT_MAX;
       }
       for (int j = 0; j < ntbls; j ++ ) {
          uint64_t key = toint64_16(&minhash_8[nhashfuncs * j], nhashfuncs);
          out[*fp_index] = key;
          *fp_index += 1;
       }
   } //End for each fingerprint

   free(minhash);
   free(minhash_8);
   clock_t end = clock();
   *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}


