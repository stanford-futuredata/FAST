#include "MinHash.h"
#include "SimilaritySearch.h"
#include <iostream>
#include <fstream>
#include "boost/dynamic_bitset.hpp"

using namespace std;

int main(int argc, char * argv[]) {
	uint64_t ntbls = 100;
	int nhashfuncs = 5;
	//int nhashfuncs = 8;
	int ncols = 86381;
	//uint64_t ncols = 26496002;
	int mrows = 4096;
	uint32_t seed = 1783793664;
	int ntimes = ntbls * nhashfuncs;    //number of min-hash permutations
	int near_repeats = 5;
	uint32_t limit = 4e9;
	int nvotes = 4;

	// Compute hashes for each row
	uint32_t *hashes = (uint32_t*) malloc(ntimes * mrows * sizeof(uint32_t));
	calculate_hash(mrows, ntimes, seed, hashes);
	// Storage for min-hash signatures
	const uint64_t sig_len = ncols * ntbls;
	uint64_t *min_hash_sigs = new uint64_t[sig_len];
	// Fingerprint storage
	const int batch_size = 100000;
	boost::dynamic_bitset<> fingerprints(batch_size * mrows);
	//Fingerprint file
	ifstream infile;
	infile.open("24hr.bin", ios::in | ios::binary);
	//infile.open("3m.bin", ios::in | ios::binary);
	uint64_t fp_index = 0;
	double out_time = 0;
	int j = 0;
	const int byte_per_fp = mrows / 8;
	// Reading fingerprints and compute minhashes in batches
	while (!infile.eof()) {
		int count = 0;
		for (j = 0; j < batch_size * byte_per_fp; j ++) {
			if (infile.eof()) {	break; }
			char x;
			infile.read(&x, 1);
			for (int i = 0; i < 8; i ++) {
				fingerprints[count] = (x >> (7 - i)) & 1;
				count ++;
			}
		}
		MinHashMM_Block_32(&fingerprints, j / byte_per_fp, mrows, ntbls, nhashfuncs, hashes,
			min_hash_sigs, &fp_index, &out_time);
	}
	infile.close();
	delete[] hashes;
	fingerprints.clear();
	cout << "MinHash took: " << out_time << endl;

	// Populate database
	table *t = new table[ntbls];
	out_time = 0;
	InitializeDatabase(ntimes, ncols, ntbls, nhashfuncs, t, min_hash_sigs, &out_time);
	cout << "Initialize took: " << out_time << endl;

	// Similarity Search
	uint32_t *query =  new uint32_t[ncols];
	for (uint32_t i = 0; i < ncols; i++) { query[i] = i; }
	out_time = 0;
	SearchDatabase_voting(ncols, ncols, query, ntbls, near_repeats, t, min_hash_sigs,
		nvotes, limit, &out_time);
	cout << "Search took: " << out_time << endl;

	ClearDatabase(ntbls, t);
	delete[] min_hash_sigs;
	delete[] query;
	delete[] t;
}
