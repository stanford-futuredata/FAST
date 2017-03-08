#include "MinHash.h"
#include "SimilaritySearch.h"
#include <iostream>
#include <fstream>
#include "boost/dynamic_bitset.hpp"
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */
#include "boost/program_options.hpp"
#include "boost/log/expressions.hpp"
#include "boost/log/trivial.hpp"
#include "boost/log/core.hpp"
#include "boost/filesystem.hpp"

using namespace std;
namespace po = boost::program_options; // see http://www.boost.org/doc/libs/1_41_0/doc/html/program_options/tutorial.html
namespace fs = boost::filesystem;

int batch_size = 100000;
uint64_t ntbls = 100;
int nhashfuncs = 5;
uint64_t ncols = 86381;
int mrows = 4096;
int near_repeats = 5;
size_t num_queries;
uint32_t limit = 4e9;
int nvotes = 4;
string input_file, input_mh_sigs_file;
string output_pairs_file = "candidate_pairs.txt";
string output_mh_sigs_file = "minhash_sigs.txt";

void readOptions(int argc, char * argv[]) {
	po::options_description desc{"Allowed options"};
	desc.add_options()
		("help", "produce help message")
		("verbose", "verbose")
		("input_fp_file", po::value<string>(), "name of input fingerprint file")
		("input_minhash_sigs_file", po::value<string>(), "name of file from which to retrieve minhash sigs")
		("output_minhash_sigs_file", po::value<string>(), "name of file to store minhash sigs")
		("output_pairs_file", po::value<string>(), "name of file to store candidate pairs")
		("ntbls", po::value<uint64_t>(), "Number of hash tables")
		("nhash", po::value<int>(), "Number of hash functions")
		("ncols", po::value<uint64_t>(), "Number of hash functions")
		("mrows", po::value<int>(), "Number of rows")
		("near_repeats", po::value<int>(), "Near repeat limit")
		("num_queries", po::value<size_t>(), "Number of indices to query in the similarity search")
		("limit", po::value<uint32_t>(), "Limit")
		("nvotes", po::value<int>(), "Number of votes")
		("batch_size", po::value<int>(), "Batch size to read fingerprints")
		;
	po::variables_map vm;

	try {
		po::store(po::parse_command_line(argc, argv, desc), vm);
	} catch(exception& e){
		BOOST_LOG_TRIVIAL(fatal) << "Error parsing command line args:" << e.what();
		exit(-1);
	}
	po::notify(vm); 
	if (vm.count("verbose")) {
		BOOST_LOG_TRIVIAL(trace) << "A trace severity message";
		boost::log::core::get()->set_filter
			(
			 boost::log::trivial::severity >= boost::log::trivial::trace
			);
	} else {
		boost::log::core::get()->set_filter
			(
			 boost::log::trivial::severity >= boost::log::trivial::info
			);
	}
	if (vm.count("help")) {
		cout << desc << endl;
		exit(1);
	}
	if (vm.count("input_fp_file")) {
		input_file = vm["input_fp_file"].as<string>();
		fs::path p = input_file;
		if(!fs::exists(p) || !fs::is_regular_file(p)){
			BOOST_LOG_TRIVIAL(fatal) << "Input fp file does not exist";
			exit(1);
		}
		BOOST_LOG_TRIVIAL(debug) << "Input file:\t" << input_file;
	} else if(vm.count("input_minhash_sigs_file")) {
		input_mh_sigs_file = vm["input_minhash_sigs_file"].as<string>();
		fs::path p = input_mh_sigs_file;
		if(!fs::exists(p) || !fs::is_regular_file(p)){
			BOOST_LOG_TRIVIAL(fatal) << "Input minhash sigs file does not exist";
			exit(1);
		}
		BOOST_LOG_TRIVIAL(debug) << "Input mh sigs file:\t" << input_mh_sigs_file;
	} else {
		BOOST_LOG_TRIVIAL(fatal) << "No input files specified";
		exit(1);
	}

	if (vm.count("output_pairs_file")) {
		output_pairs_file = vm["output_pairs_file"].as<string>();
		fs::path p = output_pairs_file;
		if (fs::exists(p)) {
			BOOST_LOG_TRIVIAL(warning) << "Pairs file already exists. It will be overwritten";
		}
		BOOST_LOG_TRIVIAL(debug) << "Output pairs file:\t" << output_pairs_file;
	}

	if (vm.count("output_minhash_sigs_file")) {
		output_mh_sigs_file = vm["output_minhash_sigs_file"].as<string>();
		fs::path p = output_mh_sigs_file;
		if (fs::exists(p)) {
			BOOST_LOG_TRIVIAL(warning) << "output_mh_sigs file already exists. It will be overwritten";
		}
		BOOST_LOG_TRIVIAL(debug) << "Output minhash sigs file:\t" << output_mh_sigs_file;
	}

	if (vm.count("batch_size")) {
		batch_size = vm["batch_size"].as<int>();
	}

	if (vm.count("ntbls")) {
		ntbls = vm["ntbls"].as<uint64_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "ntbls:\t" << ntbls;

	if (vm.count("nhash")) {
		nhashfuncs = vm["nhash"].as<int>();
	}
	BOOST_LOG_TRIVIAL(debug) << "nhashfuncs:\t" << nhashfuncs;

	if (vm.count("ncols")) {
		ncols = vm["ncols"].as<uint64_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "ncols:\t" << ncols;

	if (vm.count("mrows")){
		mrows = vm["mrows"].as<int>();
	}
	BOOST_LOG_TRIVIAL(debug) << "mrows:\t" << mrows;

	if (vm.count("near_repeats")) {
		near_repeats = vm["near_repeats"].as<int>();
	}
	BOOST_LOG_TRIVIAL(debug) << "near_repeats:\t" << near_repeats;

	if(vm.count("num_queries")) {
		num_queries = vm["num_queries"].as<size_t>();
		if (num_queries > ncols) {
			BOOST_LOG_TRIVIAL(fatal) << "num_queries("<<num_queries<<")"<< "cannot be greater than ncols(" << ncols << ")";
			exit(-1);
		}
	} else {
		num_queries = ncols;
	}
	BOOST_LOG_TRIVIAL(debug) << "num_queries:\t" << num_queries;

	if (vm.count("limit")) {
		limit = vm["limit"].as<uint32_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "limit:\t" << limit;

	if (vm.count("nvotes")) {
		nvotes = vm["nvotes"].as<int>();
	}
	BOOST_LOG_TRIVIAL(debug) << "nvotes:\t" << nvotes;
}

void OutputHashTableStats(table* t) {
	vec maxItemsInBucket;
	vec bucketsPerTable = CountBucketsPerTable(ntbls, t, &maxItemsInBucket);
	ofstream ofile ("stats/overview.txt");
	for (int i = 0; i < ntbls; i ++) {
		ofile << i << "," << bucketsPerTable.at(i) << ","
			<< maxItemsInBucket.at(i) << endl;
	}
	ofile.close();

	for (int i = 0; i < ntbls; i ++) {
		vec numItemsPerBucket = CountBucketItems(&t[i]);
		ofstream ofile ("stats/table" + to_string(i) + ".txt" );
		for (vec_cit it = numItemsPerBucket.begin(); it != numItemsPerBucket.end();
			it++ ) {
			ofile << *it << endl;
		}
		ofile.close();
	}
}

void genMinhashSig(uint32_t *hashes, uint64_t *min_hash_sigs) {
	uint64_t sig_len = ncols * ntbls;
	int byte_per_fp = mrows / 8;
	double out_time = 0;

	// Generate minhash signatures
	if (!input_mh_sigs_file.empty()) {
		clock_t begin = clock();
		BOOST_LOG_TRIVIAL(info) << "Reading MinHash Sigs from:\t" << input_mh_sigs_file;
		// Reading minhash signatures from file
		ifstream infile;
		infile.open(input_mh_sigs_file, ios::in | ios::binary);
		infile.read((char*)min_hash_sigs, sig_len*sizeof(uint64_t));
		if (!infile.eof()) {
			BOOST_LOG_TRIVIAL(warning) << "Did not read all of input minhash sigs file (this warning is buggy - will fix)";
		}
		infile.close();
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
	} else {
		boost::dynamic_bitset<> fingerprints(batch_size * mrows);
		//Fingerprint file
		ifstream infile;
		infile.open(input_file, ios::in | ios::binary);
		uint64_t fp_index = 0;
		int j = 0;
		fs::path p = input_file;
		uintmax_t insize = fs::file_size(p);
		BOOST_LOG_TRIVIAL(trace) << "Input file size:" << insize;
		int loops = 0;
		clock_t begin = clock();

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

			double frac_complete = (infile.eof() ? 1.0 : (1.0*(infile.tellg())/insize));
			double elapsed_time = ((double)(clock() - begin)) / CLOCKS_PER_SEC;
			//BOOST_LOG_TRIVIAL(trace) << "MinHash pct completion:\t" << 100.0*frac_complete;
			BOOST_LOG_TRIVIAL(trace) << "MinHash estimated remaining time (s):\t" << (1.0-frac_complete)*(elapsed_time)/(frac_complete);
			//BOOST_LOG_TRIVIAL(trace) << "Estimated total time:\t" << (elapsed_time /(frac_complete));
		}
		infile.close();
		delete[] hashes;
		fingerprints.clear();
	}
	BOOST_LOG_TRIVIAL(info) << "MinHash took: " << out_time;

	// Output minhash signatures
	out_time = 0;
	if (input_mh_sigs_file.empty()) {
		clock_t begin = clock();
		BOOST_LOG_TRIVIAL(info) << "Writing MinHash Sigs to:\t" << output_mh_sigs_file;
		ofstream outfile;
		outfile.open(output_mh_sigs_file, ios::out | ios::binary);
		outfile.write((char*)min_hash_sigs, sig_len*sizeof(uint64_t));
		outfile.close();
		clock_t end = clock();
		out_time += ((double)(end - begin)) / CLOCKS_PER_SEC;
		BOOST_LOG_TRIVIAL(info) << "Writing out MinHash took: " << out_time;
	}
}

int main(int argc, char * argv[]) {
	srand(time(NULL));
	readOptions(argc, argv);

	int ntimes = ntbls * nhashfuncs;    //number of min-hash permutations

    // Compute hashes for each row
	uint32_t *hashes = (uint32_t*) malloc(ntimes * mrows * sizeof(uint32_t));
	calculate_hash(mrows, ntimes, rand(), hashes);

	// Storage for min-hash signatures
	uint64_t sig_len = ncols * ntbls;
	uint64_t *min_hash_sigs = new uint64_t[sig_len];

	// Generate minhash signatures
	double out_time = 0;
	genMinhashSig(hashes, min_hash_sigs);

	// Populate database
	table *t = new table[ntbls];
	out_time = 0;
	InitializeDatabase(ntimes, ncols, ntbls, nhashfuncs, t, min_hash_sigs, &out_time);
	BOOST_LOG_TRIVIAL(info) << "Initialize took: " << out_time;

	// Similarity Search
	uint32_t *query =  new uint32_t[num_queries];
	for (uint32_t i = 0; i < num_queries; i++) { query[i] = i; }
	out_time = 0;
	SearchDatabase_voting(num_queries, ncols, query, ntbls, near_repeats, t, min_hash_sigs,
					nvotes, limit, &out_time, output_pairs_file);
	BOOST_LOG_TRIVIAL(info) << "Search took: " << out_time;
	delete[] query;

	// Hash table stats
	//OutputHashTableStats(t);

	// Clean up
	ClearDatabase(ntbls, t);
	delete[] min_hash_sigs;
	delete[] t;
}
