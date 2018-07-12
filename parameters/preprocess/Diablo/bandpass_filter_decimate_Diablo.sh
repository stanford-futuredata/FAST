#!/bin/bash

# dawn12
python bandpass_filter_decimate.py PG DCD EHZ 4 8 4
python bandpass_filter_decimate.py PG DCD EHN 4 8 4
python bandpass_filter_decimate.py PG DCD EHE 4 8 4

python bandpass_filter_decimate.py PG EFD EHZ 3 7 4
python bandpass_filter_decimate.py PG EFD EHN 3 7 4
python bandpass_filter_decimate.py PG EFD EHE 3 7 4

python bandpass_filter_decimate.py PG MLD EHZ 4 10 4
python bandpass_filter_decimate.py PG MLD EHN 4 10 4
python bandpass_filter_decimate.py PG MLD EHE 4 10 4

python bandpass_filter_decimate.py NC PPB EHZ 5 10 4


# dawn9
python bandpass_filter_decimate.py PG DPD EHZ 4 12 4
python bandpass_filter_decimate.py PG DPD EHN 4 12 4
python bandpass_filter_decimate.py PG DPD EHE 4 12 4

python bandpass_filter_decimate.py PG EC EHZ 3 8 4

python bandpass_filter_decimate.py PG SH EHZ 4 10 4


# dawn7
python bandpass_filter_decimate.py PG LMD EHZ 4 12 4
python bandpass_filter_decimate.py PG LMD EHN 4 12 4
python bandpass_filter_decimate.py PG LMD EHE 4 12 4

python bandpass_filter_decimate.py PG LSD EHZ 5 12 4
python bandpass_filter_decimate.py PG LSD EHN 5 12 4
python bandpass_filter_decimate.py PG LSD EHE 5 12 4

python bandpass_filter_decimate.py PG SHD EHZ 6 12 4
python bandpass_filter_decimate.py PG SHD EHN 6 12 4
python bandpass_filter_decimate.py PG SHD EHE 6 12 4

python bandpass_filter_decimate.py PG VPD EHZ 4 12 4
python bandpass_filter_decimate.py PG VPD EHN 4 12 4
python bandpass_filter_decimate.py PG VPD EHE 4 12 4

python bandpass_filter_decimate.py NC PABB EHZ 4 12 4
