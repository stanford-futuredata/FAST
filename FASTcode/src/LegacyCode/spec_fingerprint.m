% Fingerprint generation prototype on 1 hr data
% Calaveras Fault, NCSN, station CCOB, 2011/01/08 00:00:00 to 01:00:00
% Clara Yoon, 2013-07-12
%
% No plots, so it should be faster
%
% Usage (last 5 input arguments are optional, defaults are provided):
%  [binaryFingerprint, dt_fp] = spec_fingerprint(P, specSettings,
%     bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
%
% Inputs
% P:                 Spectrogram
% specSettings:      Parameters related to spectrogram formation - struct
%
% Inputs (optional)
% windowDuration:    length of time window (s)
% lagTime:           lag time between adjacent time windows (s)
% bandStartIndex:    index of lowest frequency in band
% bandEndIndex:      index of highest frequency in band
% fingerprintLength: number of time samples in spectral image
% fingerprintLag:    number of lag samples in spectral image
% t_value:           number of wavelet values to keep
%
% Outputs
% binaryFingerprint: All fingerprints from data, logical(numbits,NWindows)
%                    numbits: Number of bits in each fingerprint
%                    NWindows: Number of fingerprints (windows)
% dt_fp:             Time lag between adjacent fingerprints (s)
% 

function [binaryFingerprint, dt_fp] = spec_fingerprint(P, specSettings, varargin)

s = size(P);

% Default values for input parameters
default_bandStartIndex = 1; % index of lowest frequency in band
default_bandEndIndex = s(1); % index of highest frequency in band
% default_fingerprintLength = 256; % number of time samples in spectral image
default_fingerprintLength = 100; % number of time samples in spectral image
% default_fingerprintLength = 64; % number of time samples in spectral image
% default_fingerprintLag = 128; % number of lag samples in spectral image
% default_fingerprintLag = 20; % number of lag samples in spectral image
default_fingerprintLag = 10; % number of lag samples in spectral image *
% default_fingerprintLag = 5; % number of lag samples in spectral image
default_t_value = 200; % number of wavelet values to keep

% Only want 5 optional inputs at most
if (nargin > 7)
    error('must not have more than 7 input parameters');
end

% Set defaults for optional inputs
optargs = {default_bandStartIndex ...
    default_bandEndIndex default_fingerprintLength, ...
    default_fingerprintLag, default_t_value};

% Overwrite defaults with optional inputs
optargs(1:nargin-2) = varargin;

% Place optional inputs in variables
[bandStartIndex, bandEndIndex, ...
    fingerprintLength, fingerprintLag, t_value] = optargs{:};

% Time lag between adjacent fingerprints (s) - output
dt_fp = fingerprintLag * specSettings.lagTime;

%%% END OF INPUT SECTION

% Need paths for wavelet transform
addpath('mdwt');
addpath('mdwt/cwl_lib');

% magnitude of band passed 4-10 Hz spectrogram
dim_P = size(P);
nfreqDS = 32;
filtspec = imresize(P, [nfreqDS dim_P(2)], 'bilinear');

% clear up memory
clear P;

% Divide up spectrogram into spectral images
dim_spec = size(filtspec); % use filtered spectrogram
nfreq_spec = dim_spec(1); % number of frequency bins in spectrogram
ntime_spec = dim_spec(2); % number of time samples in spectrogram

% Get number of spectral image windows, starting and ending indices
[NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(ntime_spec, 0, fingerprintLength, fingerprintLag);

% Downsample - spectral image dimensions need to be power of 2
nfreqPow2 = get_downsample_power_2(nfreq_spec);
fpLengthPow2 = get_downsample_power_2(fingerprintLength);

% Keep the sign of the top 200 values of wavelet (sorted by magnitude), set rest to 0
numPointsFP = nfreqPow2*fpLengthPow2;
numbits = 2*numPointsFP; % number of elements in fingerprint bit representation
binaryFingerprint = false(numbits, NWindows); % fingerprints (sign of top wavelets) as bits

% Loop over windows
time = tic;
for k=1:NWindows
    
    % Save spectral images as overlapping windows
    % Downsample both dimensions to be largest power of 2 <= original dimensions
    specImageOrig = filtspec(:,window_start_index(k):window_end_index(k));
    specImage = imresize(specImageOrig, [nfreqPow2 fpLengthPow2], 'bilinear');
    assert(sum(specImage(:) < 0) == 0,'downsampled image must not be negative');
    
    % Compute Haar wavelet transform
    currentHaarImage = mdwt(specImage, 'haar_2d');
    
    % Sort wavelet transformed values by magnitude (highest to lowest)
    currentHaarMagnitude = abs(currentHaarImage);
    [sortedHaar, indexHaar] = sort(currentHaarMagnitude(:), 'descend');
    clear sortedHaar;
    
    % For top t_value magnitude values of wavelet, store the sign
    % (-1 if negative, 0 if zero, 1 if positive)
    currentTopWavelet = zeros(numPointsFP, 1, 'double');
    currentTopWavelet(indexHaar(1:t_value)) = sign(currentHaarImage(indexHaar(1:t_value)));
    
    % Store sign as 2-bit representation
    % (01 if negative, 00 if zero, 10 if positive)
    binaryFingerprint(:,k) = convert_sign_to_bits(currentTopWavelet); 
end
disp(['fingerprint generation took: ' num2str(toc(time))]);

end
