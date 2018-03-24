import json
import datetime
from os import listdir, makedirs
from os.path import isfile, join, abspath, dirname, exists
from feature_extractor import FeatureExtractor
import math

def parse_json(param_json):
    with open(param_json) as json_data_file:
        params = json.load(json_data_file)
    return params

def should_include_file(f, params):
    return params['data']['station'] in f and \
        params['data']['channel'] in f

def init_folder(folders):
    for folder in folders:
        if not exists(folder):
            makedirs(folder)

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

def get_combined_fp_name(params):
    final_fp_name = '%s.%s.fp' % (
        params['data']['station'], params['data']['channel'])
    return final_fp_name

def get_fp_stats_file(params):
    return '%s%s_%s.json' %(params["data"]["folder"], params["data"]["station"],
        params["data"]["channel"])

def save_fp_stats(params, nfp, ndim):
    fp_stats = {"station": params["data"]["station"],
        "channel": params["data"]["channel"],
        "nfp": nfp,
        "ndim": ndim}
    fname = get_fp_stats_file(params)
    with open(fname, 'w') as f:
        json.dump(fp_stats, f)

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
    mad_folder = params['data']['folder'] + 'mad/'
    init_folder([mad_folder])
    return mad_folder + 'mad%s_%s_%f_%.0f_%s_%s.txt' % (
        params['data']['station'],
        params['data']['channel'],
        params['fingerprint']['mad_sampling_rate'],
        params['fingerprint']['mad_sample_interval'],
        params['data']['start_time'],
        params['data']['end_time'] )

# Return the largest power of 2 less than or equal to n
def lower_power_2(n):
   return 2**(int(math.log(n, 2)))

def get_ntimes(params):
    return lower_power_2(params['fingerprint']['fp_length'])

def init_feature_extractor(params):
    feats = FeatureExtractor(sampling_rate=params['fingerprint']['sampling_rate'],
        window_length=params['fingerprint']['spec_length'],
        window_lag=params['fingerprint']['spec_lag'],
        fingerprint_length=params['fingerprint']['fp_length'],
        fingerprint_lag=params['fingerprint']['fp_lag'],
        min_freq=params['fingerprint']["min_freq"],
        max_freq=params['fingerprint']["max_freq"],
        nfreq = params['fingerprint']['nfreq'], 
        ntimes = get_ntimes(params))
    return feats


def get_partition_padding(params):
    # add this to end of time series of each partition so we don't have missing fingerprints
    sec_extra = params['fingerprint']['spec_length'] + \
        (params['fingerprint']['fp_length'] - params['fingerprint']['fp_lag']) * \
        params['fingerprint']['spec_lag']
    time_extra = datetime.timedelta(seconds=sec_extra)
    return time_extra

