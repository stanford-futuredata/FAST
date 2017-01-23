//-----------------------------------------------------------------------------
// 
#include "MinHash.h"
#include "MurmurHash3.h"
#include <limits.h>
#include <ctime>
#include <stdlib.h>
#include <iostream>

#define MURMUR_HASH_LEN 4
//-----------------------------------------------------------------------------
// MinHash using MurmurHash
// Estimate the probability P(Sim(X,Y)), where X and Y are two sets, and Sim is
// the Jaccard similarity.
// keys   : items to hash
// len    : number of items
// ntimes : number of times to apply the minhash
// seed   : seed for hash algorithm (see MurmurHash)
// out    : Minhash signatures, one value per for each application (ntimes) 

void MinHashMM_32( const void * keys, int len, int ntimes, uint32_t seed, 
                   void * out )
{
    const uint32_t * data = (const uint32_t*) keys;
    
    //For each permutation
    for( int i = 0; i != ntimes; ++i )
    {
        uint32_t hash; 
        uint32_t imin = UINT_MAX;
        for( int j = 0; j != len; ++j )
        {
            MurmurHash3_x86_32( &data[j], 4, seed, &hash );
            if( hash < imin )
                imin = hash;
        } 
        ((uint32_t*)out)[i] = imin;
        seed++;  
    } //End for each permutation
}


void MinHashMM_Block_32(const bool * block, int nx, int ny, int ntimes, uint32_t seed, void * out, double * out_time){

   //clock_t begin = clock();
    
   uint32_t *temp_block = (uint32_t*)calloc(ntimes*ny,sizeof(uint32_t));
   for(int i = 0; i != ny; ++i)
       for(int j = 0; j != ntimes; ++j)
            MurmurHash3_x86_32( &i, 4, seed + j, &temp_block[j + i*ntimes]);
   
    clock_t begin = clock();
   // nnz_max  : Maximum number of non-zero bits
   int nnz_max = ny;
   uint32_t *indices = (uint32_t*)calloc(nnz_max,sizeof(uint32_t)); 

   //For each fingerprint
   for( int i = 0; i != nx; ++i )
   {       
       //Locate non-zero entries
       int nnz = 0; 
       for( int j = 0; j != ny; ++j){
           //assert(j + ny*i <= nx*ny,"e1");
           //if( block[j + ny*i] == 1){
	   uint64_t temp_index = static_cast<uint64_t>(j) + static_cast<uint64_t>(ny)*static_cast<uint64_t>(i);
           if( block[temp_index] == 1){
               indices[nnz] = j;
               nnz++;
           }
       }
       //Generate min-Hash signature
       for( int j = 0; j != ntimes; ++j){
            uint32_t imin = UINT_MAX; 
            for( int k = 0; k != nnz; ++k)
            {
                int block_index = indices[k] + j*nnz_max;
                //assert(block_index <= ntimes*ny,"e2");
                if( temp_block[block_index] < imin )
                    imin = temp_block[block_index];
            } 
            //assert(nx*ny*ntimes >= j + i*ntimes,"e3");
            //((uint8_t*)out)[j + i*ntimes] = imin % 255;
	    uint64_t temp_index = static_cast<uint64_t>(j) + static_cast<uint64_t>(i)*static_cast<uint64_t>(ntimes);
            ((uint8_t*)out)[temp_index] = imin % 255;
       }
   } //End for each fingerprint

   free(indices);
   free(temp_block);
    
   clock_t end = clock();
   *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}


