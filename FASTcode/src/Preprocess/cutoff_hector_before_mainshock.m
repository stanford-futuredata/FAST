% Cut off SAC files for Hector Mine continuous data before mainshock
% 2016-12-07
close all; clear

addpath('../Utilities/SAC/');

% input_dir = '../../data/TimeSeries/HectorMine/original_sac/';
input_dir = '/data/beroza/ceyoon/FASTcode/data/TimeSeries/HectorMine';
% input_string = '.19991015130000.CI.CDY.EHZ.SAC';
% input_string = '.19991015130000.CI.CPM.EHZ.SAC';
% input_string = '.19991015130000.CI.GTM.EHZ.SAC';
% input_string = '.19991015130000.CI.RMM.EHZ.SAC';
% input_string = '.19991015130000.CI.RMR.EHZ.SAC';
% input_string = '.19991015130000.CI.TPC.EHZ.SAC';
% sps = 100; % sampling rate (Hz)
% input_file = strcat('Combine20hr', input_string);

% input_string = '19991015130000.CI.HEC.BHZ.sac';
% input_string = '19991015130000.CI.HEC.BHN.sac';
% input_string = '19991015130000.CI.HEC.BHE.sac';
% input_string = '19991015130000.CI.GSC.BHZ.SAC';
% input_string = '19991015130000.CI.GSC.BHN.SAC';
% input_string = '19991015130000.CI.GSC.BHE.SAC';
% input_string = '19991015130000.CI.SBPX.BHZ.SAC';
% input_string = '19991015130000.CI.SBPX.BHN.SAC';
input_string = '19991015130000.CI.SBPX.BHE.SAC';
sps = 20; % sampling rate (Hz)
input_file = strcat('', input_string);

cutoff_time = 74804; % cutoff time (seconds) Origin time: 9:46:44 UTC


currentFile = strcat(input_dir, '/', input_file);
disp(['Current file: ', currentFile]);
[t,x,SAChdr] = fread_sac(currentFile);

% Cutoff data
cutoff_sample = cutoff_time * sps;
t = t(1:cutoff_sample);
x = x(1:cutoff_sample);
N = length(x);

% Write combined data to SAC file
output_file = strcat('Cutoff20hr', input_string);
outputFile = strcat(input_dir, '/', output_file);
sac_mat.data = x;
newhdr = SAChdr;
newhdr.e = t(end);
newhdr.npts = N;
sac_mat.hdr = newhdr;
sac_mat = fwrite_sac(sac_mat, outputFile);