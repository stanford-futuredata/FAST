#include "MinHash.h"
#include "SimilaritySearch.h"
#include <iostream>
#include <fstream>
#include "boost/dynamic_bitset.hpp"

using namespace std;

int main(int argc, char * argv[]) {
	int ntbls = 100;
	int nhashfuncs = 5;
	int ncols = 86381;
	//int ncols = 26496002;
	int mrows = 4096;
	uint32_t seed = 1783793664;
	double out_time = 0;
	int ntimes = ntbls * nhashfuncs;    //number of min-hash permutations
	int near_repeats = 5;
	uint32_t limit = 4e9;
	int nvotes = 4;

	const int tot_fp_len = ncols * mrows;
	boost::dynamic_bitset<> fingerprints(tot_fp_len);
	ifstream infile;
	infile.open("24hr.bin", ios::in | ios::binary);
	//infile.open("3m.txt", ios::in | ios::binary);
	int count = 0;
	while (!infile.eof() && count < tot_fp_len) {
		char x;
		infile.read(&x, 1);
		for (int i = 0; i < 8; i ++) {
			fingerprints[count] = (x >> (7 - i)) & 1;
			count ++;
		}
	}
	infile.close();
	table_vec* t = new table_vec();
	for (int i = 0; i < ntbls; i ++ )
		t->push_back(new table());
    uint64_t *keys = new uint64_t[ncols * ntbls];
    // Storage for min-hash signatures
    uint8_t *min_hash_sigs = new uint8_t[ncols * ntimes];

	// Compute MinHash
	MinHashMM_Block_32(&fingerprints, ncols, mrows, ntimes, seed, min_hash_sigs, &out_time);
	cout << "MinHash took: " << out_time << endl;
	fingerprints.clear();
    // Populate database
    out_time = 0;
    InitializeDatabase(ntimes, ncols, min_hash_sigs, ntbls, nhashfuncs,
                       t, keys, &out_time);
   	cout << "Initialize took: " << out_time << endl;

    uint32_t *query =  new uint32_t[ncols];
    for (uint32_t i = 0; i < ncols; i++)
    	query[i] = i;
    out_time = 0;
    SearchDatabase_voting(ncols, ncols, query, ntbls, near_repeats, t, keys,
    	nvotes, limit, &out_time);
   	cout << "Search took: " << out_time << endl;
}
