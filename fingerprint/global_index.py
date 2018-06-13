import datetime
import sys
import linecache
import os
from util import *
from multiprocessing import Pool
import json

def compute_global_index(param_file):
	params = parse_json(param_file)
	idx_interval = params['fingerprint']['fp_lag'] * params['fingerprint']['spec_lag']
	station = params['data']['station']
	channel = params['data']['channel']
	_, ts_path = get_fp_ts_folders(params)
	f = open('%s%s_%s_idx_mapping.txt' % (config['index_folder'],
		station, channel), 'w')
	for fname in params['data']['fingerprint_files']:
		ts_file = open(ts_path + get_ts_fname(fname), 'r')
		for line in ts_file.readlines():
			t = datetime.datetime.strptime(line.strip(), 
				"%y-%m-%dT%H:%M:%S.%f")
			idx = round((t - min_time).total_seconds() / idx_interval)
			f.write("%d\n" % idx)
		ts_file.close()
	f.close()

if __name__ == '__main__':
	config = parse_json(sys.argv[1])

	min_time = None
	for param_file in config['fp_params']:
	        print config['fp_param_dir']+param_file
		params = parse_json(config['fp_param_dir']+param_file)
		_, ts_path = get_fp_ts_folders(params)
		ts_fname = ts_path + get_ts_fname(params['data']['fingerprint_files'][0])
		tmp = datetime.datetime.strptime(linecache.getline(ts_fname, 1).strip(), 
			"%y-%m-%dT%H:%M:%S.%f")
		if min_time is None:
			min_time = tmp
		elif tmp < min_time:
			min_time = tmp

	# Save stats to file
	if not os.path.exists(config['index_folder']):
		os.makedirs(config['index_folder'])
	f = open('%sglobal_idx_stats.txt' % config['index_folder'], 'w')
	f.write('%s\n' % min_time.strftime("%Y-%m-%dT%H:%M:%S.%f"))
	f.write('%s\n' % ','.join(config['fp_params']))
	f.close()

        # Attach input folder to filename
	for ip,param_file in enumerate(config['fp_params']):
                config['fp_params'][ip] = config['fp_param_dir']+param_file

	p = Pool(len(config['fp_params']))
	p.map(compute_global_index, config['fp_params'])
	p.terminate()
