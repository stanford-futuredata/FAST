#ifndef _MINHASH_H_
#define _MINHASH_H_
//-----------------------------------------------------------------------------
// Platform-specific functions and macros

// Microsoft Visual Studio

#if defined(_MSC_VER)

typedef unsigned char uint8_t;
typedef unsigned long uint32_t;
typedef unsigned __int64 uint64_t;

// Other compilers

#else   // defined(_MSC_VER)

#include <stdint.h>
#include <stdbool.h>
#include "boost/dynamic_bitset.hpp"

#endif // !defined(_MSC_VER)

//----------------------------------------------------------------------------- 
void calculate_hash(int ny, int ntimes, uint32_t seed, uint32_t* hashes);
void MinHashMM_Block_32(const boost::dynamic_bitset<> &block, int nx, int ny, int ntbls, int nhashfunc,
	const uint32_t* hashes, uint64_t *out, uint64_t fp_index);
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// MinHash using Textbook hash

//TODO: NOT YET IMPLEMENTED
//void MinHashTB_64( const void * key, int len, int ntimes, uint32_t seed, void * out );

//TODO: NOT YET IMPLEMENTED
//void MinHashTB_32( const void * key, int len, int ntimes, uint32_t seed, void * out );

//----------------------------------------------------------------------------- 


#endif // _MINHASH_H_
