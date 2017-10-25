function [] = view_detection_indices(index_range, cc_i, cc_j, cc_values, dt)
% Outputs CC values (autocorrelation) or probabilities (fingerprint) of all
% detections, as a function of detection index converted to time (s) in
% the time series data
%
% Inputs
% index_range:  Range of indices to view
% cc_i:         Index of first window in pair
% cc_j:         Index of second window in pair
% cc_values:    CC values or probabilities of detections in time series
%               data - for each (cc_i, cc_j)
% dt:           time between adjacent samples in time series data (s)
%

% % Get indices of the CC values or probabilities sorted in descending order.
[a, ix] = sort(cc_values, 'descend');

% 'cc_i = ', double(cc_i(ix(index_range))), double(cc_i(ix(index_range)))*dt
% 'cc_j = ', double(cc_j(ix(index_range))), double(cc_j(ix(index_range)))*dt
% 'cc_values = ', double(cc_values(ix(index_range)))

format long g;
% [cc_i(ix(index_range)) cc_j(ix(index_range)) cc_values(ix(index_range))]
[double(cc_i(ix(index_range)))*dt double(cc_j(ix(index_range)))*dt cc_values(ix(index_range))]

% 'cc_i = ', cc_i(index_range), double(cc_i(index_range))*dt
% 'cc_j = ', cc_j(index_range), double(cc_j(index_range))*dt
% 'cc_values = ', cc_values(index_range)

end

