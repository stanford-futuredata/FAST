% Fingerprint generation prototype on 1 hr data
% Calaveras Fault, NCSN, station CCOB, 2011/01/08 00:00:00 to 01:00:00
% Clara Yoon, 2013-09-06
%
% Creates binary fingerprints of time windows by digitizing their
% amplitudes into num_ampl bins
%
% Usage (input arguments are optional, defaults are provided):
%  [binaryFingerprint, dt_fp] = time_window_fingerprint(
%     windowDuration, lagTime, num_ampl);
%
% Inputs (optional)
% windowDuration:    length of time window (s)
% lagTime:           lag time between adjacent time windows (s)
% num_ampl:          number of amplitude bins to digitize waveform;
%                    must be ODD
%
% Outputs
% binaryFingerprint: All fingerprints from data, logical(numbits,NWindows)
%                    numbits: Number of bits in each fingerprint
%                    NWindows: Number of fingerprints (windows)
% dt_fp:             Time lag between adjacent fingerprints (s)
% 

function [binaryFingerprint, dt_fp] = time_window_fingerprint(x, samplingRate, varargin)

% Default values for input parameters
default_windowDuration = 10; % length of time window (s)
% default_lagTime = 0.1; % lag time between adjacent time windows (s)
% default_lagTime = 0.5; % lag time between adjacent time windows (s)
default_lagTime = 0.1; % lag time between adjacent time windows (s)
default_num_ampl = 15; % number of amplitude bins to digitize waveform

% Only want 3 optional inputs at most
if (nargin > 5)
    error('must not have more than 5 input parameters');
end

% Set defaults for optional inputs
optargs = {default_windowDuration default_lagTime default_num_ampl};

% Overwrite defaults with optional inputs
optargs(1:nargin-2) = varargin;

% Place optional inputs in variables
[windowDuration, lagTime, num_ampl] = optargs{:};

% Time lag between adjacent fingerprints (s) - output
dt_fp = lagTime;

%%% END OF INPUT SECTION


% Fingerprint parameters - calculated
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples

% Get number of fingerprint windows, starting and ending indices
[NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(length(x), 0, windowLength, lagLength);

% Minimum and maximum amplitudes
% Always the same for normalized time windows
min_ampl = -1.0;
max_ampl = 1.0;

% Amplitude bin spacing
delta_ampl = (max_ampl - min_ampl) / num_ampl;

% Number of bits per fingerprint
numbits = num_ampl * windowLength;

% Fingerprints stored as bits (sparse) - will be filled in by loop below
binaryFingerprint = false(numbits, NWindows); 

% Loop over windows
time = tic;
for k=1:NWindows
    
    % Select and normalize time window
    u = x(window_start_index(k):window_end_index(k));
    v = u / norm(u);
    
    % Fingerprint normalized waveform time window
    % It is 1 in every bin containing the amplitude of v (after digitizing)
    [v_bin_ind, vwaveformImage] = waveform_fingerprint(num_ampl, ...
        min_ampl, delta_ampl, v);
    binaryFingerprint(:,k) = reshape(vwaveformImage, numbits, 1);
end
disp(['fingerprint generation took: ' num2str(toc(time))]);

%%% ---------- Plot section ---------- %%%

% Fingerprint Indices to plot!!!!
plot_ind = [1:10:NWindows];

flag_plot_bit_fp = 0;
if (flag_plot_bit_fp)
    % Plot bit representations of fingerprints
    time_values = [1:windowLength]/samplingRate; % time axis values (s)
    figure
    set(gca, 'FontSize', 18)
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imageBinaryFp = reshape(binaryFingerprint(:,k), num_ampl, windowLength);
        imagesc(time_values, [1:num_ampl], imageBinaryFp);
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18); colormap('gray'); set(c1,'YTick',[0,1]);
        xlabel('Time (s)'); ylabel('Normalized Amplitude bin index');
        title(['Binary Fingerprints, window #' num2str(k)]);
        getframe(gcf);
    end
end

end
