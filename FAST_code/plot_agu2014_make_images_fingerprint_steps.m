close all
clear

% Plot steps of fingerprint algorithm
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CADB_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CAO_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CHR_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CML_EHZ_24hr');
last_index = 72001; % 1 hr
t = t(1:last_index);
x = x(1:last_index);

% i_sig = 786.85; % start time of first time window (s)
% j_sig = 1620.65; % start time of second time window (s)
% i_sig = 1266; % start time of first time window (s)
i_sig = 1266.95;
% i_sig = 2500; % noise window start time (s)
% i_sig = 555;
% i_sig = 618;
% i_sig = 793.5;
% i_sig = 1629;
j_sig = 1629; % start time of second time window (s)

windowDuration = 10; % in seconds
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)

u_sig = extract_window(x, fix(i_sig*samplingRate), numSamplesInWindow);
v_sig = extract_window(x, fix(j_sig*samplingRate), numSamplesInWindow);
str_u = num2str(i_sig);
str_v = num2str(j_sig);
'cc = ', correlation_coefficient(u_sig, v_sig)

% Plot first time window
figure
set(gca,'FontSize',18)
plot(time_values, u_sig, 'b', 'LineWidth', 2)
% plot(time_values, u_sig, 'b', 'LineWidth', 3)
xlabel('Time (s)'); ylabel('Amplitude');
title(['Normalized time window, start at ' str_u ' s']);

% Plot second time window
figure
set(gca,'FontSize',18)
plot(time_values, v_sig, 'r', 'LineWidth', 2)
xlabel('Time (s)'); ylabel('Amplitude');
title(['Normalized time window, start at ' str_v ' s']);

% Plot original time window pair
figure
% set(gca,'FontSize',18)
plot(time_values, u_sig, 'b', time_values, v_sig, 'r', 'LineWidth', 2)
set(gca,'FontSize',22,'FontWeight','bold')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Normalized time window pair']);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthEast');

% [data.S,data.F,data.T,data.P] = spectrogram(x,200,198,200,samplingRate);
% specSettings.lagTime = 0.1;
% 
% % set plot flags to 1, plot_ind
% [binaryFingerprint, dt_fp] = data_1hr_fingerprint(data, specSettings, x);