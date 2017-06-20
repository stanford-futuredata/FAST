function [settings] = setup_spectrogram_settings(nx, samplingRate, ...
    numPartitions, dataFolder, dataName, windowDuration, lagTime)
% Set up spectrogram settings for pspectrogram library
%
% Inputs
% nx:                Number of samples in x
% samplingRate:      Sampling rate for data (samples/s)
% numPartitions:     Number of spectrogram partitions
% dataFolder:        Path to folder with spectrograms
% dataName:          Starting string for spectrogram files
% windowDuration:    length of time window (s)
% lagTime:           lag time between adjacent time windows (s)
%
% Outputs
% settings:          Parameters related to spectrogram formation - struct
%

% Spectrogram parameters - calculated
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples
windowOverlap = windowLength - lagLength; % number of overlap samples

settings.range = [1,nx];
settings.wnd_len = windowLength;
settings.noverlap = windowOverlap;
settings.nfft = settings.wnd_len;
settings.fs = samplingRate;
settings.data.dir = dataFolder;
settings.data.name = dataName;
settings.plength = nx/numPartitions;
assert(mod(nx,numPartitions) == 0, ' length(x) must be divisible by numPartitions.');
settings = pspectrogram_default_settings(settings);
settings.lagTime = lagTime;

end

