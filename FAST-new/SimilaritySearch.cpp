#include <ctime>
#include <cmath>
#include <iostream>
#include <fstream>
#include "SimilaritySearch.h"
#include <omp.h>

#define CHUNK 100

// Read result file which indicates whether each fingerprint passed the filter
void read_filter_file(int *filter, std::string fname) {
  std::ifstream infile;
  infile.open(fname, std::ios::in);
  int x;
  size_t i = 0;
  while (infile >> x) {
    filter[i] = x;
    i ++;
  }
  infile.close();
}

// Populate database - place fingerprint indices in hash buckets
void InitializeDatabase(size_t mrows, size_t ncols, uint8_t ntbls, uint8_t nhashfuncs,
        table *t, uint64_t *keys, double *out_time, const size_t num_threads) {
    clock_t begin = clock();

  size_t j;
  int *filter = new int[ncols];
  read_filter_file(filter, "filter.txt");

  omp_set_num_threads(num_threads);
    //Insert pairs (key, id) into hash tables
#pragma omp parallel for default(none)\
    private(j) shared(ntbls, ncols, t, keys, filter)
  for(j = 0; j < ntbls; ++j){
      for(size_t i = 0; i < ncols; ++i){
          if (filter[i] == 1) {
            insert_new_item(&t[j], keys[j + i * ntbls], i);
          }
      }
  }
    clock_t end = clock();
    *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC / num_threads;
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

// Search Database with voting
void SearchDatabase_voting(const size_t nquery, const size_t ncols, const uint32_t *query, const uint8_t ntbls,
        const uint32_t near_repeats, table *t, uint64_t const *keys,
        const size_t threshold, const size_t limit, double *out_time, const std::string& out_file, const size_t num_threads)
{
    clock_t begin = clock();

    //Search
    std::ofstream ofile;
    ofile.open(out_file, std::ios::binary);
    size_t i;
    omp_set_num_threads(num_threads);
    double lookups = 0;
#pragma omp parallel for default(none)\
    private(i) shared(lookups, query, t, keys, ofile) schedule(dynamic, CHUNK)
    for(i = 0; i < nquery; ++i) {
        uint32_t query_index = query[i];
        map votes;
        double query_size = 0;
        for(size_t j = 0; j < ntbls; ++j){
            table const *t1 = &t[j];
            // this index may be out of bounds for a uint32_t
            size_t query_bucket_index = j + static_cast<size_t>(query_index)*static_cast<size_t>(ntbls); 
            uint64_t this_key = keys[query_bucket_index];
            table_cit its = t1->find(this_key);
            if (its == t1->end()) { continue; }
            size_t num_items = its->second.size();
            query_size += num_items;
            size_t l = std::min(num_items,limit);
            //Add all matches that are not near-repeats
            vec_cit it = its->second.begin();
            for(size_t k = 0; k != l; ++k) {
                uint32_t key = *it;
                if ((query_index <= key) && (fabs(key - query_index) >= near_repeats)) {
                    map::accessor a;
                    // will either fetch current value or use 0 as default if new 
                    votes.insert(a, key);
                    a->second+=1;
                    a.release();
                }
                ++it;
            }
        }
        std::vector<uint32_t> results;
        for (map_it it = votes.begin(); it != votes.end(); it++) {
            if (it->second >= threshold) {
                results.push_back(it->first);
                results.push_back(it->second);
            }
        }
        uint32_t count = results.size();
#pragma omp critical(WRITE_TO_FILE)
          {
              ofile.write((char*)&query_index, 4);
              ofile.write((char*)&count, 4);
              ofile.write((char*)&(results[0]), count * 4);
          }
        lookups += query_size * 1.0 / nquery;
    }
    ofile.close();
    clock_t end = clock();
    *out_time += ((double)(end - begin)) / CLOCKS_PER_SEC / num_threads;
    std::cout << "Average lookups:" << lookups << std::endl;
}

void ClearDatabase(uint8_t const ntbls, table *t){
   for (int i = 0; i != ntbls; i++)
       t[i].clear();
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
