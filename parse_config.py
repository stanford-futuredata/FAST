import json
from os import listdir, makedirs
from os.path import isfile, join, abspath, dirname, exists

minhash_template = "mh_%s_%s_%d.bin"
pairs_template = "candidate_pairs_%s_%s_%d,%d"

def parse_json(param_json):
    with open(param_json) as json_data_file:
        params = json.load(json_data_file)
    return params

def get_global_index_dir(param):
    return param["io"]["base_dir"] + param["io"]["global_index_dir"]

def get_fp_dir(fp_param):
	return param['data']['folder'] + 'fingerprints/'

def get_search_output_files(param, fp_param):
	output_minhash_file = minhash_template % (fp_param["data"]["station"],
		fp_param["data"]["channel"], param["lsh_param"]["nhash"])
	output_pairs_file = pairs_template % (fp_param["data"]["station"],
		fp_param["data"]["channel"],
		param["lsh_param"]["nhash"],
		param["lsh_param"]["nvote"])
	return output_minhash_file, output_pairs_file

