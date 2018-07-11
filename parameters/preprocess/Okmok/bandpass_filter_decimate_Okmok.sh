#!/bin/bash

python bandpass_filter_decimate.py AVO OKAK EHZ 5 12 1

python bandpass_filter_decimate.py AVO OKFG BHZ 5 12 1
python bandpass_filter_decimate.py AVO OKFG BHN 5 12 1
python bandpass_filter_decimate.py AVO OKFG BHE 5 12 1

python bandpass_filter_decimate.py AVO OKRE EHZ 5 12 1

python bandpass_filter_decimate.py AVO OKSO BHZ 5 12 1
python bandpass_filter_decimate.py AVO OKSO BHN 5 12 1
python bandpass_filter_decimate.py AVO OKSO BHE 5 12 1

python bandpass_filter_decimate.py AVO OKSP EHZ 5 12 1

python bandpass_filter_decimate.py AVO OKWE EHZ 5 12 1

python bandpass_filter_decimate.py AVO OKWR EHZ 5 12 1
