% Called by plot_paper_similar_waveform_pair.m
function [] = plot_similar_waveform_pair(t, x, samplingRate, i_sig, j_sig, output_str)

font_size = 16;
% font_size = 22;
windowDuration = 10; % in seconds
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)

u_sig = extract_window(x, fix(i_sig*samplingRate), numSamplesInWindow);
v_sig = extract_window(x, fix(j_sig*samplingRate), numSamplesInWindow);
str_u = num2str(i_sig);
str_v = num2str(j_sig);
disp(['u = ', str_u, ' v = ', str_v, ' cc = ', num2str(correlation_coefficient(u_sig, v_sig))]);

% line_width = 2;
line_width = 1;

% Plot first time window
figure
set(gca,'FontSize',font_size)
plot(time_values, u_sig, 'b', 'LineWidth', line_width)
xlabel('Time (s)'); ylabel('Amplitude');
title(['Normalized time window, start ' str_u ' s']);

% Plot second time window
figure
set(gca,'FontSize',font_size)
plot(time_values, v_sig, 'r', 'LineWidth', line_width)
% plot(time_values, v_sig, 'Color', [1, 0.5, 0], 'LineWidth', line_width) % orange
% plot(time_values, v_sig, 'Color', [0, 0.5, 0], 'LineWidth', line_width) % green
% plot(time_values, v_sig, 'Color', [0.7, 0, 1], 'LineWidth', line_width) % purple
% plot(time_values, v_sig, 'k', 'LineWidth', 2) % black
xlabel('Time (s)'); ylabel('Amplitude');
title(['Normalized time window, start ' str_v ' s']);

% Plot original time window pair
figure
set(gca,'FontSize',font_size)
plot(time_values, u_sig, 'b', time_values, v_sig, 'r', 'LineWidth', line_width)
% set(gca,'FontSize',22,'FontWeight','bold')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Similar waveform pair']);
legend(['start ' str_u ' s'], ['start ' str_v ' s'], 'Location', 'NorthEast');

% % Output plot of both time windows
% filename = strcat(output_str, num2str(i_sig), '_', num2str(j_sig), '.eps');
% print('-depsc', filename);

% [data.S,data.F,data.T,data.P] = spectrogram(x,200,198,200,samplingRate);
% specSettings.lagTime = 0.1;
% 
% % set plot flags to 1, plot_ind
% [binaryFingerprint, dt_fp] = data_1hr_fingerprint(data, specSettings, x);

end