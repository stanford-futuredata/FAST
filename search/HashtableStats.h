#ifndef _HASHTABLE_STATS_H_
#define _HASHTABLE_STATS_H_
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

#endif // !defined(_MSC_VER)

#if __cplusplus >= 201103L
    #include <unordered_map>
    using std::unordered_map;
#else
    #include <tr1/unordered_map>
    using std::tr1::unordered_map;
#endif

#include <vector>

#define EST_NUM_ITEMS_PER_BUCKET 10

typedef std::vector<uint32_t> vec;
typedef vec::const_iterator vec_cit;
typedef unordered_map<uint64_t,vec> table;
typedef table::const_iterator table_cit;


// Count number of fingerprints in each bucket
vec CountBucketItems(table const *t);

vec CountBucketsPerTable(uint8_t ntbls, table const *t, vec *maxItemsInBucket);

vec BucketCountPerTable(uint8_t ntbls, table const *t);

//-----------------------------------------------------------------------------  

#endif // _HASHTABLE_STATS_H_
