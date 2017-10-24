Example:
  python gen_fp.py sample_params.json

Example fingerprint parameter settings:
  {
    "fingerprint": {                (fingerprint settings)
        "sampling_rate": 100,         (sampling rate in Hz)
        "min_freq": 2.0,              (min bandpass frequency in Hz)
        "max_freq": 20.0,             (max bandpass frequency in Hz)
        "spec_length": 6.0,           (length of spectrogram window in seconds)
        "spec_lag": 0.2,              (lag between neighboring spectrogram windows in seconds)
        "fp_length": 128,             (fingerprint length in samples)
        "fp_lag": 10,                 (fingerprint lag in samples)
        "k_coef": 1600,               (number of top haar wavelet coefficients to keep)
        "nfreq": 32,                  (number of frequency / time bins in fingerprints (must be power of 2))
        "mad_sampling_rate": 0.1,     (sampling rate for calculating MAD statistics)
        "mad_sample_interval": 14400  (sampling interval for calculating MAD statistics in seconds)
    },

    "performance": {               (performance settings)
        "num_fp_thread": 12,          (number of threads)
        "partition_len": 28800        (fingerprint partition length in seconds)
    },

    "data": {                      (data settings)
        "station": "KHZ",
        "channel": "HHZ",
        "start_time": "10-01-01T00:00:00.0",
        "end_time": "10-06-01T00:00:00.0",
        "folder": "../bp2to20_waveformsKHZ/",
        "fingerprint_files": [
            "bp2to20.NZ.KHZ.10.HHZ__20100101T000000Z__20100201T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100201T000000Z__20100301T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100301T000000Z__20100401T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100401T000000Z__20100501T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100501T000000Z__20100601T000000Z.mseed"],
        "MAD_sample_files": [
            "bp2to20.NZ.KHZ.10.HHZ__20100101T000000Z__20100201T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100201T000000Z__20100301T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100301T000000Z__20100401T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100401T000000Z__20100501T000000Z.mseed",
            "bp2to20.NZ.KHZ.10.HHZ__20100501T000000Z__20100601T000000Z.mseed"]
    }
}
