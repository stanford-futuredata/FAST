import json
import datetime
from os import listdir
from os.path import isfile, join, abspath, dirname
from feature_extractor import FeatureExtractor

def parse_json(param_json):
    with open(param_json) as json_data_file:
        params = json.load(json_data_file)
    return params

def should_include_file(f, params):
    return params['data']['station'] in f and \
        params['data']['channel'] in f

def get_fp_ts_folders(params):
    fp_folder = params['data']['folder'] + 'fingerprints/'
    ts_folder = params['data']['folder'] + 'timestamps/'
    return fp_folder, ts_folder

def get_ts_fname(mseed_fname):
    idx = mseed_fname.rfind('.')
    return "ts_" + mseed_fname[:idx]

def get_fp_fname(mseed_fname):
    idx = mseed_fname.rfind('.')
    return "fp_" + mseed_fname[:idx]

def get_data_files(params):
    path = abspath(join(dirname(__file__), params['data']['folder']))
    files = []
    for f in listdir(path):
        if isfile(join(path, f)) and should_include_file(f, params):
            files.append(f)
    return files

def get_min_fp_length(params):
    return params['fingerprint']['fp_length'] * params['fingerprint']['spec_lag'] + \
        params['fingerprint']['spec_length']

def get_start_end_times(params):
    start_time = datetime.datetime.strptime(params['data']['start_time'], 
        "%y-%m-%dT%H:%M:%S.%f")
    end_time = datetime.datetime.strptime(params['data']['end_time'], 
        "%y-%m-%dT%H:%M:%S.%f")
    return (start_time, end_time)

def gen_mad_fname(params):
    return 'mad%s_%s_%f_%.0f_%s_%s.txt' % (
        params['data']['station'],
        params['data']['channel'],
        params['fingerprint']['mad_sampling_rate'],
        params['fingerprint']['mad_sample_interval'],
        params['data']['start_time'],
        params['data']['end_time'] )

def init_feature_extractor(params):
    feats = FeatureExtractor(sampling_rate=params['fingerprint']['sampling_rate'],
        window_length=params['fingerprint']['spec_length'],
        window_lag=params['fingerprint']['spec_lag'],
        fingerprint_length=params['fingerprint']['fp_length'],
        fingerprint_lag=params['fingerprint']['fp_lag'],
        min_freq=params['fingerprint']["min_freq"],
        max_freq=params['fingerprint']["max_freq"])
    return feats

