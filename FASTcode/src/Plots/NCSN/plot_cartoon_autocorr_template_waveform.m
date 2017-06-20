close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10';
[t, x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHZ_24hr');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'; % bandpass 4-10 Hz
% [t, x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHN_1wk');
% [t, x, samplingRate] = get_channel_data('AZ_KNW_24hr');

% Template waveform

i_sig = 1900; % in seconds
windowDuration = 20; % in seconds
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)
template_window = extract_window(x, fix(i_sig*samplingRate), numSamplesInWindow);

figure
set(gca,'FontSize',18)
plot(time_values, template_window, 'r', 'LineWidth', 2)
xlabel('Time (s)'); ylabel('Amplitude');
ylim([-0.3 0.3]);


% Autocorrelation time series

j_sig = 1880; % in seconds
windowDuration = 100; % in seconds
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)
autocorr_window = extract_window(x, fix(j_sig*samplingRate), numSamplesInWindow);

FigHandle = figure('Position',[1500 150 1600 300]);
set(gca,'FontSize',18)
% plot(time_values, autocorr_window, 'b', 'LineWidth', 2)
plot(time_values, autocorr_window, 'Color', [0.5 0.5 0.5], 'LineWidth', 2) % gray
xlabel('Time (s)'); ylabel('Amplitude');
ylim([-0.25 0.25]);