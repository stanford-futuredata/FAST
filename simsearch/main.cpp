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

void genMinhashSig(uint64_t *min_hash_sigs) {
	uint64_t sig_len = s.ncols * s.ntbls;
	size_t byte_per_fp = s.mrows / 8;
	double out_time = 0;
	size_t minmax_ntimes = s.ntbls * ((s.nhashfuncs + 1) / 2);    //number of min-hash permutations

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
		clock_t begin = clock();
		uint32_t *hashes = (uint32_t*) malloc(minmax_ntimes * s.mrows * sizeof(uint32_t));
		calculate_hash(s.mrows, minmax_ntimes, rand(), hashes);
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

		uint64_t num_batches = 1 + insize / (s.batch_size * byte_per_fp);
		BOOST_LOG_TRIVIAL(trace) << "Number of batches:\t" << num_batches;

		uint64_t i;
		// Reading fingerprints and compute minhashes in batches
		omp_set_num_threads(s.ncores);
#pragma omp parallel for default(none)\
		private(i) shared(num_batches, insize, byte_per_fp, min_hash_sigs, hashes, s) 
		for (i = 0; i < num_batches ; i++) {
			minhashBatch(i, min_hash_sigs, hashes, byte_per_fp);
		}
		delete[] hashes;
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC / s.ncores;
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

/* Initialize hash table and perform similarity search for a range of fingerprint
   indices or for selected fingerprints in a file. */
void searchRange(size_t start_indice, size_t end_indice,
	uint32_t *query, size_t nquery, uint64_t *min_hash_sigs, size_t ntimes,
	boost::dynamic_bitset<>* filter_flag) {
	BOOST_LOG_TRIVIAL(info) << "Search fingerprints " << start_indice
		<< "," << end_indice;

	// Populate database
	double out_time = 0;
	table *t = new table[s.ntbls];
	if (!s.filter_file.empty()) {
		InitializeDatabase(ntimes, s.ncols, s.ntbls, s.nhashfuncs, t, min_hash_sigs, 
			&out_time, s.ncores, start_indice, end_indice, filter_flag);
	} else {
		InitializeDatabase(ntimes, s.ncols, s.ntbls, s.nhashfuncs, t, min_hash_sigs, 
			&out_time, s.ncores, start_indice, end_indice);
	}
	BOOST_LOG_TRIVIAL(info) << "Initialize took: " << out_time;

	// Similarity Search
	out_time = 0;
	ostringstream stringStream;
	stringStream << s.output_pairs_file << "(" << start_indice 
		<< "," << end_indice << ")";
	string fname = stringStream.str();
	SearchDatabase_voting(query, nquery,
			s.ntbls, s.near_repeats, t, min_hash_sigs,
			s.nvotes, &out_time, fname, s.ncores,
			start_indice, end_indice, filter_flag, s.noise_freq);
	BOOST_LOG_TRIVIAL(info) << "Search took: " << out_time;

	delete[] t;
}

// Read result file which indicates whether each fingerprint passed the filter
void read_filter_file(boost::dynamic_bitset<>* filter_flag, std::string fname) {
    std::ifstream infile;
    infile.open(fname, std::ios::in);
    int x;
    size_t i = 0;
    while (infile >> x) {
        if (i == 1) { filter_flag->set(i, 1); }
        i ++;
    }
    infile.close();
}

int main(int argc, char * argv[]) {
	srand(time(NULL));
	s = readOptions(argc, argv);

	size_t ntimes = s.ntbls * s.nhashfuncs;    //number of min-hash permutations

	// Storage for min-hash signatures
	uint64_t sig_len = s.ncols * s.ntbls;
	uint64_t *min_hash_sigs = new uint64_t[sig_len];

	// Generate minhash signatures
	genMinhashSig(min_hash_sigs);

    boost::dynamic_bitset<> filter_flag(s.ncols);

	if (!s.output_pairs_file.empty()) {
		if ((s.start_index > 0 && s.end_index > 0)) { // Search again specified indices
			uint32_t *query =  new uint32_t[s.ncols];
			for (size_t i = 0; i < s.ncols; i++) { query[i] = i; }

			searchRange(s.start_index, s.end_index, query, s.ncols,
				min_hash_sigs, ntimes, &filter_flag);

			delete[] query;
		} else { 			// Run per partition
			if (!s.filter_file.empty()) {   // Read filter file
				read_filter_file(&filter_flag, s.filter_file);
			}
			for (size_t i = 0; i < s.num_partitions; i ++) {
				size_t start_indice = s.ncols / s.num_partitions * i;
				size_t end_indice = s.ncols / s.num_partitions * (i + 1);
				if (i == s.num_partitions - 1) { end_indice = s.ncols; }

				uint32_t *query =  new uint32_t[end_indice];
				for (size_t i = 0; i < end_indice; i++) { query[i] = i; }

				searchRange(start_indice, end_indice, query, end_indice,
					min_hash_sigs, ntimes, &filter_flag);

				delete[] query;
			}
		}
	}

	delete[] min_hash_sigs;
}
