from obspy import read
from os import listdir
from os.path import isfile, join
import subprocess
from multiprocessing import Pool

path = 'waveformsKHZ/'
fnames = [f for f in listdir(path) if isfile(join(path, f))]
bashCommand = 'python finger_print.py %s'


def call_fingerprint(args):
	print "Fingerprinting " + str(args)
	process = subprocess.Popen((bashCommand % (args)),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()
	return output, error


p = Pool(12)

args = []
for fname in fnames:
	if 'mseed' in fname and not "HHN" in fname:
		args.append(fname)

print(p.map(call_fingerprint, args))

