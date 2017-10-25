#ifndef _SIMILARITY_SEARCH_H_
#define _SIMILARITY_SEARCH_H_
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

#include "mex.h"
#include <tr1/unordered_map>
#include <vector>
//#include <boost/unordered_map.hpp>

#define EST_NUM_ITEMS_PER_BUCKET 10

typedef std::vector<UINT32_T> vec;
typedef vec::const_iterator vec_cit;
typedef std::tr1::unordered_map<UINT64_T,vec> table;
//typedef boost::unordered_multimap<UINT64_T,UINT32_T> table;
//typedef boost::unordered_map<UINT64_T,UINT32_T> map;
typedef std::tr1::unordered_map<UINT64_T,UINT32_T> map;
typedef std::tr1::unordered_map<UINT64_T,float> dmap;
typedef map::const_iterator map_cit;
typedef map::iterator map_it;
typedef table::const_iterator table_cit;
typedef table::iterator table_it;
typedef std::pair<UINT64_T, vec> table_pair;
typedef std::pair<uint64_t, uint32_t> map_pair;

//----------------------------------------------------------------------------- 
// Similarity search functions

// Initialize database - place fingerprint indices in hash buckets
void InitializeDatabase(size_t mrows, size_t ncols, UINT8_T const *vals,
        UINT8_T ntbls, UINT8_T nhashfuncs,
        table *t, UINT64_T *keys, double *out_time);

inline void insert_new_item(table *t, uint64_t const key, uint32_t const value);

// Search database for query fingerprint
void SearchDatabase(size_t nquery, size_t ncols, UINT32_T *query, UINT8_T ntbls,
        UINT32_T near_repeats, table const *t, UINT64_T const *keys,
        map *results, double *out_time);

void SearchDatabase_voting(size_t nquery, size_t ncols, UINT32_T *query, UINT8_T ntbls,
        UINT32_T near_repeats, table const *t, UINT64_T const *keys,
        map *results, size_t threshold, size_t limit, double *out_time);
// Update the value of a map for a given key, increment by one
size_t update(map *table, uint64_t key, uint32_t const value);
// Update the value of a map for a given key, initialize to value 
size_t update_results(map *table, uint64_t key, uint32_t const value);

// Clears the database
void ClearDatabase(uint8_t const ntbls, table *t);

// Add similarity matrix for multiple channels
void AddSimMatrix(size_t npairs, UINT64_T nfp, UINT32_T const *input_i, UINT32_T const *input_j,
      float const *input_k, dmap *totalMatrix, double *out_time);

// Update similarity matrix for a given key (i,j)
void UpdateSimMatrix(dmap *totalMatrix, uint64_t key, float const value);

// Output total similarity matrix for values above threshold
void ThresholdTotalSimMatrix(float thresh, dmap const * totalMatrix,
      dmap *threshMatrix, double *out_time);
      

// Count number of fingerprints in each bucket
vec CountBucketItems(table const *t);

vec CountBucketsPerTable(UINT8_T ntbls, table const *t, vec & maxItemsInBucket);

vec BucketCountPerTable(UINT8_T ntbls, table const *t);

//-----------------------------------------------------------------------------  

#endif // _SIMILARITY_SEARCH_H_
