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

#if __cplusplus >= 201103L
    #include <unordered_map>
    using std::unordered_map;
#else
    #include <tr1/unordered_map>
    using std::tr1::unordered_map;
#endif

#include <vector>
//#include <boost/unordered_map.hpp>

#define EST_NUM_ITEMS_PER_BUCKET 10

typedef std::vector<uint32_t> vec;
typedef vec::const_iterator vec_cit;
typedef unordered_map<uint64_t,vec> table;
//typedef boost::unordered_multimap<UINT64_T,UINT32_T> table;
//typedef boost::unordered_map<UINT64_T,UINT32_T> map;
typedef unordered_map<uint64_t,uint32_t> map;
typedef unordered_map<uint64_t,float> dmap;
typedef map::const_iterator map_cit;
typedef map::iterator map_it;
typedef table::const_iterator table_cit;
typedef table::iterator table_it;
typedef std::pair<uint64_t, vec> table_pair;
typedef std::pair<uint64_t, uint32_t> map_pair;

//----------------------------------------------------------------------------- 
// Similarity search functions

// Initialize database - place fingerprint indices in hash buckets
void InitializeDatabase(size_t mrows, size_t ncols,
        uint8_t ntbls, uint8_t nhashfuncs,
        table *t, uint64_t *keys, double *out_time);

inline void insert_new_item(table *t, uint64_t const key, uint32_t const value);

// Search database for query fingerprint
void SearchDatabase(size_t nquery, size_t ncols, uint32_t *query, uint8_t ntbls,
        uint32_t near_repeats, table const *t, uint64_t const *keys,
        map *results, double *out_time);

void SearchDatabase_voting(size_t nquery, size_t ncols, uint32_t *query, uint8_t ntbls,
        uint32_t near_repeats, table const *t, uint64_t *keys,
        size_t threshold, size_t limit, double *out_time);
// Update the value of a map for a given key, increment by one
size_t update(map *table, uint64_t key);

// Clears the database
void ClearDatabase(uint8_t const ntbls, table *t);

// Add similarity matrix for multiple channels
void AddSimMatrix(size_t npairs, uint64_t nfp, uint32_t const *input_i, uint32_t const *input_j,
      float const *input_k, dmap *totalMatrix, double *out_time);

// Update similarity matrix for a given key (i,j)
void UpdateSimMatrix(dmap *totalMatrix, uint64_t key, float const value);

// Output total similarity matrix for values above threshold
void ThresholdTotalSimMatrix(float thresh, dmap const * totalMatrix,
      dmap *threshMatrix, double *out_time);

// Count number of fingerprints in each bucket
vec CountBucketItems(table const *t);

vec CountBucketsPerTable(uint8_t ntbls, table const *t, vec & maxItemsInBucket);

vec BucketCountPerTable(uint8_t ntbls, table const *t);

//-----------------------------------------------------------------------------  

#endif // _SIMILARITY_SEARCH_H_
