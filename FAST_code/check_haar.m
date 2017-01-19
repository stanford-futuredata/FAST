% Sanity check for Haar wavelet transform and inverse
% 2013-08-27

% close all
% clear all

function [] = check_haar()

close all

% read data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_01hr');

windowDuration = 10; % time window length (s)
% windowDuration = 12.8; % time window length (s) - NO DOWNSAMPLE

% Number of samples in each time window
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)

%%%---------------------------------------
%%% Check 1D Haar transform, time window
%%%---------------------------------------

flag_plot_noise_pair_1D = 0;
if (flag_plot_noise_pair_1D)
    % Pick window pair with noise
    i_noise = 2892.25; % start time of first time window (s)
    j_noise = 2899.05; % start time of second time window (s)
    u_noise = extract_window(x, i_noise*samplingRate, numSamplesInWindow);
    v_noise = extract_window(x, j_noise*samplingRate, numSamplesInWindow);

    str_u = num2str(i_noise);
    str_v = num2str(j_noise);

    plot_compare_window_pair_haar_1d(time_indices, time_values, u_noise, ...
        v_noise, str_u, str_v, 'noise');

%     % Downsample time window so it is a power of 2
%     numSamplesPow2 = get_downsample_power_2(numSamplesInWindow);
%     u_noise_ds = resample(u_noise, numSamplesPow2, numSamplesInWindow);
%     v_noise_ds = resample(v_noise, numSamplesPow2, numSamplesInWindow);
% 
%     dt_ds = windowDuration / numSamplesPow2;
%     time_ind_ds = [1:numSamplesPow2];
%     time_ds = dt_ds * time_ind_ds;
% 
%     plot_compare_window_pair_haar_1d(time_ind_ds, time_ds, u_noise_ds, ...
%         v_noise_ds, str_u, str_v, 'noise downsample');
end

flag_plot_signal_pair_1D = 0;
if (flag_plot_signal_pair_1D)
    % Pick window pair with signal
%     i_sig = 555.95; % start time of first time window (s)
% % i_sig = 555.55; % start time of first time window (s)
%     j_sig = 1788.85; % start time of second time window (s)

%     i_sig = 553.95; % start time of first time window (s)
%     j_sig = 557.95; % start time of second time window (s)

%     i_sig = 617.65; % start time of first time window (s)
%     j_sig = 793.65; % start time of second time window (s)

%     i_sig = 1265.6; % start time of first time window (s)
%     j_sig = 1628.2; % start time of second time window (s)

%     i_sig = 1265.6; % start time of first time window (s)
%     j_sig = 793.65; % start time of second time window (s)

%     i_sig = 617.65; % start time of first time window (s)
%     j_sig = 1628.2; % start time of second time window (s)

%     i_sig = 865.1; % start time of first time window (s)
%     j_sig = 994.85; % start time of second time window (s)
    
%     i_sig = 1166.5; % start time of first time window (s)
%     j_sig = 1340.6; % start time of second time window (s)

%     i_sig = 1737.7; % start time of first time window (s)
%     j_sig = 3527; % start time of second time window (s)
    
%--
% From autocorrelation high CC values
% [data settings ] = load_data('../data/ncsn/2011.008.00.00.00.deci5.1hr.NC.CCOB..EHZ.D.SAC/sigma5.bin')

      % 2 signals
%     i_sig = 548.25; % start time of first time window (s)
%     j_sig = 786.75; % start time of second time window (s)
    
    i_sig = 557.95; % start time of first time window (s)
    j_sig = 1790.85; % start time of second time window (s)
    
%     i_sig = 786.85; % start time of first time window (s)
%     j_sig = 1620.65; % start time of second time window (s)

%     i_sig = 557.85; % start time of first time window (s)
%     j_sig = 1630.15; % start time of second time window (s)

%     i_sig = 1256.35; % start time of first time window (s)
%     j_sig = 1778.95; % start time of second time window (s)

%     i_sig = 608.05; % start time of first time window (s)
%     j_sig = 1256.25; % start time of second time window (s)

%     i_sig = 607.75; % start time of first time window (s)
%     j_sig = 784.55; % start time of second time window (s)

      % 2 noise windows
%     i_sig = 2892.25; % start time of first time window (s)
%     j_sig = 2899.05; % start time of second time window (s)

    % Signal and noise
%     i_sig = 557.95; % start time of first time window (s)
%     j_sig = 2899.05; % start time of second time window (s)

%     i_sig = 235.0; % start time of first time window (s)
%     j_sig = 1551.0; % start time of second time window (s)

%     i_sig = 453.25; % start time of first time window (s)
%     j_sig = 922.75; % start time of second time window (s)

%     i_sig = 607.75; % start time of first time window (s)
%     j_sig = 2899.05; % start time of second time window (s)

%     i_sig = 548.25; % start time of first time window (s)
%     j_sig = 2899.05; % start time of second time window (s)

%     i_sig = 784.55; % start time of first time window (s)
%     j_sig = 2892.25; % start time of second time window (s)

%     i_sig = 1778.95; % start time of first time window (s)
%     j_sig = 2899.05; % start time of second time window (s)

%     i_sig = 1256.25; % start time of first time window (s)
%     j_sig = 2892.25; % start time of second time window (s)
    
%--
    % Need to subtract 2.8 s if working with 12.8 s time windows!
    i_sig = i_sig - 2.8;
    j_sig = j_sig - 2.8;

    u_sig = extract_window(x, fix(i_sig*samplingRate), numSamplesInWindow);
    v_sig = extract_window(x, fix(j_sig*samplingRate), numSamplesInWindow);

    str_u = num2str(i_sig);
    str_v = num2str(j_sig);
    
    plot_compare_window_pair_haar_1d(time_indices, time_values, u_sig, ...
        v_sig, str_u, str_v, 'signal');

    % Downsample time window so it is a power of 2
%     numSamplesPow2 = get_downsample_power_2(numSamplesInWindow);
%     u_sig_ds = resample(u_sig, numSamplesPow2, numSamplesInWindow);
%     v_sig_ds = resample(v_sig, numSamplesPow2, numSamplesInWindow);
% 
%     dt_ds = windowDuration / numSamplesPow2;
%     time_ind_ds = [1:numSamplesPow2];
%     time_ds = dt_ds * time_ind_ds;

%     plot_compare_window_pair_haar_1d(time_ind_ds, time_ds, u_sig_ds, ...
%         v_sig_ds, str_u, str_v, 'signal downsample');
end

flag_shift_signal_haar = 0;
if (flag_shift_signal_haar)
%     time_sig = 555.95; % start time of window (s)
%     time_sig = 555.25; % start time of window (s)
%     time_sig = 556.55; % start time of window (s)
    time_sig = 554.35; % start time of window (s)
    time_lag = 0.2; % time lag (s)
    num_shifts = 2; % number of shifts to plot in each direction
    max_time_shift = time_lag * num_shifts;
    
    % Downsample time window so it is a power of 2
    numSamplesPow2 = get_downsample_power_2(numSamplesInWindow);
    dt_ds = windowDuration / numSamplesPow2;
    time_ind_ds = [1:numSamplesPow2];
    time_ds = dt_ds * time_ind_ds;
    
    % all starting times
    time_array = [-num_shifts:num_shifts]*time_lag + time_sig;
    num_times = length(time_array);
    
    t_value = 32; % number of top magnitude coefficients to keep
    
    % Loop over all times
    for k=1:num_times
        i_sig = time_array(k);
        u_sig = extract_window(x, floor(i_sig*samplingRate), numSamplesInWindow);
        str_u = num2str(i_sig);
        
        [haar_u, haar_u_top, check_u, check_u_coarse, check_u_top, index_haar_u] = ...
            plot_check_haar_1d(time_indices, time_values, u_sig, str_u, t_value);

%         % Downsample time window so it is a power of 2
%         u_sig_ds = resample(u_sig, numSamplesPow2, numSamplesInWindow);
%         [haar_u, haar_u_top, check_u, check_u_coarse, check_u_top, index_haar_u] = ...
%             plot_check_haar_1d(time_ind_ds, time_ds, u_sig_ds, str_u, t_value);
    end
end

%%%------------------------------------------
%%% Check 2D Haar transform, spectral image
%%%------------------------------------------

% Get frequency info
bandLowFreq = 3; % lowest frequency (Hz) in spectrogram
bandHighFreq = 10; % highest frequency (Hz) in spectrogram
nfreq = 71; % number of frequency samples
dfreq = (bandHighFreq - bandLowFreq)/(nfreq-1); % frequency spacing (Hz)
freq_indices = [0:nfreq-1];
freq_values = dfreq*freq_indices + bandLowFreq;

% Get time axis info (for spectral image)
imageDuration = 10; % spectral image duration (s)
ntime = 100; % number of time samples in spectral image
dtime = imageDuration / ntime; % time spacing (s) in spectral image
time_spec_indices = [1:ntime];
time_spec_values = dtime*time_spec_indices;

% Get downsampled frequency info
nfreqPow2 = get_downsample_power_2(nfreq);
dfreq_ds = (bandHighFreq - bandLowFreq)/(nfreqPow2-1);
freq_ds_indices = [0:nfreqPow2-1];
freq_ds_values = dfreq_ds*freq_ds_indices + bandLowFreq;

% Get downsampled time axis info (for spectral image)
ntimePow2 = get_downsample_power_2(ntime);
dtime_ds = windowDuration / ntimePow2;
time_spec_ds_indices = [1:ntimePow2];
time_spec_ds_values = dtime_ds*time_spec_ds_indices;


flag_plot_signal_pair_2D = 1;
if (flag_plot_signal_pair_2D)
    % Pick spectral image pair with signal
    i_image_sig = 550;
    load('u_image_sig_550.mat', 'u_image_sig'); % specImages(:,:,550)
    plot_max_spec_mag_u = 700;

    j_image_sig = 1783;
    load('v_image_sig_1783.mat', 'v_image_sig'); % specImages(:,:,1783)
    plot_max_spec_mag_v = 700;
    
%     % Another spectral image pair
%     i_image_sig = 828;
%     load('w_image_sig_828.mat', 'w_image_sig'); % specImages(:,:,828)
%     u_image_sig = w_image_sig;
%     plot_max_spec_mag_u = 200;
%     
%     j_image_sig = 1262;
%     load('x_image_sig_1262.mat', 'x_image_sig'); % specImages(:,:,1262)
%     v_image_sig = x_image_sig;
%     plot_max_spec_mag_v = 6000;
    
    str_u_image_sig = num2str(i_image_sig);
    str_v_image_sig = num2str(j_image_sig);

    plot_check_haar_2d(time_spec_values, freq_values, u_image_sig, ...
        str_u_image_sig, 'signal', plot_max_spec_mag_u);
    plot_check_haar_2d(time_spec_values, freq_values, v_image_sig, ...
        str_v_image_sig, 'signal', plot_max_spec_mag_v);

    % Downsample spectral image so both dimensions are a power of 2
    u_image_ds_sig = imresize(u_image_sig, [nfreqPow2 ntimePow2], 'bilinear');
    v_image_ds_sig = imresize(v_image_sig, [nfreqPow2 ntimePow2], 'bilinear');
    assert(sum(u_image_ds_sig(:) < 0) == 0,'downsampled image must not be negative');
    assert(sum(v_image_ds_sig(:) < 0) == 0,'downsampled image must not be negative');

    plot_check_haar_2d(time_spec_ds_values, freq_ds_values, ...
        u_image_ds_sig, str_u_image_sig, 'signal ds', plot_max_spec_mag_u);
    plot_check_haar_2d(time_spec_ds_values, freq_ds_values, ...
        v_image_ds_sig, str_v_image_sig, 'signal ds', plot_max_spec_mag_v);
end

flag_plot_noise_2D = 0;
if (flag_plot_noise_2D)
    % Pick spectral image example with noise
    i_image_noise = 100;
    load('u_image_noise_100.mat', 'u_image_noise'); % specImages(:,:,100)
    str_u_image_noise = num2str(i_image_noise);
    plot_max_spec_mag_noise = 30;

    % Noise - make plots
    plot_check_haar_2d(time_spec_values, freq_values, u_image_noise, ...
        str_u_image_noise, 'noise', plot_max_spec_mag_noise);

    % Noise - downsample, then make plots
    u_image_ds_noise = imresize(u_image_noise, [nfreqPow2 ntimePow2], 'bilinear');
    assert(sum(u_image_ds_noise(:) < 0) == 0,'downsampled image must not be negative');
    
    plot_check_haar_2d(time_spec_ds_values, freq_ds_values, u_image_ds_noise, ...
        str_u_image_noise, 'noise ds', plot_max_spec_mag_noise);
end

end
