close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

% Read in data
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0039.BP.GHIB..BP3.Q.SAC.bp2to8';
[t, x(:,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0000.BP.EADB..BP3.Q.SAC.bp2to8';
[t, x(:,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0377.BP.JCNB..BP3.Q.SAC.bp2to8';
[t, x(:,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0143.BP.FROB..BP3.Q.SAC.bp2to8';
[t, x(:,4), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0090.BP.VCAB..BP3.Q.SAC.bp2to8';
[t, x(:,5), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0176.BP.MMNB..BP3.Q.SAC.bp2to8';
[t, x(:,6), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0358.BP.LCCB..BP3.Q.SAC.bp2to8';
[t, x(:,7), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0102.BP.RMNB..BP3.Q.SAC.bp2to8';
[t, x(:,8), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0276.BP.CCRB..BP3.Q.SAC.bp2to8';
[t, x(:,9), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0070.BP.SMNB..BP3.Q.SAC.bp2to8';
[t, x(:,10), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP3_20060509_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0398.BP.SCYB..BP3.Q.SAC.bp2to8';
[t, x(:,11), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP3_20060509_24hr');
titlestr = {'GHIB', 'EADB', 'JCNB', 'FROB', 'VCAB', 'MMNB', 'LCCB', 'RMNB', ...
    'CCRB', 'SMNB', 'SCYB'};

s = size(x);
nch = s(2);

% % Figure S1, 600 s
% start_time = 37179;
% end_time = 37779;
% scale_amp = 5;
% xtext = 60;

% Figure S1, 25 s
start_time = 37474;
end_time = 37499;
scale_amp = 2;
xtext = 2;

startIndex = start_time * samplingRate;
endIndex = end_time * samplingRate;
nsamples = endIndex - startIndex + 1;

dt = 1.0/samplingRate;
time_values = [0:dt:nsamples/samplingRate];
time_values = time_values(1:end-1);

waveformMatrix = zeros(nch, nsamples);
% offsetWaveformMatrix = zeros(nch, nsamples);
for k=1:nch
    waveformMatrix(k,:) = extract_window(x(:,k), startIndex, nsamples);
%     offsetWaveformMatrix(k,:) = waveformMatrix(k,:) + k;
end

FigHandle = figure('Position',[1500 150 1024 1536]);
set(gca,'FontSize',16);
set(gca,'YDir','reverse');
hold on
for k=1:nch
    wvf = scale_amp*waveformMatrix(k,:) + k;
    plot(time_values, wvf, 'k', 'LineWidth', 2);
    text(xtext, k-0.7, titlestr{k}, 'FontSize', 14, ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
end
xlabel(['Time (s), start = ', num2str(start_time)]);
ylabel('Trace number');
title('2006-05-09');