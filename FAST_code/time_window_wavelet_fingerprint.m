% Fingerprint generation prototype on 1 hr data
% Calaveras Fault, NCSN, station CCOB, 2011/01/08 00:00:00 to 01:00:00
% Clara Yoon, 2013-11-03
%
% Creates binary fingerprints of time windows by digitizing their
% top magnitude wavelet coefficients into bins
%
% Usage (input arguments are optional, defaults are provided):
%  [binaryFingerprint, dt_fp] = time_window_wavelet_fingerprint(
%     windowDuration, lagTime);
%
% Inputs (optional)
% windowDuration:    length of time window (s)
% lagTime:           lag time between adjacent time windows (s)
%
% Outputs
% binaryFingerprint: All fingerprints from data, logical(numbits,NWindows)
%                    numbits: Number of bits in each fingerprint
%                    NWindows: Number of fingerprints (windows)
% dt_fp:             Time lag between adjacent fingerprints (s)
% 

function [binaryFingerprint, dt_fp] = time_window_wavelet_fingerprint(x, samplingRate, varargin)

% Default values for input parameters
default_windowDuration = 12.8; % length of time window (s)
% default_lagTime = 0.1; % lag time between adjacent time windows (s)
% default_lagTime = 0.5; % lag time between adjacent time windows (s)
% default_lagTime = 0.3; % lag time between adjacent time windows (s)
default_lagTime = 0.1;

% Only want 3 optional inputs at most
if (nargin > 5)
    error('must not have more than 5 input parameters');
end

% Set defaults for optional inputs
optargs = {default_windowDuration default_lagTime};

% Overwrite defaults with optional inputs
optargs(1:nargin-2) = varargin;

% Place optional inputs in variables
[windowDuration, lagTime] = optargs{:};

% Time lag between adjacent fingerprints (s) - output
dt_fp = lagTime;

t = t(1:36000);
x = x(1:36000);

%%% END OF INPUT SECTION

% Need paths for wavelet transform
addpath('mdwt');
addpath('mdwt/cwl_lib');

% Fingerprint parameters - calculated
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples

log2_windowLength = log2(windowLength);
if (floor(log2_windowLength) ~= log2_windowLength)
    error('number of samples in each time window must be power of 2');
end

% Get number of fingerprint windows, starting and ending indices
[NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(length(x), 0, windowLength, lagLength);

% Parameters for binary image fingerprint generation
dx = 0.04; % wavelet coefficient amplitude spacing for quantization
thres = dx;
xmax = 1.0;

% dx = 0.01;
% xmax = 0.5;
% thres = dx;
n_coeff_bins = 2*(xmax - thres)/dx;

% Number of bits per fingerprint
numbits = n_coeff_bins * windowLength;

% Fingerprints stored as bits (sparse) - will be filled in by loop below
binaryFingerprint = false(numbits, NWindows); 

% Number of wavelet coefficients to keep
t_value = 32;

% Loop over windows
time = tic;
for k=1:NWindows
    % Select and normalize time window
    u = x(window_start_index(k):window_end_index(k));
    v = u / norm(u);
    
    % Get top magnitude Haar coefficients for normalized time window
    [haar_v, haar_v_top] = get_top_magnitude_1d_haar_coeff(t_value, v);
    
    % Compute binary image fingerprint from top magnitude wavelet coefficients
    fp_haar_v_top = dsqf(haar_v_top,dx,xmax,thres);

%     haar_v_top_sq = haar_v_top.*haar_v_top;
%     fp_haar_v_top = dsqf(haar_v_top_sq,dx,xmax,thres);
    
    % Fingerprint normalized waveform time window
    % It is 1 in every bin containing the amplitude of v (after digitizing)
    binaryFingerprint(:,k) = reshape(fp_haar_v_top, numbits, 1);
end
disp(['fingerprint generation took: ' num2str(toc(time))]);

%%% ---------- Plot section ---------- %%%

% Fingerprint Indices to plot!!!!
plot_ind = [1:10:NWindows];

flag_plot_bit_fp = 0;
if (flag_plot_bit_fp)
    % Plot bit representations of fingerprints
    time_indices = [1:windowLength]; % time axis indices
    figure
    set(gca, 'FontSize', 18)
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imageBinaryFp = reshape(binaryFingerprint(:,k), windowLength, n_coeff_bins);
        imagesc(time_indices, [1:n_coeff_bins], imageBinaryFp');
        set(gca, 'YDir', 'normal');
        colormap('gray');
        xlabel('Wavelet coefficient index'); ylabel('Wavelet coefficient bin');
        title(['Binary Fingerprints, window #' num2str(k)]);
        getframe(gcf);
    end
end

end
