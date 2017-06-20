% Sanity check for fingerprinting time window waveform
% 2013-09-05

close all
clear all

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');
addpath('../../Experimental/');

% read data
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10';
[t, x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHZ_24hr');

windowDuration = 10; % time window length (s)

% Number of samples in each time window
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)

flag_plot_noise_pair_1D = 0;
if (flag_plot_noise_pair_1D)
    % Pick window pair with noise
    i_noise = 2892.25; % start time of first time window (s)
    j_noise = 2899.05; % start time of second time window (s)
    u_noise = extract_window(x, i_noise*samplingRate, numSamplesInWindow);
    v_noise = extract_window(x, j_noise*samplingRate, numSamplesInWindow);

    str_u = num2str(i_noise);
    str_v = num2str(j_noise);
    
    plot_waveform_fingerprint(time_indices, u_noise, v_noise, str_u, str_v, ...
        'noise', -0.2, 0.2);
end

flag_plot_signal_pair_1D = 1;
if (flag_plot_signal_pair_1D)
    % Pick window pair with signal
    i_sig = 555.95; % start time of first time window (s)
    j_sig = 1788.85; % start time of second time window (s)
    
%     i_sig = 617.65; % start time of first time window (s)
%     j_sig = 793.65; % start time of second time window (s)

%     i_sig = 1265.6; % start time of first time window (s)
%     j_sig = 1628.2; % start time of second time window (s)

    u_sig = extract_window(x, i_sig*samplingRate, numSamplesInWindow);
    v_sig = extract_window(x, j_sig*samplingRate, numSamplesInWindow);

    str_u = num2str(i_sig);
    str_v = num2str(j_sig);

    plot_waveform_fingerprint(time_indices, u_sig, v_sig, str_u, str_v, ...
        'signal', -0.4, 0.5);
end
