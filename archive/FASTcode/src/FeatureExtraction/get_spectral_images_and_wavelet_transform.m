% get_spectral_images_and_wavelet_transform.m
%
% Adapted from spec_fingerprint.m
%
% Inputs
% P:                 Spectrogram
% specSettings:      Parameters related to spectrogram formation - struct
% startOffset:       number of samples to offset starting point by in the data (usually 0)
% fingerprintLength: number of time samples in spectral image
% fingerprintLag:    number of lag samples in spectral image
%
% Outputs
% specImages:        spectral images
% haarImages:        2d Haar wavelet transform of images
% NWindows:          number of spectral images
% dt_fp:             Time lag between adjacent fingerprints (s)
% 

function [specImages, haarImages, NWindows, dt_fp, run_time] = get_spectral_images_and_wavelet_transform(...
    P, specSettings, startOffset, fingerprintLength, fingerprintLag)

% Time lag between adjacent fingerprints (s) - output
dt_fp = fingerprintLag * specSettings.lagTime;

%%% END OF INPUT SECTION

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
    get_window_parameters(ntime_spec, startOffset, fingerprintLength, fingerprintLag);

% Downsample - spectral image dimensions need to be power of 2
nfreqPow2 = downsample_power_2(nfreq_spec);
fpLengthPow2 = downsample_power_2(fingerprintLength);

% Allocate arrays for spectral images and wavelet transforms
specImages = zeros(nfreqPow2, fpLengthPow2, NWindows);
haarImages = zeros(nfreqPow2, fpLengthPow2, NWindows);

% Loop over windows
time = tic;
for k=1:NWindows
    
    % Save spectral images as overlapping windows
    % Downsample both dimensions to be largest power of 2 <= original dimensions
    specImageOrig = filtspec(:,window_start_index(k):window_end_index(k));
    specImage = imresize(specImageOrig, [nfreqPow2 fpLengthPow2], 'bilinear');
    assert(sum(specImage(:) < 0) == 0,'downsampled image must not be negative');
    specImages(:,:,k) = specImage;
    
    % Compute Haar wavelet transform
    currentHaarImage = mdwt(specImage, 'haar_2d');
    haarImages(:,:,k) = currentHaarImage; 
end
run_time = toc(time);
disp(['spectral image and wavelet transform took: ' num2str(run_time)]);

end