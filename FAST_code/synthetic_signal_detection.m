function [] = synthetic_signal_detection()
% Synthetic signal detection test (suggested by Greg)
%
% Add scaled-down earthquake signal multiple times to 'noise only'
% section of data
%
% Then for each window pair (original signal, scaled-down signal), or
% (original signal, noise section), compute:
% 1) Correlation coefficient
% 2) Overlap Jaccard similarity of top t magnitude Haar coefficients

% read data (24 hours)
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_24hr');

% "noise" section: between hours 8 and 9
inoise_start = 576000;
inoise_end = 648000;
x_noise = x(inoise_start:inoise_end);

% "data" section: between hours 0 and 1
idata_start = 1;
idata_end = 72001;
x_data = x(idata_start:idata_end);
t_vec = t(idata_start:idata_end);

clear t;
clear x;

% plot - sanity check
% plot(t_vec,x_data,'b',t_vec,x_noise,'r'); ylim([-500 500]);

%-----

% Number of samples in each time window - need power of 2 for DWT
windowDuration = 12.8; % time window length (s)
numSamplesInWindow = samplingRate*windowDuration;
time_indices = [1:numSamplesInWindow];
time_values = time_indices/samplingRate; % time axis values (s)

% Extract my earthquake "signal" (not normalized)
i_sig = 557.95; % start time of window with earthquake signal (s)
% Need to subtract 2.8 s if working with 12.8 s time windows!
i_sig = i_sig - 2.8;
ieq_start = fix(i_sig*samplingRate); % start index of signal window
eq_sig = x_data(ieq_start:ieq_start+numSamplesInWindow-1); % earthquake signal
length_sig = length(eq_sig);

% j_sig = 1630.15;
% j_sig = j_sig - 2.8;
% jeq_start = fix(j_sig*samplingRate);
% eq_add_sig = x_data(jeq_start:jeq_start+numSamplesInWindow-1);

% Parameters for binary image fingerprint generation
addpath('mdwt');
addpath('mdwt/cwl_lib');
dx = 0.04; % wavelet coefficient amplitude spacing for quantization
% dx = 0.005;
thres = dx;
xmax = 1.0;
% xmax = 0.5;

%-----

% Now prepare to insert low amplitude earthquake "signal" into noise

insert_dt = 100.0; % interval between signal insertions (s)
insert_stride = insert_dt * samplingRate; % number of samples between insertions
num_insert = fix(3600.0 / insert_dt); % number of insertions

 % start index of each scaled-down signal insertion
insert_start_index = [1:insert_stride:num_insert*insert_stride];

 % start index of "noise" section
noisy_start_index = insert_start_index + insert_stride/2;



%%%%%%*************
array_atten = [1 0.5 0.2 0.1 0.05 0.01]; % scale factor for signal

for i_array = 1:length(array_atten)

    % Low amplitude earthquake "signal"
    atten_factor = array_atten(i_array);
    low_eq_sig = atten_factor * eq_sig;
%     low_eq_sig = atten_factor * eq_add_sig;

    % plot - sanity check
    % plot(time_values,eq_sig,'b', time_values,low_eq_sig,'r');

    % Array with low amplitude earthquake "signal" inserted num_insert times
    x_low_sig = zeros(length(x_noise), 1);
    for k = 1:num_insert
        x_low_sig(insert_start_index(k):insert_start_index(k)+length_sig-1) = low_eq_sig;
    end

    % Array with noise + low amplitude earthquake "signal"
    x_noise_with_low_sig = x_noise + x_low_sig;

    % plot - sanity check
    % plot(t_vec,x_noise,'b',t_vec,x_noise_with_low_sig,'r');

    %------
    % Normalized low amplitude earthquake signal
    u_low_eq_sig = low_eq_sig / norm(low_eq_sig);

    % Get top magnitude Haar coefficients for low amplitude earthquake signal
    t_value = 32;
    [haar_u_low_eq_sig, haar_u_low_eq_top] = get_top_magnitude_1d_haar_coeff(t_value, u_low_eq_sig);
%     haar_u_low_eq_top = haar_u_low_eq_top.*haar_u_low_eq_top;
    
    % Compute binary image fingerprint from top magnitude wavelet coefficients
    fp_haar_u_low_eq_top = dsqf(haar_u_low_eq_top,dx,xmax,thres);

    % plot - sanity check
    % stem(time_values,haar_u_low_eq_sig,'bo');
    % hold on
    % stem(time_values,haar_u_low_eq_top,'ro');
    % hold off

    %------

    CC_insert = zeros(num_insert,1);
    CC_noise = zeros(num_insert,1);
    OverJaccard_insert = zeros(num_insert,1);
    OverJaccard_noise = zeros(num_insert,1);
    FpJaccard_insert = zeros(num_insert,1);
    FpJaccard_noise = zeros(num_insert,1);
    for k = 1:num_insert
        
        [CC_insert(k), OverJaccard_insert(k), FpJaccard_insert(k)] = ...
            get_similarity_metrics(length_sig, x_noise_with_low_sig, ...
            insert_start_index(k), u_low_eq_sig, t_value, ...
            haar_u_low_eq_top, fp_haar_u_low_eq_top, dx, xmax, thres);
        
        [CC_noise(k), OverJaccard_noise(k), FpJaccard_noise(k)] = ...
            get_similarity_metrics(length_sig, x_noise_with_low_sig, ...
            noisy_start_index(k), u_low_eq_sig, t_value, ...
            haar_u_low_eq_top, fp_haar_u_low_eq_top, dx, xmax, thres);
    end

    % plot correlation coefficient vs window index
    figure
    set(gca,'FontSize',18);
    plot([1:num_insert],CC_insert,'bo',[1:num_insert],CC_noise,'ro'); ylim([-1 1]);
    legend('signal-signal pair', 'signal-noise pair', 'Location', 'SouthEast');
    title(['Correlation coefficient, time window samples, signal factor = ' num2str(atten_factor)])
    xlabel('window index'); ylabel('Correlation coefficient');

    % plot overlap Jaccard similarity vs window index
    figure
    set(gca,'FontSize',18);
    plot([1:num_insert],OverJaccard_insert,'b+',[1:num_insert],OverJaccard_noise,'r+'); ylim([-1 1]);
    legend('signal-signal pair', 'signal-noise pair', 'Location', 'SouthEast');
    title(['Overlap Jaccard similarity, top ' num2str(t_value) ' magnitude Haar, signal factor = ' num2str(atten_factor)])
    xlabel('window index'); ylabel('Overlap Jaccard similarity');

    % plot fingerprint Jaccard similarity vs window index
    figure
    set(gca,'FontSize',18);
    plot([1:num_insert],FpJaccard_insert,'b*',[1:num_insert],FpJaccard_noise,'r*'); ylim([-1 1]);
    legend('signal-signal pair', 'signal-noise pair', 'Location', 'SouthEast');
    title(['FP Jaccard similarity, top ' num2str(t_value) ' magnitude Haar, signal factor = ' num2str(atten_factor)])
    xlabel('window index'); ylabel('Fingerprint Jaccard similarity');
    
    % scatter plot - overlap Jaccard similarity vs correlation coefficient
    figure
    set(gca,'FontSize',18);
    scatter(CC_insert, FpJaccard_insert)
    hold on
    scatter(CC_noise, FpJaccard_noise,'r')
    hold off
    legend('signal-signal pair', 'signal-noise pair', 'Location', 'SouthEast');
    title(['Scatter plot, signal factor = ' num2str(atten_factor), ', top ' num2str(t_value) ' Haar']);
    xlabel('Correlation coefficient, time window samples');
    ylabel('Fingerprint Jaccard similarity, top magnitude Haar');

    % scatter plot - overlap Jaccard similarity vs fingerprint Jaccard similarity
    figure
    set(gca,'FontSize',18);
    scatter(FpJaccard_insert, OverJaccard_insert)
    hold on
    scatter(FpJaccard_noise, OverJaccard_noise,'r')
    hold off
    legend('signal-signal pair', 'signal-noise pair', 'Location', 'SouthEast');
    title(['Scatter plot Jaccard, signal factor = ' num2str(atten_factor), ', top ' num2str(t_value) ' Haar']);
    xlabel('Fingerprint Jaccard similarity, top magnitude Haar');
    ylabel('Overlap Jaccard similarity, top magnitude Haar');
end
%%%%%%*************

end

function [CC, OverJaccard, FpJaccard] = get_similarity_metrics(length_sig, ...
    x_noise_with_low_sig, start_index, u_low_eq_sig, t_value, ...
    haar_u_low_eq_top, fp_haar_u_low_eq_top, dx, xmax, thres)

    % get normalized "signal + noise" or "noise" window
    data_window = x_noise_with_low_sig(start_index:start_index+length_sig-1);
    u_data_window = data_window / norm(data_window);

    % compute CC with original "signal"
    CC = correlation_coefficient(u_low_eq_sig, u_data_window);

    % Get top magnitude Haar coefficients for "signal + noise" window
    [haar_u, haar_u_top] = get_top_magnitude_1d_haar_coeff(t_value, u_data_window);
%     haar_u_top = haar_u_top.*haar_u_top;

    % compute generalized 'jaccard' similarity with original signal
    OverJaccard = overlap_jaccard(haar_u_low_eq_top, haar_u_top);
    
    % Compute binary image fingerprint from top magnitude wavelet coefficients
    fp_haar_u_top = dsqf(haar_u_top,dx,xmax,thres);
    
    % Compute Jaccard similarity
    FpJaccard = jaccard(fp_haar_u_low_eq_top, fp_haar_u_top);
end