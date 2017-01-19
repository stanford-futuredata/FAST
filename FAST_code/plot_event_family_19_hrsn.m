close all
clear

% Read in data
addpath('input_data');
[t, x(:,1), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20060509_24hr');
[t, x(1:end-1,2), samplingRate] = get_channel_data('HRSN_EADB_BP3_20060509_24hr');
[t, x(:,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20060509_24hr');
[t, x(:,4), samplingRate] = get_channel_data('HRSN_FROB_BP3_20060509_24hr');
[t, x(1:end-1,5), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20060509_24hr');
[t, x(:,6), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20060509_24hr');
[t, x(:,7), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20060509_24hr');
[t, x(:,8), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20060509_24hr');
[t, x(:,9), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20060509_24hr');
[t, x(:,10), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20060509_24hr');
[t, x(:,11), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20060509_24hr');
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