% Usage:
%  [binaryFingerprint] = get_fingerprints_3component(stdHaarImages, t_value);
%
% Adapted from spec_fingerprint.m
%
% Inputs
% stdHaarImages:   2d Haar transformed spectral images (all components)
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
% 

function [binaryFingerprint, partRuntime] = get_fingerprints_3component(stdHaarImages, t_value)
% function [topWaveletImages, binaryFingerprint, partRuntime] = get_fingerprints_3component(stdHaarImages, t_value) % debug

s = size(stdHaarImages);
numPointsFP = s(1);
NWindows = s(2);
numbits = 2*numPointsFP; % number of elements in fingerprint bit representation
binaryFingerprint = false(numbits, NWindows); % fingerprints (sign of top wavelets) as bits

time = tic;

% topWaveletImages = zeros(nfreq, fpLength, NWindows, 'double'); % debug

% Loop over windows
for k=1:NWindows   
    % Sort wavelet transformed values by magnitude (highest to lowest)
    currentHaarImage = stdHaarImages(:,k);
    currentHaarMagnitude = abs(currentHaarImage);
    [sortedHaar, indexHaar] = sort(currentHaarMagnitude(:), 'descend');
    clear sortedHaar;
    
    % For top t_value magnitude values of wavelet, store the sign
    % (-1 if negative, 0 if zero, 1 if positive)
    currentTopWavelet = zeros(numPointsFP, 1, 'double');
    currentTopWavelet(indexHaar(1:t_value)) = sign(currentHaarImage(indexHaar(1:t_value)));
%     topWaveletImages(:,:,k) = reshape(currentTopWavelet, nfreq, fpLength); % debug
    
    % Store sign as 2-bit representation
    % (01 if negative, 00 if zero, 10 if positive)
    binaryFingerprint(:,k) = convert_sign_to_bits(currentTopWavelet); 
end
partRuntime = toc(time);
disp(['binary fingerprint generation took: ' num2str(partRuntime)]);

end
