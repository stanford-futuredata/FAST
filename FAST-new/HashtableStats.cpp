#include "SimilaritySearch.h"

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