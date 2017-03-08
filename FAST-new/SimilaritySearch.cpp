#include <ctime>
#include <cmath>
#include <iostream>
#include <fstream>
#include "toint64.h"
#include "SimilaritySearch.h"

// Populate database - place fingerprint indices in hash buckets
void InitializeDatabase(size_t mrows, size_t ncols, uint8_t ntbls, uint8_t nhashfuncs,
        table *t, uint64_t *keys, double *out_time) {
    clock_t begin = clock();

    //Insert pairs (key, id) into hash tables
    for(size_t i = 0; i != ncols; ++i){
        for(size_t j = 0; j != ntbls; ++j){
            insert_new_item(&t[j], keys[j + i * ntbls], i);
        }
    }
    clock_t end = clock();
    *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}


inline void insert_new_item(table *t, uint64_t const key, uint32_t const value) {
    table_it pt = t->find(key);
    // Increment value
    if(pt != t->end())
        pt->second.push_back(value);
    else {
        vec val(1,value);
        table_pair data(key, val);
        t->insert(data);
    }
}

// Search database for query fingerprint
void SearchDatabase(size_t nquery, size_t ncols, uint32_t *query, uint8_t ntbls,
        uint32_t near_repeats, table const *t, uint64_t const *keys,
        map *results, double *out_time) {
    clock_t begin = clock();

    //Search
    for (size_t i = 0; i != nquery; ++i) {
        uint32_t query_index = query[i]-1; //subtract 1 to convert 1-indexing to 0-indexing

        for(size_t j = 0; j != ntbls; ++j) {
            table const *t1 = &t[j];

            table_cit its = t1->find((uint64_t)keys[j + query_index*ntbls]);

            //Add all matches that are not near-repeats
            for(vec_cit it = its->second.begin(); it != its->second.end(); ++it){
                if(fabs((int)(*it)- (int)query_index) >= near_repeats){
                    int i = query_index;
                    int j = *it;
                    int p = std::min(i,j);
                    int q = std::max(i,j);
                    uint64_t key = p + q*ncols;
                    map_it count = results->find(key);
                    // Check if this pair has been added before,
                    // if so increment the counter for the pair
                    if(count != results->end()){
                        count->second++;
                    } else {
                        uint32_t const value = 1;
                        map_pair data(key,value);
                        results->insert(data);
                    }
                }
            }
        }

    }
    clock_t end = clock();
    *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}

// Search Database with voting
void SearchDatabase_voting(size_t nquery, size_t ncols, uint32_t *query, uint8_t ntbls,
        uint32_t near_repeats, table *t, uint64_t const *keys,
        size_t threshold, size_t limit, double *out_time, const std::string& out_file)
{
    clock_t begin = clock();

    //Search
    //ShrinkDatabase(t, ntbls);
    std::ofstream ofile (out_file);
    for(size_t i = 0; i != nquery; ++i){
        uint32_t query_index = query[i];
        map votes;
        size_t j;
        for(j = 0; j < ntbls; ++j){
            table const *t1 = &t[j];
            size_t this_key = keys[j + query_index*ntbls];
            table_cit its = t1->find((uint64_t)this_key);
            size_t num_items = its->second.size();
            //if (num_items > 50) { continue; }
            size_t l = std::min(num_items,limit);
            //Add all matches that are not near-repeats
            vec_cit it = its->second.begin();
            for(size_t k = 0; k != l; ++k) {
                int i = query_index;
                int j = *it;
                if(i >= j && fabs(i - j) >= near_repeats) {
                    int p = std::min(i,j);
                    int q = std::max(i,j);
                    uint64_t key = (p - 1) + (q - 1) * ncols;
                    // Check if this pair has been added before,
                    // if so increment the counter for the pair
							      size_t count = update(&votes, key);
                }
                ++it;
            }
        }
        for (map_it it = votes.begin(); it != votes.end(); it++) {
            if (it->second >= threshold) {
                ofile << it->first % ncols << "," << it->first / ncols
                  << "," << it->second << std::endl;
            }
        }
    }
    ofile.close();
    clock_t end = clock();
    *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}

inline size_t update(map *table, uint64_t const key){
    map_it pt = table->find(key);
    // Increment value
    if(pt != table->end()){
        pt->second++;
        return pt->second;
    }

    // Initialize default
    map_pair data(key, 1);
    table->insert(data);
    return 1;
}


void ClearDatabase(uint8_t const ntbls, table *t){
   for (int i = 0; i != ntbls; i++)
       t[i].clear();
}

void AddSimMatrix(size_t npairs, uint64_t nfp, uint32_t const *input_i, uint32_t const *input_j,
      float const *input_k, dmap *totalMatrix, double *out_time)
{
   clock_t begin = clock();

   for (size_t k = 0; k < npairs; ++k)
   {
      uint64_t i = static_cast<uint64_t>(input_i[k]);
      uint64_t j = static_cast<uint64_t>(input_j[k]);
//      uint64_t key = j + i*nfp; // good for non-symmetric matrix
      uint64_t p = std::min(i,j);
      uint64_t q = std::max(i,j);
      uint64_t key = p + q*nfp;
      UpdateSimMatrix(totalMatrix, key, input_k[k]);
   }

   clock_t end = clock();
   *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}

void UpdateSimMatrix(dmap *totalMatrix, uint64_t key, float const value)
{
   dmap::iterator pt = totalMatrix->find(key);
   // Increment value if it already exists
   if (pt != totalMatrix->end())
   {
      pt->second += value;
   }
   else
   {
      // Initialize value
      std::pair<uint64_t, float> data(key, value);
      totalMatrix->insert(data);
   }
}

void ThresholdTotalSimMatrix(float thresh, dmap const * totalMatrix,
      dmap * threshMatrix, double *out_time)
{
   clock_t begin = clock();

   for (dmap::const_iterator it = totalMatrix->begin(); it != totalMatrix->end(); ++it)
   {
      uint64_t key = it->first;
      float value = it->second;
      if (value >= thresh)
      {
	 std::pair<uint64_t, float> data(key, value);
	 threshMatrix->insert(data);
      }
   }

   clock_t end = clock();
   *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
}

// Count number of fingerprints in each bucket
vec CountBucketItems(table const *t) {
    // use one hash table for now
    vec numItemsPerBucket;
    for (table_cit it = t->begin(); it != t->end(); ++it) {
      numItemsPerBucket.push_back(it->second.size());
    }

    return numItemsPerBucket;
}

// Count number of buckets in each hash table
vec CountBucketsPerTable(uint8_t ntbls, table const *t, vec *maxItemsInBucket) {
   vec numBucketsPerTable;
   for(size_t j = 0; j != ntbls; ++j) {
      // Add number of buckets in this hash table
      table const *t1 = &t[j];
      numBucketsPerTable.push_back(t1->size());

      // Add maximum number of items per bucket in this hash table
      size_t maxItems = 0;
      for (table_cit it = t1->begin(); it != t1->end(); ++it) {
        if (it->second.size() > maxItems) {
          maxItems = it->second.size();
    	  }
      }
      maxItemsInBucket->push_back(maxItems);
   }
   return numBucketsPerTable;
}

vec BucketCountPerTable(uint8_t ntbls, table const *t) {
   vec bucketCountPerTable;
   for(size_t j = 0; j != ntbls; ++j) {
      table const *t1 = &t[j];
      bucketCountPerTable.push_back(t1->bucket_count());
   }
   return bucketCountPerTable;
}
