% Driver for N.HIYH.N 1 hour data (Japan tremor), 2-8 Hz in spectrogram?

% Get data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('N_HIYH_N_01hr');
nx = length(x);

% % Get spectrogram
partitionIndex = 1;
specFlag = 0; % read spectrogram from file
numPartitions = 1;
windowDuration = 10.0; % window duration (s)
lagTime = 0.08; % lag time (s)
[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    partitionIndex, specFlag, numPartitions, 'N_HIYH_N_01hr', ...
    windowDuration, lagTime);

% Make fingerprints
s = size(specData.P);
bandStartIndex = 1;
bandEndIndex = s(1);
fingerprintLength = 125; % number of time samples in spectral image
% fingerprintLag = 10; % number of time samples between spectral images
fingerprintLag = 5;
t_value = 400; % number of top wavelet coefficients to keep
[binaryFingerprint, dt_fp] = spec_fingerprint(specData.P, specSettings, ...
    bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
% [binaryFingerprint, dt_fp] = data_1hr_fingerprint(specData, specSettings, x, ...
%     bandStartIndex, bandEndIndex, fingerprintLength);

% Check for similar window pairs
nfuncs = 4;
ntbls = 100;
ntrials = 1;
nvotes = 2;
detdata = similarity_search(binaryFingerprint, dt_fp, nfuncs, ntbls, ...
    ntrials, nvotes);