close all
clear

% Read in data
addpath('input_data');

% blue: used for detection, black: not used for detection (correlated noise)

%----------------------------------------------------------------------------

% Old method, plot 1 component at a time
[t, x(:,1), samplingRate] = get_channel_data('HRSN_JCNB_BP1_20071026_24hr');
[t, x(:,2), samplingRate] = get_channel_data('HRSN_JCNB_BP2_20071026_24hr');
[t, x(:,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
[t, x(:,4), samplingRate] = get_channel_data('HRSN_JCSB_BP2_20071026_24hr');
[t, x(:,5), samplingRate] = get_channel_data('HRSN_LCCB_BP2_20071026_24hr');
[t, x(:,6), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20071026_24hr');
[t, x(:,7), samplingRate] = get_channel_data('HRSN_SMNB_BP1_20071026_24hr');
[t, x(:,8), samplingRate] = get_channel_data('HRSN_SMNB_BP2_20071026_24hr');
[t, x(:,9), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
[t, x(:,10), samplingRate] = get_channel_data('HRSN_SCYB_BP1_20071026_24hr');
[t, x(:,11), samplingRate] = get_channel_data('HRSN_SCYB_BP2_20071026_24hr');
[t, x(:,12), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
date_comp_str = '2007-10-26';
titlestr = {'JCNB.BP1', 'JCNB.BP2', 'JCNB.BP3', 'JCSB.BP2', 'LCCB.BP2', 'MMNB.BP3', ...
    'SMNB.BP1', 'SMNB.BP2', 'SMNB.BP3', 'SCYB.BP1', 'SMNB.BP2', 'SMNB.BP3'};  

outdir = './';
load('../data/haar_coefficients/totalMatrix_HRSN_12ch_20071026_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat');
% outdir = './outputs/HRSN_detections_20071026_24hr/autocorr_totalMatrix_HRSN_12ch_20071026_24hr/';
% load('../data/haar_coefficients/totalMatrix_HRSN_12ch_20071026_24hr/autocorr_sigma3.5_thresh0.5_timewin5_12ch.mat');

s = size(x);
nch = s(2);
dt_fp = 0.5;
% dt_fp = 0.05;

% Sort detection outputs
[sort_det, ix_sort] = sort(detection_out{2}, 'descend');
sort_det_times = double(detection_out{1}(ix_sort))*dt_fp;
sort_det_sim = detection_out{2}(ix_sort);

start_time = sort_det_times(1:10);
% start_time = sort_det_times(1:20);
% start_time = sort_det_times(1:60);
% start_time = sort_det_times(31:60);
% start_time = sort_det_times(61:90);
% start_time = sort_det_times(1:300);

% start_time = [45899 45483 1941 925 22152 20030.5];
% start_time = [22152 20030.5 73698 66481 66101.5 66055 72765 59808];
% start_time = [64089];
% ****
% % start_time = [46121 48298.5 51609.5 46720.5 46620];
% % sort_det_sim = [sort_det_sim(49) sort_det_sim(59) sort_det_sim(126) sort_det_sim(129) sort_det_sim(147)];
% window_duration = 20; % window duration (s)
window_duration = 10; % window duration (s)
end_time = start_time + window_duration;
scale_amp = 2;
xtext = 8;

startIndex = start_time * samplingRate;
endIndex = end_time * samplingRate;
nsamples_arr = endIndex - startIndex + 1;
nsamples = nsamples_arr(1);

dt = 1.0/samplingRate;
time_values = [0:dt:nsamples/samplingRate];
time_values = time_values(1:end-1);

% Old method, plot 1 component at a time
FigHandle = figure('Position',[1500 150 300 1536]);
for q=1:length(start_time)

    waveformMatrix = zeros(nsamples, nch);
    for k=1:nch
        waveformMatrix(:,k) = extract_window(x(:,k), startIndex(q), nsamples);
    end
    
%     FigHandle = figure('Position',[1500 150 300 1536]);
    FigHandle = figure('Position',[1500 150 384 1536]);
    set(gca,'YDir','reverse');
    hold on
    for k=1:nch
        wvf = scale_amp*waveformMatrix(:,k) + k;
        plot(time_values, wvf, 'b', 'LineWidth', 2);
        set(gca,'FontSize',22,'FontWeight','bold'); box on;
        text(xtext, k-0.65, titlestr{k}, 'FontSize', 22, 'FontWeight','bold', ...
        'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    end
    hold off
    xlabel(['Time (s), start = ', num2str(start_time(q))]);
    ylabel('Trace number');
    title({date_comp_str; [' network similarity = ', num2str(sort_det_sim(q))]});
    ylim([0 nch+1]);
    set(gca, 'YTick', [0:1:nch+1]);
    set(gca,'YTickLabel', ['  ';' 1';' 2';' 3';' 4';' 5';' 6';' 7';' 8';' 9';'10';'11';'12';'  ']);
end
