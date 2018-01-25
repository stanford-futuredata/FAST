from os import listdir, chdir
from os.path import isfile, abspath, join
import subprocess
import argparse

fpCommand= 'python gen_fp.py %s'
idxCommand = 'python global_index.py %s'

if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('-d',
                        '--dir',
                        help='directory of fingerprint param files',
                        default='./')
	args = parser.parse_args()

	param_files = []
	index_param = []
	for f in listdir(args.dir):
		if isfile(join(args.dir, f)) and 'json' in f:
			if 'fp' in f:
				param_files.append(abspath(join(args.dir, f)))
			else:
				index_param.append(abspath(join(args.dir, f)))

	chdir('fingerprint')
	for param in param_files:
		print "Fingerprinting %s" % param
		process = subprocess.Popen((fpCommand % (param)),
			stdout=subprocess.PIPE, shell=True)
		output, error = process.communicate()

	print "Generating global index %s" % index_param[0]
	process = subprocess.Popen((idxCommand % (index_param[0])),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()

