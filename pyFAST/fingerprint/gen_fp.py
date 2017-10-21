import subprocess
from multiprocessing import Pool
import sys
import datetime
import json
import os
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

	# Preprocess to calculate MAD
	call_mad(params)

	# Fingerprint
	p = Pool(params['performance']['num_fp_thread'])
	files = params['data']['fingerprint_files']
	print (p.map(call_fingerprint, files))

	# Stich fingerprint files
	nfp = 0
	ntimes = get_ntimes(params)
	fp_in_bytes = params['fingerprint']['nfreq'] * ntimes / 4
	final_fp_name = '%s.%s.fp' % (params['data']['station'],
				params['data']['channel'])
	fp_path, ts_path = get_fp_ts_folders(params)
	if os.path.exists(final_fp_name):
		os.remove(final_fp_name)
	print "Combining into final fingerprint file %s" % final_fp_name

	for fname in files:
		fp_file = fp_path + get_fp_fname(fname)
		os.system("cat %s >> %s" % (fp_file, final_fp_name))

		# Verify number of fingerprints
		num_lines = sum(1 for line in open(ts_path + get_ts_fname(fname)))
		nfp += num_lines
		fsize = os.path.getsize(fp_file)
		if fsize / fp_in_bytes != num_lines:
			print "Exception: # fingerprints in %s don't match" % fname
			print "Fingerprint file: %d, timestamp file: %d" %(fsize / fp_in_bytes, num_lines)
			exit(1)

	fsize = os.path.getsize(final_fp_name)
	print "Fingerprint file size: %d bytes" % (fsize)
	print "# fingerprints: %d" %(nfp)



