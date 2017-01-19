function [] = plot_autocorr_time_windows(x_data, data, requested_cc, ...
    samplingRate, settings)
% Plots normalized time windows from a window pair detected by
% sliding window Fortran autocorrelation
%
% data and settings should already be read in using load_data.m
% Example: [data settings] = load_data('sigma5.bin'); 
%
% Inputs
% x_data:         time series data
% data:           structure from autocorrelation output, with indices of
%                 each window pair in x_data and associated CC values
% requested_cc:   CC value of desired time window pair to plot
% samplingRate:   number of samples per second in x_data
% windowDuration: time window duration (s)
%

% Find the index in the CC array containing the desired CC value
% (can have more than one index)
% requested_cc = 0.7205;
position = find(abs(data.cc-requested_cc) < 1e-4);

for k=1:length(position)
    % Extract each normalized time window in the pair
%     u = extract_window(x_data, data.cc_i(position(k)), settings.window_length);
%     v = extract_window(x_data, data.cc_j(position(k)), settings.window_length);
%     time_values = [1:settings.window_length]/samplingRate; % time axis values (s)

    num_samples = 250;
    u = extract_window(x_data, data.cc_i(position(k)), num_samples);
    v = extract_window(x_data, data.cc_j(position(k)), num_samples);
    time_values = [1:num_samples]/samplingRate; % time axis values (s)
    
    data.cc_i(position(k))
    data.cc_j(position(k))

    % Compare CC computed from time window pair with CC stored in data.cc
    % These values should match
%     sum(u.*v)
%     data.cc(position(k))

    % Plot both normalized time windows for comparison
    figure
    set(gca,'FontSize',18)
%     plot(time_values, v, 'r', time_values, u, 'b'); % overlap
    plot(time_values, u, 'b', time_values, v+0.5, 'r'); % offset
    legend(['start at ' num2str(double(data.cc_i(position(k)))/samplingRate) ' s'], ...
        ['start at ' num2str(double(data.cc_j(position(k)))/samplingRate) ' s'], ...
        'Location','NorthWest');
    title(['Normalized window pair comparison, CC = ', num2str(data.cc(position(k)))])
    xlabel('Time within window (s)')
    ylabel('Normalized amplitude')
end

end