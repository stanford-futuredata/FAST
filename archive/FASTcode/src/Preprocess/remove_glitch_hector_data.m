% Remove glitch (spike) from Hector Mine continuous data before mainshock
% 2016-12-07
close all; clear

addpath('../Utilities/SAC/');

input_dir = '../../data/TimeSeries/HectorMine/unused_sac/';
% input_string = '.19991015130000.CI.CDY.EHZ.SAC';
% input_string = '.19991015130000.CI.CPM.EHZ.SAC';
% input_string = '.19991015130000.CI.GTM.EHZ.SAC';
% input_string = '.19991015130000.CI.RMM.EHZ.SAC';
% input_string = '.19991015130000.CI.RMR.EHZ.SAC';
input_string = '.19991015130000.CI.TPC.EHZ.SAC';
sps = 100; % sampling rate (Hz)

% Read time series
input_file = strcat('Cutoff20hr', input_string);
currentFile = strcat(input_dir, '/', input_file);
disp(['Current file: ', currentFile]);
[t,x,SAChdr] = fread_sac(currentFile);

% Get indices of glitch
glitch_thresh = 1e6; % threshold (absolute value) - anything above this is a glitch
ind_glitch = find(abs(x) > glitch_thresh);
ind_start = ind_glitch(1);
ind_end = ind_glitch(end);

% Plot glitch
figure(1); plot(t(ind_start-1000:ind_end+1000), x(ind_start-1000:ind_end+1000));

% Get scale factor for white Gaussian noise
ntest = 1000; % number of test samples in data - assume they are noise
mean_gap_left = mean(x(ind_start-1-ntest:ind_start-1)); % mean of ntest noise values on left side of gap
mean_gap_right = mean(x(ind_end+1:ind_end+1+ntest)); % mean of ntest noise values on right side of gap
mean_gap = 0.5*(mean_gap_left + mean_gap_right); % mean noise in gap
std_gap_left = std(x(ind_start-1-ntest:ind_start-1)); % stdev of ntest noise values on left side of gap
std_gap_right = std(x(ind_end+1:ind_end+1+ntest)); % stdev of ntest noise values on right side of gap
std_gap = 0.5*(std_gap_left + std_gap_right); % stdev noise in gap

% Replace glitch with uncorrelated white Gaussian noise
ngap = ind_end-ind_start+1;
gap_x = std_gap*randn(ngap, 1) + mean_gap;
x(ind_start:ind_end) = gap_x;

% Plot time series, check that glitch is no longer there
figure(2); plot(t(ind_start-1000:ind_end+1000), x(ind_start-1000:ind_end+1000));
figure(3); plot(t,x);

% Write data to SAC file
output_file = strcat('NoGlitchCutoff20hr', input_string);
outputFile = strcat(input_dir, '/', output_file);
sac_mat.data = x;
sac_mat.hdr = SAChdr;
sac_mat = fwrite_sac(sac_mat, outputFile);