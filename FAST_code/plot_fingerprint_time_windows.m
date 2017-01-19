function [] = plot_fingerprint_time_windows(x_data, i_time, j_time, ...
    samplingRate, windowDuration)
% Plots normalized time windows from a window pair detected by
% fingerprint / similarity search
%
% Inputs
% x_data:         time series data
% i_time:         start time of one time window in the detected pair (s)
% j_time:         start time of other time window in the detected pair (s)
% samplingRate:   number of samples per second in x_data
% windowDuration: time window duration (s)
%

% Number of samples in each time window
numSamplesInWindow = samplingRate*windowDuration;

% Extract each normalized time window in the pair
u = extract_window(x_data, i_time*samplingRate, numSamplesInWindow);
v = extract_window(x_data, j_time*samplingRate, numSamplesInWindow);
time_values = [1:numSamplesInWindow]/samplingRate; % time axis values (s)

cc_out = correlation_coefficient(u,v)

% Plot both normalized time windows for comparison
figure
set(gca,'FontSize',18)
plot(time_values, u, 'b', time_values, v, 'r');
% yoffset = 0.2;
% plot(time_values, u+yoffset, 'b', time_values, v-yoffset, 'r'); % offset
legend(['start at ' num2str(i_time) ' s'], ...
    ['start at ' num2str(j_time) ' s'], 'Location','NorthWest');
title('Normalized window pair comparison')
xlabel('Time within window (s)')
ylabel('Normalized amplitude')
ylim([-0.8 0.8]);

end

