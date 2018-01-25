import json

def parse_json(param_json):
    with open(param_json) as json_data_file:
        params = json.load(json_data_file)
    return params

def get_pairs_filenames(param_json):
	detdata_filenames = []
	for cha in param_json["io"]["channel_vars"]:
  		detdata_filenames.append(param_json["io"]["fname_template"] % cha)
  	return detdata_filenames

def get_network_fname(param_json):
	return get_output_folder(param_json) + \
		'%dsta_%dstathresh' % (len(param_json["io"]["channel_vars"]),
			param_json["network"]["nsta_thresh"])

def get_min_sum(param_json):
	return param_json["network"]["min_sum_multiplier"] * \
		param_json["network"]["ivals_thresh"] * \
		param_json["network"]["min_dets"]

def get_data_folder(param_json):
	return param_json["io"]["base_dir"] + param_json["io"]["data_folder"]

def get_output_folder(param_json):
	return param_json["io"]["base_dir"] + param_json["io"]["out_folder"]