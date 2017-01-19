% get_window_parameters
% Compute number of windows, and their starting and ending indices
%
% Inputs
% N: number of samples in 'time series' data
% startOffset: number of samples to offset starting point by in the data (usually 0)
% windowLength: desired number of samples in each window
% lagSize: desired number of samples in lag between 2 adjacent windows
%
% note: overlap = windowLength - lagSize
%
% Outputs
% NWindows: number of windows
% window_start_index: array with start index of each window
% window_end_index: array with end index of each window
% 
function [NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(N, startOffset, windowLength, lagSize)

% Get number of windows, use definition from MATLAB's spectrogram()
NWindows = fix((N-startOffset - (windowLength-lagSize)) / lagSize);

% Compute window starting and ending indices
window_start_index = int32(1 + startOffset + [0:NWindows-1]*lagSize);
window_end_index = int32(window_start_index + (windowLength - 1));

end