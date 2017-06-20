% Driver for AZ KNW 24 hour data, bandpass 1-10 Hz

% Get data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('AZ_KNW_24hr');
nx = length(x);
% clear t x;

% Spectrogram parameters
% specFlag = 0; % read spectrogram from file
specFlag = 1;
numPartitions = 3;
windowDuration = 12.8; % window duration (s)
lagTime = 0.1; % lag time (s)

% fingerprint parameters
fingerprintLength = 150; % number of time samples in spectral image
fingerprintLag = 10; % number of time samples between spectral images
t_value = 400; % number of top wavelet coefficients to keep

%--------1---------

% % Get spectrogram
% % 0 is dummy variable in place of x (since I read in spectrogram from file)
% [specData, specSettings] = get_spectrogram(0, nx, samplingRate, ...
%     1, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);
% 
% s = size(specData.P);
% bandStartIndex = 1;
% bandEndIndex = s(1);

% % Make fingerprints
% [currentFp1, dt_fp] = spec_fingerprint(specData.P, specSettings, ...
%     bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
% clear specData specSettings;

[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    1, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);

%--------2---------

% Get spectrogram
% 0 is dummy variable in place of x (since I read in spectrogram from file)
% [specData, specSettings] = get_spectrogram(0, nx, samplingRate, ...
%     2, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);
% 
% % Make fingerprints
% [currentFp2, dt_fp] = spec_fingerprint(specData.P, specSettings, ...
%     bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
% clear specData specSettings;

[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    2, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);

%--------3---------

% Get spectrogram
% 0 is dummy variable in place of x (since I read in spectrogram from file)
% [specData, specSettings] = get_spectrogram(0, nx, samplingRate, ...
%     3, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);
% 
% % Make fingerprints
% [currentFp3, dt_fp] = spec_fingerprint(specData.P, specSettings, ...
%     bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
% clear specData specSettings;

[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    3, specFlag, numPartitions, 'AZ_KNW_24hr', windowDuration, lagTime);

% Combine all fingerprints
binaryFingerprint = [currentFp1 currentFp2 currentFp3];
clear currentFp1 currentFp2 currentFp3;


% % Read in fingerprints
% load('fingerprints_AZ_KNW_24hr_default.mat');
% % dt_fp = 1.0;
% 
% % Check for similar window pairs
% nfuncs = 6;
% ntbls = 10;
% ntrials = 1;
% detdata = similarity_search(binaryFingerprint, dt_fp, nfuncs, ntbls, ntrials);