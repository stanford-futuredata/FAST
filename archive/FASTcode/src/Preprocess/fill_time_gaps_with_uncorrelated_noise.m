% Gaps in time (all 0's): fill with uncorrelated white Gaussian noise, scaled with
%   mean and standard deviation of surrounding data
% Otherwise, sections with 0's are exactly similar to each other, which
%   will overwhelm the detection algorithm
%
% Run this AFTER combine_sac_time_series.m

close all
clear

addpath('../Utilities/SAC/');

inputDir = '../../data/TimeSeries/Ometepec/RAW/';
Fs = 100;

% East, North
currentFile = strcat(inputDir, '15days.201203.PNIG.HHE.sac');
outputFile = strcat(inputDir, 'Fill.15days.201203.PNIG.HHE.sac');
% currentFile = strcat(inputDir, '15days.201203.PNIG.HHN.sac');
% outputFile = strcat(inputDir, 'Fill.15days.201203.PNIG.HHN.sac');
gapStart = [22433697 66977997 77094297]; % sample at start of gap
gapEnd = [22480096 68388596 77135496]; % sample at end of gap

% % Up
% currentFile = strcat(inputDir, '15days.201203.PNIG.HHZ.sac');
% outputFile = strcat(inputDir, 'Fill.15days.201203.PNIG.HHZ.sac');
% gapStart = [22433697 66978097 77094297]; % sample at start of gap
% gapEnd = [22480096 68388596 77135496]; % sample at end of gap


disp(['Current file: ', currentFile]);
[t,x,SAChdr] = fread_sac(currentFile);

for k=1:numel(gapStart)
    ngap = gapEnd(k) - gapStart(k) + 1; % number of samples in gap
    disp(['gap size = ' num2str(ngap)]);

    % Get scale factor for white Gaussian noise
    ntest = 2000; % number of test samples in data - assume they are noise
    median_gap_left = median(x(gapStart(k)-ntest:gapStart(k)-1)); % median of ntest noise values on left side of gap
    median_gap_right = median(x(gapEnd(k)+1:gapEnd(k)+ntest)); % median of ntest noise values on right side of gap
    median_gap = 0.5*(median_gap_left + median_gap_right); % median noise in gap
    std_gap_left = mad(x(gapStart(k)-ntest:gapStart(k)-1), 1); % stdev of ntest noise values on left side of gap
    std_gap_right = mad(x(gapEnd(k)+1:gapEnd(k)+ntest), 1); % stdev of ntest noise values on right side of gap
    std_gap = 0.5*(std_gap_left + std_gap_right); % stdev noise in gap

    % Fill in gap with uncorrelated white Gaussian noise
    gap_x = std_gap*randn(ngap, 1) + median_gap;
%     figure; plot(x(gapStart(k)-ntest:gapEnd(k)+ntest)); title('before');
    x(gapStart(k):gapEnd(k)) = gap_x;
%     figure; plot(x(gapStart(k)-ntest:gapEnd(k)+ntest)); title('after');
end

% Create time axis (s) to go along with data in x
t = [1:length(x)]'/Fs;

% Create new SAC header
N = length(x);
dt = 1.0/Fs; % sample spacing
tstart = 0; % start time

% Write combined data to SAC file
sac_mat.data = x;
newhdr = SAChdr;
newhdr.delta = dt;
newhdr.b = tstart;
newhdr.e = t(end);
newhdr.npts = N;
sac_mat.hdr = newhdr;
sac_mat = fwrite_sac(sac_mat, outputFile);

