import datetime
from dateutil.relativedelta import relativedelta
# Fingerprinting parameter
Fs = 100
minfreq    = 2.0
maxfreq    = 20.0
spec_length = 6.0
spec_lag    = 0.2
fp_length   = 128
fp_lag      = 10
nfreq = 32
ntimes = 64
min_fp_length = fp_length * spec_lag + spec_length
sampling_rate = 0.01

# FP performance parameter
partition_len = datetime.timedelta(hours=8)
NUM_FP_THREAD = 4

# Data parameter
data_folder = 'bp2to20_waveforms%s/'
station = 'KHZ'
channel = 'HHZ'
INTERVAL = relativedelta(months=+1)
