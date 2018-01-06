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

void MinHashMM_Block_32(const boost::dynamic_bitset<> &block, int nx, int ny, int ntbls, int ntotfunc,
  const uint32_t* hashes, void *out, uint64_t fp_index){

   // nnz_max  : Maximum number of non-zero bits
   int nnz_max = ny;
   int ntimes = ntbls * ntotfunc;
   uint32_t *indices = (uint32_t*)calloc(nnz_max,sizeof(uint32_t));

   //For each fingerprint
   for( int i = 0; i != nx; ++i ) {
       //Locate non-zero entries
       int nnz = 0;
       for( int j = 0; j != ny; ++j){
           //assert(j + ny*i <= nx*ny,"e1");
           //if( block[j + ny*i] == 1){
           uint64_t temp_index = static_cast<uint64_t>(j) + static_cast<uint64_t>(ny)*static_cast<uint64_t>(i);
           if((bool)block[temp_index]){
               indices[nnz] = j;
               nnz++;
           }
       }
       //Generate min-Hash signature
       for( int j = 0; j != ntimes; ++j){
            uint32_t imin = UINT_MAX; 
            for( int k = 0; k != nnz; ++k) {
                int block_index = indices[k] + j * nnz_max;
                if( hashes[block_index] < imin )
                    imin = hashes[block_index];
            }
            uint64_t temp_index = static_cast<uint64_t>(j) + static_cast<uint64_t>(i)*static_cast<uint64_t>(ntimes);
            ((uint8_t*)out)[temp_index] = imin % 255;
       }
   } //End for each fingerprint

   free(indices);

}



