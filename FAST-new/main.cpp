#include "MinHash.h"
#include "SimilaritySearch.h"
#include "ReadOptions.h"
#include <iostream>
#include <fstream>
#include "boost/dynamic_bitset.hpp"
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */
#include <omp.h>

using namespace std;
namespace fs = boost::filesystem;

Settings s;

void OutputHashTableStats(table* t) {
	vec maxItemsInBucket;
	vec bucketsPerTable = CountBucketsPerTable(s.ntbls, t, &maxItemsInBucket);
	ofstream ofile ("stats/overview.txt");
	for (uint64_t i = 0; i < s.ntbls; i ++) {
		ofile << i << "," << bucketsPerTable.at(i) << ","
			<< maxItemsInBucket.at(i) << endl;
	}
	ofile.close();

	for (uint64_t i = 0; i < s.ntbls; i ++) {
		vec numItemsPerBucket = CountBucketItems(&t[i]);
		ofstream ofile ("stats/table" + to_string(i) + ".txt" );
		for (vec_cit it = numItemsPerBucket.begin(); it != numItemsPerBucket.end();
			it++ ) {
			ofile << *it << endl;
		}
		ofile.close();
	}
}

void minhashBatch(uint64_t i, uint64_t min_hash_sigs[], const uint32_t hashes[], size_t byte_per_fp){
	boost::dynamic_bitset<> fingerprints(s.batch_size * s.mrows);
	ifstream infile;
	infile.open(s.input_file, ios::in | ios::binary);
	infile.seekg(i * s.batch_size * byte_per_fp);
	size_t count = 0;
	size_t j;
	for (j = 0; j < s.batch_size * byte_per_fp && infile.peek() != EOF; j ++) {
		char x;
		infile.read(&x, 1);
		for (size_t i = 0; i < 8; i ++) {
			fingerprints[count] = (x >> (7 - i)) & 1;
			count ++;
		}
	}
	assert(j % byte_per_fp == 0);
	MinHashMM_Block_32(fingerprints, j / byte_per_fp, s.mrows, s.ntbls, s.nhashfuncs, hashes,
					min_hash_sigs, (i * s.batch_size)* s.ntbls);
	infile.close();
	fingerprints.clear();
}

void genMinhashSig(uint64_t *min_hash_sigs, size_t ntimes) {
	uint64_t sig_len = s.ncols * s.ntbls;
	size_t byte_per_fp = s.mrows / 8;
	double out_time = 0;

	// Read minhash signatures from file
	if (!s.input_mh_sigs_file.empty()) {
		clock_t begin = clock();
		BOOST_LOG_TRIVIAL(info) << "Reading MinHash Sigs from:\t" << s.input_mh_sigs_file;
		// Reading minhash signatures from file
		ifstream infile;
		infile.open(s.input_mh_sigs_file, ios::in | ios::binary);
		infile.read((char*)min_hash_sigs, sig_len*sizeof(uint64_t));
		if (infile.peek() != EOF) {
			BOOST_LOG_TRIVIAL(warning) << "Did not read all of input minhash sigs file";
		}
		infile.close();
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
	} else { // Compute hashes for each row
		uint32_t *hashes = (uint32_t*) malloc(ntimes * s.mrows * sizeof(uint32_t));
		calculate_hash(s.mrows, ntimes, rand(), hashes);
		//Fingerprint file
		fs::path p = s.input_file;
		uintmax_t insize = fs::file_size(p);
		BOOST_LOG_TRIVIAL(trace) << "Input file size:" << insize;
		if(insize != byte_per_fp * s.ncols){
			BOOST_LOG_TRIVIAL(warning) << "Input file size does not match up with expected number of fingerprints";
			BOOST_LOG_TRIVIAL(warning) << "Expected number of fingerprints:" << s.ncols;
			BOOST_LOG_TRIVIAL(warning) << "Calculated number of fingerprints:" << 
				((double)insize) / byte_per_fp;
			if(insize > byte_per_fp * s.ncols){
				BOOST_LOG_TRIVIAL(fatal) << "File is too small - exiting as we don't know how to fill remaining ncols";
				BOOST_LOG_TRIVIAL(fatal) << "Run with lower number of ncols";
				exit(1);
			} else {
				BOOST_LOG_TRIVIAL(warning) << "File is too large - entire file will be read, but only ncol fingerprints will be used";
			}
		}

		clock_t begin = clock();
		uint64_t num_batches = 1 + insize / (s.batch_size * byte_per_fp);
		BOOST_LOG_TRIVIAL(trace) << "Number of batches:\t" << num_batches;

		uint64_t i;
		// Reading fingerprints and compute minhashes in batches
		omp_set_num_threads(s.minhash_threads);
#pragma omp parallel for default(none)\
		private(i) shared(num_batches, insize, byte_per_fp, min_hash_sigs, hashes, s) 
		for (i = 0; i < num_batches ; i++) {
			minhashBatch(i, min_hash_sigs, hashes, byte_per_fp);
		}
		delete[] hashes;
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC / s.minhash_threads;
	}
	BOOST_LOG_TRIVIAL(info) << "MinHash took: " << out_time;

	// Output minhash signatures
	out_time = 0;
	if (s.input_mh_sigs_file.empty()) {
		clock_t begin = clock();
		BOOST_LOG_TRIVIAL(info) << "Writing MinHash Sigs to:\t" << s.output_mh_sigs_file;
		ofstream outfile;
		outfile.open(s.output_mh_sigs_file, ios::out | ios::binary);
		outfile.write((char*)min_hash_sigs, sig_len*sizeof(uint64_t));
		outfile.close();
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
		BOOST_LOG_TRIVIAL(info) << "Writing out MinHash took: " << out_time;
	}
}

int main(int argc, char * argv[]) {
	srand(time(NULL));
	s = readOptions(argc, argv);

	size_t ntimes = s.ntbls * s.nhashfuncs;    //number of min-hash permutations

	// Storage for min-hash signatures
	uint64_t sig_len = s.ncols * s.ntbls;
	uint64_t *min_hash_sigs = new uint64_t[sig_len];

	// Generate minhash signatures
	double out_time = 0;
	genMinhashSig(min_hash_sigs, ntimes);

	if(!s.output_pairs_file.empty()){
		out_time = 0;

		// Run per partition
		for (size_t i = 0; i < s.num_partitions; i ++) {
			size_t start_indice = s.ncols / s.num_partitions * i;
			size_t end_indice = s.ncols / s.num_partitions * (i + 1);
			if (i == s.num_partitions - 1) { end_indice = s.ncols; }
			BOOST_LOG_TRIVIAL(info) << "Search fingerprints " << start_indice
				<< "," << end_indice;

			// Populate database
			table *t = new table[s.ntbls];
			InitializeDatabase(ntimes, s.ncols, s.ntbls, s.nhashfuncs, t, min_hash_sigs, 
				&out_time, s.simsearch_threads, start_indice, end_indice);
			BOOST_LOG_TRIVIAL(info) << "Initialize took: " << out_time;

			// Similarity Search
			out_time = 0;
			uint32_t *query =  new uint32_t[s.num_queries - start_indice];
			for (size_t i = start_indice; i < s.num_queries; i++) { query[i - start_indice] = i; }
			SearchDatabase_voting(s.num_queries - start_indice, s.ncols, query, 
					s.ntbls, s.near_repeats, t, min_hash_sigs,
					s.nvotes, s.limit, &out_time, s.output_pairs_file, s.simsearch_threads);
			delete[] query;
			BOOST_LOG_TRIVIAL(info) << "Search took: " << out_time;

			delete[] t;
		}

		// Hash table stats
		//OutputHashTableStats(t);
	}

	delete[] min_hash_sigs;
}
