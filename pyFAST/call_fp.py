from obspy import read
from os import listdir
from os.path import isfile, join
import subprocess
from multiprocessing import Pool
import sys

path = 'bp2to20_waveforms%s/'
bashCommand = 'python finger_print.py %s %s'


def call_fingerprint(args):
	print "Fingerprinting " + str(args)
	process = subprocess.Popen((bashCommand % (args, station)),
			stdout=subprocess.PIPE, shell=True)
	output, error = process.communicate()
	return output, error


if __name__ == '__main__':
	station = sys.argv[1]
	p = Pool(4)

	args = []
	fnames = [f for f in listdir(path % station) if isfile(join(path % station, f))]
	for fname in fnames:
		if 'mseed' in fname and "HHZ" in fname:
			if not '2010' in fname and not '2011' in fname:
				args.append(fname)

	print(p.map(call_fingerprint, args))

