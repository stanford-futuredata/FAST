% Driver for CCOB 1 hour data, 2-10 Hz in spectrogram

% Get data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_EHZ_01hr');
nx = length(x);

% Get spectrogram
partitionIndex = 1;
specFlag = 0; % read spectrogram from file
numPartitions = 1;
[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    partitionIndex, specFlag, numPartitions, 'NCSN_CCOB_EHZ_01hr');

% Make fingerprints
bandStartIndex = 21;
% [binaryFingerprint, dt_fp] = spec_fingerprint(specData.P, specSettings, bandStartIndex);
[binaryFingerprint, dt_fp] = data_1hr_fingerprint(specData, specSettings, x, bandStartIndex);

% Check for similar window pairs
nfuncs = 5;
ntbls = 30;
ntrials = 1;
detdata = similarity_search(binaryFingerprint, dt_fp, nfuncs, ntbls, ntrials);
