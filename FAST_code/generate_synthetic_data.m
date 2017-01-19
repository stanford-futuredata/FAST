% generate_synthetic_data.m - Generate synthetic data from NCSN_CCOB_EHN_1wk
%
% Take noisy section of data, add scaled-down versions of repeating
% earthquake signals + one non-repeating earthquake signal to noisy
% section of data -> generate synthetic data
%
% Inputs
% t_all:          time (s) from original SAC data
% x_all:          seismogram amplitude from original SAC data
% Fs:             sampling rate (Hz)
% noise_hr_start: start time (hr) in x_all for noisy data section
% noise_hr_end:   end time (hr) in x_all for noisy data section
% amp_factor:     scale factor for seismogram amplitude
%
% Outputs
% t_synth:        time (s) for synthetic data
% x_synth:        seismogram amplitude for synthetic data
% time_repeat:    ground truth times (s) for repeating earthquake signal
% time_nonrepeat: ground truth time (s) for non-repeating earthquake signal
% snr_output:     SNR for repeating earthquake signal (depends on amp_factor, and noise amplitude)
% 
function [t_synth, x_synth, time_repeat, time_nonrepeat, snr_output] = generate_synthetic_data(...
    t_all, x_all, Fs, noise_hr_start, noise_hr_end, amp_factor)

% Get "noise" section from data
inoise_start = noise_hr_start*3600*Fs;
inoise_end = noise_hr_end*3600*Fs;
x_noise = x_all(inoise_start:inoise_end);

% Extract earthquake signals from data
windowDuration = 10.0; % time window length (s)
numSamplesInWindow = Fs*windowDuration;

% Extract my repeating earthquake "signal" (not normalized)
i_sig = 553.0; % start time of window with earthquake signal (s)
ieq_start = fix(i_sig*Fs)+1; % start index of signal window
repeat_eq_sig = x_all(ieq_start:ieq_start+numSamplesInWindow-1); % earthquake signal

% Compute mean-squared amplitude of scaled repeating signal (for SNR)
scaled_repeat_sig = amp_factor*repeat_eq_sig;
ms_ampl_sig = sum(scaled_repeat_sig.*scaled_repeat_sig)/numSamplesInWindow;

% Extract my non-repeating earthquake "signal" (not normalized)
j_sig = 314075.0; % start time of window with earthquake signal (s)
jeq_start = fix(j_sig*Fs)+1; % start index of signal window
single_eq_sig = x_all(jeq_start:jeq_start+numSamplesInWindow-1); % earthquake signal

flag_plot_eq = 0;
if (flag_plot_eq)
    figure
    set(gca,'FontSize',16);
    plot(t_all(ieq_start:ieq_start+numSamplesInWindow-1), repeat_eq_sig);
%     xlim([t_all(ieq_start) t_all(ieq_start+numSamplesInWindow-1)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([553 563]);
    set(gca, 'XTick', [553:5:563]);
    set(gca,'XTickLabel', ['553';'558';'563']);
    title(['Repeating earthquake signal in synthetic data']);
%     title(['Repeating earthquake signal in synthetic data, t = ' num2str(t_all(ieq_start))]);
    
    figure
    set(gca,'FontSize',16);
    plot(t_all(jeq_start:jeq_start+numSamplesInWindow-1), single_eq_sig);
%     xlim([t_all(jeq_start) t_all(jeq_start+numSamplesInWindow-1)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([314075 314085]);
    set(gca, 'XTick', [314075:5:314085]);
    set(gca,'XTickLabel', ['314075';'314080';'314085']);
    title(['Single non-repeating earthquake signal in synthetic data']);
%     title(['Single non-repeating earthquake signal in synthetic data, t = ' num2str(t_all(jeq_start))]);
end

% Now prepare to insert low amplitude earthquake "signal" into noise
insert_dt = 1800.0; % interval between signal insertions (s)
insert_stride = insert_dt * Fs; % number of samples between insertions
num_insert = fix(3600.0*(noise_hr_end-noise_hr_start) / insert_dt); % number of insertions

 % start index of each scaled-down signal insertion
insert_start_index = [insert_stride/2:insert_stride:num_insert*insert_stride];

% Array with low amplitude earthquake "signal" inserted num_insert times
x_low_sig = zeros(size(x_noise));
for k = 1:num_insert
    x_low_sig(insert_start_index(k):insert_start_index(k)+numSamplesInWindow-1) = scaled_repeat_sig;
end

% Compute mean-squared amplitude of noise (for SNR)
ms_ampl_noise = 0;
for k = 1:num_insert
    curr_noise = x_noise(insert_start_index(k):insert_start_index(k)+numSamplesInWindow-1);
    ms_ampl_noise = ms_ampl_noise + sum(curr_noise.*curr_noise)/numSamplesInWindow;
end
ms_ampl_noise = ms_ampl_noise / num_insert;

% Compute SNR
snr_output = ms_ampl_sig / ms_ampl_noise;

% Add non-repeating signal
nr_time = 19800.0; % insert non-repeating signal at this time (s)
nr_index = fix(nr_time*Fs); % insert non-repeating signal at this index
x_low_sig(nr_index:nr_index+numSamplesInWindow-1) = amp_factor*single_eq_sig;

% Synthetic data: array with noise + low amplitude earthquake "signal"
x_synth = x_noise + x_low_sig;
t_synth = [0:numel(x_synth)-1]'/Fs;

% Should get detections at these 'known' times
time_repeat = insert_start_index/Fs + t_synth(1);
time_nonrepeat = nr_time + t_synth(1);

disp('Ground truth, repeating earthquake signal detection times (s): ');
disp(time_repeat);
disp('Ground truth, non-repeating earthquake signal detection time (s): ');
disp(time_nonrepeat);

end