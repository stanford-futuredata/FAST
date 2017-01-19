function [specData, settings] = get_spectrogram(x, nx, samplingRate, ...
    partitionIndex, varargin)
% Get spectrogram from data
%
% Usage (last 3 input arguments are optional, defaults are provided):
%  [specData, settings] = get_spectrogram(x, nx, samplingRate, partitionIndex,
%     specFlag, numPartitions, dataFolder, windowDuration, lagTime);
%
% Inputs
% x:                 Time series data (can pass in dummy if specFlag=0)
% nx:                Number of samples in x
% samplingRate:      Sampling rate for data (samples/s)
% partitionIndex:    Spectrogram partition index
%
% Inputs (optional)
% specFlag:          0 = read spectrogram from file (default), 1 = compute spectrogram
% numPartitions:     Number of spectrogram partitions (default for 24 hrs)
% dataFolder:        Path to folder with spectrograms
% windowDuration:    length of time window (s)
% lagTime:           lag time between adjacent time windows (s)
%
% Outputs
% specData:          Spectrogram (specData.P)
%                    Time samples (specData.T)
%                    Frequency samples (specData.F)
% settings:          Parameters related to spectrogram formation - struct
% 

default_specFlag = 0; % 0 = read spectrogram from file, 1 = compute spectrogram
default_numPartitions = 3; % number of spectrogram partitions (default for 24 hrs)
default_dataFolder = 'NCSN_CCOB_24hr'; % path to folder with spectrograms
default_windowDuration = 10; % length of time window (s)
default_lagTime = 0.1; % lag time between adjacent time windows (s)
% default_lagTime = 0.2;

% Only want 5 optional inputs at most
if (nargin > 9)
    error('must not have more than 9 input parameters');
end

% Set defaults for optional inputs
optargs = {default_specFlag default_numPartitions default_dataFolder ...
    default_windowDuration default_lagTime};

% Overwrite defaults with optional inputs
optargs(1:nargin-4) = varargin;

% Place optional inputs in variables
[specFlag, numPartitions, dataFolder, windowDuration, lagTime] = optargs{:};

% Spectrogram parameters - calculated
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples
windowOverlap = windowLength - lagLength; % number of overlap samples

addpath('pspectrogram');
settings.range = [1,nx];
settings.wnd_len = windowLength;
settings.noverlap = windowOverlap;
settings.nfft = settings.wnd_len;
settings.fs = samplingRate;
settings.data.dir = 'pspectrogram/';
settings.data.name = dataFolder;
settings.plength = nx/numPartitions;
assert(mod(settings.plength,numPartitions) == 0, ' length(x) must be divisible by 3.');
settings = pspectrogram_default_settings(settings);
settings.lagTime = lagTime;

% Get spectrogram
if (specFlag)
    pspectrogram(x,settings);
else
    specData = load_pspectrogram(settings.data, partitionIndex, {'F','T','P'});
end

end

