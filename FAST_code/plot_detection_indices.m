function [] = plot_detection_indices(cc_i, cc_j, cc_values, dt, ...
    string_title, y_title)
% Plots CC values (autocorrelation) or probabilities (fingerprint) of all
% detections, as a function of detection index converted to time (s) in
% the time series data
%
% This is an easy way to visualize detection outputs
%
% Inputs
% cc_indices:   indices of detections in time series data
% cc_values:    CC values or probabilities of detections in time series
%               data - should correspond to each element in cc_indices
% dt:           time between adjacent samples in time series data (s)
% string_title: string containing title for plot
% y_title:      string containing y-axis label for plot
%

% Get indices of the CC values or probabilities sorted in descending order.
% Convert detection indices to time (s) when plotting
% [a, ix] = sort(cc_values, 'descend');

% Plot CC values or probabilities, as a function of detection times
figure
set(gca, 'FontSize', 16)
plot(cc_i*dt, cc_values, 'bo', cc_j*dt, cc_values, 'ko');
xlabel('Time (s)'); ylabel(y_title); title(string_title, 'interpreter', 'none');
% legend('index i rows', 'index j columns');

% ylim([0 1.5]);

% xlim([0 2678400]); % 1 month = 31 days = 744 hr
% xlim([0 2592000]); % 1 month = 30 days = 720 hr
% xlim([0 604800]); % 1 wk = 168 hr
% xlim([0 86400]); % 24 hr
% xlim([0 43200]); % 12 hr
% xlim([0 28800]); % 8 hr
% xlim([0 14400]); % 4 hr
% xlim([0 7200]); % 2 hr
xlim([0 3600]); % 1 hr

end

