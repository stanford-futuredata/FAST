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
#include "tbb/concurrent_hash_map.h"
#include "boost/dynamic_bitset.hpp"

#define EST_NUM_ITEMS_PER_BUCKET 10

typedef std::vector<uint32_t> vec;
typedef vec::const_iterator vec_cit;
typedef unordered_map<uint64_t,vec> table;
typedef tbb::concurrent_hash_map<uint32_t,uint32_t> map;
typedef map::const_iterator map_cit;
typedef table::const_iterator table_cit;
typedef table::iterator table_it;
typedef std::pair<uint64_t, vec> table_pair;

//-----------------------------------------------------------------------------
// Similarity search functions

// Populate database - place selected fingerprints in hash buckets (according to filter_fname)
void InitializeDatabase(size_t mrows, size_t ncols, uint8_t ntbls, uint8_t nhashfuncs,
        table *t, uint64_t *keys, double *out_time, const size_t num_threads,
        size_t start_indice, size_t end_indice, boost::dynamic_bitset<>* filter_flag);

// Populate database - place a range of fingerprints in hash buckets
void InitializeDatabase(size_t mrows, size_t ncols, uint8_t ntbls, uint8_t nhashfuncs,
        table *t, uint64_t *keys, double *out_time, const size_t num_threads,
        size_t start_indice, size_t end_indice);

inline void insert_new_item(table *t, uint64_t const key, uint32_t const value);


void SearchDatabase_voting(const size_t nquery, const size_t ncols, const uint32_t *query, const uint8_t ntbls,
        const uint32_t near_repeats, table *t, uint64_t const *keys,
        const size_t threshold, const size_t limit, double *out_time, 
        const std::string& out_file, const size_t num_threads, 
        const size_t start_indice, const size_t end_indice,
        boost::dynamic_bitset<>* filter_flag, double noise_freq);

//-----------------------------------------------------------------------------

#endif // _SIMILARITY_SEARCH_H_
