import subprocess
from multiprocessing import Pool
import sys
import datetime
import json
from util import *

madStatsCommand= 'python MAD.py %s'
fingerprintCommand = 'python finger_print.py %s %s'

def call_fingerprint(args):
	print "Fingerprinting " + str(args)
	process = subprocess.Popen((fingerprintCommand % (args, param_json)),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()
	return output, error

def call_mad(params):
	print "Processing for MAD"
	process = subprocess.Popen((madStatsCommand % (param_json)),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()
	print output

if __name__ == '__main__':
	param_json = sys.argv[1]
	params = parse_json(param_json)
	start_time, end_time = get_start_end_times(params)

	# Preprocess to calculate MAD
	call_mad(params)

	# Fingerprint
	p = Pool(params['performance']['num_fp_thread'])
	args = []
	files = get_data_files(params)
	print files
	print (p.map(call_fingerprint, files))
	# t = start_time
	# while t < end_time:
	# 	fname = construct_filename(t, params['data']['station'])
	# 	args.append(fname)
	# 	t += params.INTERVAL
	# print(p.map(call_fingerprint, args))

