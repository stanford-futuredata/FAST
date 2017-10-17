#ifndef _READOPIONS_H_
#define _READOPIONS_H_

#include <iostream>
#include "boost/program_options.hpp"
#include "boost/log/expressions.hpp"
#include "boost/log/trivial.hpp"
#include "boost/log/core.hpp"
#include "boost/filesystem.hpp"

using namespace std;
namespace po = boost::program_options; // see http://www.boost.org/doc/libs/1_41_0/doc/html/program_options/tutorial.html
namespace fs = boost::filesystem;

struct Settings {
	size_t batch_size = 100000;
	uint64_t ntbls = 100;
	size_t nhashfuncs = 5;
	uint64_t ncols = 86381;
	size_t mrows = 4096;
	size_t near_repeats = 5;
	size_t num_queries;
	uint32_t limit = 4e9;
	size_t nvotes = 4;
	size_t minhash_threads= 1;
	size_t simsearch_threads= 1;
	string input_file, input_mh_sigs_file, output_pairs_file, filter_file;
	string output_mh_sigs_file = "minhash_sigs.txt";
	size_t num_partitions = 5;
	size_t start_index = 0;
	size_t end_index = 0;
	double noise_freq = -1;
};

Settings readOptions(int argc, char * argv[]) {
	po::options_description desc{"Allowed options"};
	desc.add_options()
		("help", "produce help message")
		("verbose", "verbose")
		("input_fp_file", po::value<string>(), "name of input fingerprint file")
		("input_minhash_sigs_file", po::value<string>(), "name of file from which to retrieve minhash sigs")
		("output_minhash_sigs_file", po::value<string>(), "name of file to store minhash sigs")
		("output_pairs_file", po::value<string>(), "name of file to store candidate pairs")
		("filter_file", po::value<string>(), "name of fingerprint binary filter file")
		("ntbls", po::value<uint64_t>(), "Number of hash tables")
		("nhash", po::value<size_t>(), "Number of hash functions")
		("ncols", po::value<uint64_t>(), "Number of hash functions")
		("mrows", po::value<size_t>(), "Number of rows")
		("near_repeats", po::value<size_t>(), "Near repeat limit")
		("num_queries", po::value<size_t>(), "Number of indices to query in the similarity search")
		("limit", po::value<uint32_t>(), "Limit")
		("nvotes", po::value<size_t>(), "Number of votes")
		("batch_size", po::value<size_t>(), "Batch size to read fingerprints")
		("minhash_threads", po::value<size_t>(), "Maximum number of threads for minhash")
		("simsearch_threads", po::value<size_t>(), "Maximum number of threads for simsearch and db init")
		("num_partitions", po::value<size_t>(), "Number of partitions for similarity search")
		("start_index", po::value<size_t>(), "Start fingerprint index for the all to some search")
		("end_index", po::value<size_t>(), "End fingerprint index for the all to some search")
		("noise_freq", po::value<string>(), "Frequency above which fingerprints will be filtered out as correlated noise")
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

	Settings setting;
	if (vm.count("input_fp_file")) {
		setting.input_file = vm["input_fp_file"].as<string>();
		fs::path p = setting.input_file;
		if(!fs::exists(p) || !fs::is_regular_file(p)){
			BOOST_LOG_TRIVIAL(fatal) << "Input fp file does not exist";
			exit(1);
		}
		BOOST_LOG_TRIVIAL(debug) << "Input file:\t" << setting.input_file;
	} else if(vm.count("input_minhash_sigs_file")) {
		setting.input_mh_sigs_file = vm["input_minhash_sigs_file"].as<string>();
		fs::path p = setting.input_mh_sigs_file;
		if(!fs::exists(p) || !fs::is_regular_file(p)){
			BOOST_LOG_TRIVIAL(fatal) << "Input minhash sigs file does not exist";
			exit(1);
		}
		BOOST_LOG_TRIVIAL(debug) << "Input mh sigs file:\t" << setting.input_mh_sigs_file;
	} else {
		BOOST_LOG_TRIVIAL(fatal) << "No input files specified";
		exit(1);
	}

	if (vm.count("output_pairs_file")) {
		setting.output_pairs_file = vm["output_pairs_file"].as<string>();
		fs::path p = setting.output_pairs_file;
		if (fs::exists(p)) {
			BOOST_LOG_TRIVIAL(warning) << "Pairs file already exists. It will be appended.";
		}
		BOOST_LOG_TRIVIAL(debug) << "Output pairs file:\t" << setting.output_pairs_file;
	}

	if (vm.count("output_minhash_sigs_file")) {
		setting.output_mh_sigs_file = vm["output_minhash_sigs_file"].as<string>();
		fs::path p = setting.output_mh_sigs_file;
		if (fs::exists(p)) {
			BOOST_LOG_TRIVIAL(warning) << "output_mh_sigs file already exists. It will be overwritten";
		}
		BOOST_LOG_TRIVIAL(debug) << "Output minhash sigs file:\t" << setting.output_mh_sigs_file;
	}

	if (vm.count("filter_file")) {
		setting.filter_file = vm["filter_file"].as<string>();
		fs::path p = setting.filter_file;
	}

	if (vm.count("batch_size")) {
		setting.batch_size = vm["batch_size"].as<size_t>();
	}

	if (vm.count("minhash_threads")) {
		setting.minhash_threads = vm["minhash_threads"].as<size_t>();
	}

	if (vm.count("simsearch_threads")) {
		setting.simsearch_threads = vm["simsearch_threads"].as<size_t>();
	}

	if (vm.count("ntbls")) {
		setting.ntbls = vm["ntbls"].as<uint64_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "ntbls:\t" << setting.ntbls;

	if (vm.count("nhash")) {
		setting.nhashfuncs = vm["nhash"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "nhashfuncs:\t" << setting.nhashfuncs;

	if (vm.count("ncols")) {
		setting.ncols = vm["ncols"].as<uint64_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "ncols:\t" << setting.ncols;

	if (vm.count("mrows")){
		setting.mrows = vm["mrows"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "mrows:\t" << setting.mrows;

	if (vm.count("near_repeats")) {
		setting.near_repeats = vm["near_repeats"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "near_repeats:\t" << setting.near_repeats;

	if(vm.count("num_queries")) {
		setting.num_queries = vm["num_queries"].as<size_t>();
		if (setting.num_queries > setting.ncols) {
			BOOST_LOG_TRIVIAL(fatal) << "num_queries(" << setting.num_queries<<")"
				<< "cannot be greater than ncols(" << setting.ncols << ")";
			exit(-1);
		}
	} else {
		setting.num_queries = setting.ncols;
	}
	BOOST_LOG_TRIVIAL(debug) << "num_queries:\t" << setting.num_queries;

	if (vm.count("limit")) {
		setting.limit = vm["limit"].as<uint32_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "limit:\t" << setting.limit;

	if (vm.count("nvotes")) {
		setting.nvotes = vm["nvotes"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "nvotes:\t" << setting.nvotes;

	if (vm.count("num_partitions")) {
		setting.num_partitions = vm["num_partitions"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "num_partitions:\t" << setting.num_partitions;

	if (vm.count("start_index")) {
		setting.start_index = vm["start_index"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "start_index:\t" << setting.start_index;

	if (vm.count("end_index")) {
		setting.end_index = vm["end_index"].as<size_t>();
	}
	BOOST_LOG_TRIVIAL(debug) << "end_index:\t" << setting.end_index;

	if (vm.count("noise_freq")) {
		setting.noise_freq = atof(vm["noise_freq"].as<string>().c_str());
		BOOST_LOG_TRIVIAL(debug) << "noise_freq:\t" << setting.noise_freq;
	}

	return setting;
}

#endif // _READOPIONS_H_
