from os import listdir, chdir
import subprocess
import argparse
from parse_config import *

fpCommand= 'python gen_fp.py %s'
idxCommand = 'python global_index.py %s'

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

	# Fingerprinting
	chdir('fingerprint')
	for param in fp_params:
		print "Fingerprinting %s" % param
		process = subprocess.Popen((fpCommand % (param)),
			stdout=subprocess.PIPE, shell=True)
		output, error = process.communicate()
		print output

	# Generate global index
	idx_dir = get_global_index_dir(config)
	print "Writing global index to %s" % idx_dir
	idx_config = {"index_folder": "../" + idx_dir,
		"fp_param_dir": param_dir,
		"fp_params": fp_params}
	idx_config_fname = param_dir + "global_indices.json"
	process = subprocess.Popen((idxCommand % (idx_config_fname)),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()

