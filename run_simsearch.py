from os import chdir
import subprocess
import argparse
from parse_config import *
from fingerprint.util import *

searchCommand = './main --input_fp_file=%s%s \
       --output_minhash_sigs_file=%s%s \
       --output_pairs_file=%s%s\
       --ntbls %d \
       --nhash %d \
       --ncols %d \
       --mrows %d \
       --near_repeats %d \
       --nvotes %d \
       --ncores %d \
       --num_partitions %d'

if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('-c',
                        '--config',
                        help='name of the global config file',
                        default='config.json')
	args = parser.parse_args()
	config = parse_json(args.config)

	# Get fingerprint parameter files
	fp_params = []
	param_dir = "../" + config["io"]["fp_param_dir"]
	fp_params = [param_dir + f for f in config["io"]["fp_params"]]

	chdir('simsearch')
	for fp_param in fp_params:
		fp = parse_json(fp_param)
		fp_stats = parse_json(get_fp_stats_file(fp))
		fp_path, ts_path = get_fp_ts_folders(fp)
		input_fp_file = get_combined_fp_name(fp)
		output_minhash_file, output_pairs_file = get_search_output_files(config, fp)

		cmd = searchCommand % (fp_path, input_fp_file,
			fp_path, output_minhash_file,
			fp_path, output_pairs_file,
			config["lsh_param"]["ntbl"],
			config["lsh_param"]["nhash"],
			fp_stats["nfp"],
			fp_stats["ndim"],
			config["lsh_param"]["repeat"],
			config["lsh_param"]["nvote"],
			config["lsh_param"]["nthread"],
			config["lsh_param"]["npart"])
		print cmd
		process = subprocess.Popen(cmd,
				stdout=subprocess.PIPE, shell=True)
		output, error = process.communicate()
		print output

