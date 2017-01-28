//-----------------------------------------------------------------------------
// 
#include "MinHash.h"
#include "MurmurHash3.h"
#include <limits.h>
#include <ctime>
#include <stdlib.h>
#include <iostream>
#include <pthread.h>

#define MURMUR_HASH_LEN 4
//-----------------------------------------------------------------------------


void MinHashMM_Block_32(boost::dynamic_bitset<> *block, int nx, int ny, int ntimes, uint32_t seed, uint8_t *out, double * out_time) {
   clock_t begin = clock();

   uint32_t *temp_block = (uint32_t*)malloc(ntimes * ny * sizeof(uint32_t));
   for(int i = 0; i != ny; ++i)
      for(int j = 0; j != ntimes; ++j)
        MurmurHash3_x86_32( &i, 4, seed + j, &temp_block[j + i * ntimes]);

   //For each fingerprint
   uint64_t block_index = 0;
   uint64_t fp_index = 0;
   uint32_t *minhash = (uint32_t *) calloc(ntimes, sizeof(uint32_t));
   for (int i = 0; i < ntimes; i ++) {
      minhash[i] = UINT_MAX;
   }
   for (int i = 0; i != nx; ++i) {
       //Locate non-zero entries
       for (int j = 0; j != ny; ++j) {
           if ((bool)(*block)[block_index]) {
                for (int k =0; k < ntimes; k ++) {
                  minhash[k] = std::min(minhash[k],
                    temp_block[k + j * ntimes]);
                }
           }
           block_index ++;
       }
       for (int j = 0; j < ntimes; j ++ ) {
          out[fp_index] = minhash[j] % 255;
          fp_index ++;
          minhash[j] = UINT_MAX;
       }
   } //End for each fingerprint

   free(temp_block);

   clock_t end = clock();
   *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}


