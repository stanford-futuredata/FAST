close all
clear

% Read in data
addpath('input_data');

% blue: used for detection, black: not used for detection (correlated noise)

% [t, x(:,1,3), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20060509_24hr');
% [t, x(:,2,3), samplingRate] = get_channel_data('HRSN_EADB_BP3_20060509_24hr');
% [t, x(:,3,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20060509_24hr');
% [t, x(:,4,3), samplingRate] = get_channel_data('HRSN_FROB_BP3_20060509_24hr');
% [t, x(:,5,3), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20060509_24hr');
% [t, x(:,6,3), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20060509_24hr');
% [t, x(:,7,3), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20060509_24hr');
% [t, x(:,8,3), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20060509_24hr');
% [t, x(:,9,3), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20060509_24hr');
% [t, x(:,10,3), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20060509_24hr');
% [t, x(:,11,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20060509_24hr');
% [t, x(:,12,3), samplingRate] = get_channel_data('HRSN_VARB_BP3_20060509_24hr');
% 
% [t, x(:,1,2), samplingRate] = get_channel_data('HRSN_GHIB_BP2_20060509_24hr');
% [t, x(:,2,2), samplingRate] = get_channel_data('HRSN_EADB_BP2_20060509_24hr');
% [t, x(:,3,2), samplingRate] = get_channel_data('HRSN_JCNB_BP2_20060509_24hr');
% [t, x(:,4,2), samplingRate] = get_channel_data('HRSN_FROB_BP2_20060509_24hr');
% [t, x(:,5,2), samplingRate] = get_channel_data('HRSN_VCAB_BP2_20060509_24hr');
% [t, x(:,6,2), samplingRate] = get_channel_data('HRSN_MMNB_BP2_20060509_24hr');
% [t, x(:,7,2), samplingRate] = get_channel_data('HRSN_LCCB_BP2_20060509_24hr');
% [t, x(:,8,2), samplingRate] = get_channel_data('HRSN_RMNB_BP2_20060509_24hr');
% [t, x(:,9,2), samplingRate] = get_channel_data('HRSN_CCRB_BP2_20060509_24hr');
% [t, x(:,10,2), samplingRate] = get_channel_data('HRSN_SMNB_BP2_20060509_24hr');
% [t, x(:,11,2), samplingRate] = get_channel_data('HRSN_SCYB_BP2_20060509_24hr');
% [t, x(:,12,2), samplingRate] = get_channel_data('HRSN_VARB_BP2_20060509_24hr');
% 
% [t, x(:,1,1), samplingRate] = get_channel_data('HRSN_GHIB_BP1_20060509_24hr');
% [t, x(:,2,1), samplingRate] = get_channel_data('HRSN_EADB_BP1_20060509_24hr');
% [t, x(:,3,1), samplingRate] = get_channel_data('HRSN_JCNB_BP1_20060509_24hr');
% [t, x(:,4,1), samplingRate] = get_channel_data('HRSN_FROB_BP1_20060509_24hr');
% [t, x(:,5,1), samplingRate] = get_channel_data('HRSN_VCAB_BP1_20060509_24hr');
% [t, x(:,6,1), samplingRate] = get_channel_data('HRSN_MMNB_BP1_20060509_24hr');
% [t, x(:,7,1), samplingRate] = get_channel_data('HRSN_LCCB_BP1_20060509_24hr');
% [t, x(:,8,1), samplingRate] = get_channel_data('HRSN_RMNB_BP1_20060509_24hr');
% [t, x(:,9,1), samplingRate] = get_channel_data('HRSN_CCRB_BP1_20060509_24hr');
% [t, x(:,10,1), samplingRate] = get_channel_data('HRSN_SMNB_BP1_20060509_24hr');
% [t, x(:,11,1), samplingRate] = get_channel_data('HRSN_SCYB_BP1_20060509_24hr');
% [t, x(:,12,1), samplingRate] = get_channel_data('HRSN_VARB_BP1_20060509_24hr');
% 
% det_color = { {'b', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b'}, ...
%     {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'b'}, ...
%     {'k', 'k', 'k', 'k', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'b'} };
% outdir = './outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_21ch_20060509_24hr/';
% load('../data/haar_coefficients/totalMatrix_HRSN_21ch_20060509_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.2.mat');
% 
% % det_color = { {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'k', 'b', 'b'}, ...
% %     {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'b', 'b'}, ...
% %     {'k', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b', 'b', 'b', 'k'} };
% % outdir = '../outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_15ch_20060509_24hr/';
% % load('../data/totalMatrix_HRSN_15ch_20060509_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat');
% 
% % det_color = { {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'k', 'k', 'b', 'b'}, ...
% %     {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'k', 'b'}, ...
% %     {'k', 'k', 'b', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'b', 'k'} };
% % outdir = './outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_12ch_20060509_24hr/';
% % load('../data/haar_coefficients/totalMatrix_HRSN_12ch_20060509_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat');
% 
% date_comp_str = {'2006-05-09, BP1', '2006-05-09, BP2', '2006-05-09, BP3'};
% titlestr = {'GHIB', 'EADB', 'JCNB', 'FROB', 'VCAB', 'MMNB', 'LCCB', 'RMNB', ...
%     'CCRB', 'SMNB', 'SCYB', 'VARB'};

%----------------------------------------------------------------------------

% Old method, plot 1 component at a time
% % % [t, x(:,1), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20071026_24hr');
% % % [t, x(:,2), samplingRate] = get_channel_data('HRSN_EADB_BP3_20071026_24hr');
% % % [t, x(:,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
% % % [t, x(:,4), samplingRate] = get_channel_data('HRSN_FROB_BP3_20071026_24hr');
% % % [t, x(:,5), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20071026_24hr');
% % % [t, x(:,6), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20071026_24hr');
% % % [t, x(:,7), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20071026_24hr');
% % % [t, x(:,8), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20071026_24hr');
% % % [t, x(:,9), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20071026_24hr');
% % % [t, x(:,10), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
% % % [t, x(:,11), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
% % % [t, x(:,12), samplingRate] = get_channel_data('HRSN_VARB_BP3_20071026_24hr');
% % % [t, x(:,13), samplingRate] = get_channel_data('HRSN_JCSB_BP3_20071026_24hr');
% % % det_color = {'b', 'b', 'b', 'b', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'k', 'k'};
% % % date_comp_str = '2007-10-26, BP3';

% New method, plot 3 components at a time
[t, x(:,1,3), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20071026_24hr');
[t, x(:,2,3), samplingRate] = get_channel_data('HRSN_EADB_BP3_20071026_24hr');
[t, x(:,3,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
[t, x(:,4,3), samplingRate] = get_channel_data('HRSN_FROB_BP3_20071026_24hr');
[t, x(:,5,3), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20071026_24hr');
[t, x(:,6,3), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20071026_24hr');
[t, x(:,7,3), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20071026_24hr');
[t, x(:,8,3), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20071026_24hr');
[t, x(:,9,3), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20071026_24hr');
[t, x(:,10,3), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
[t, x(:,11,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
[t, x(:,12,3), samplingRate] = get_channel_data('HRSN_VARB_BP3_20071026_24hr');
[t, x(:,13,3), samplingRate] = get_channel_data('HRSN_JCSB_BP3_20071026_24hr');

[t, x(:,1,2), samplingRate] = get_channel_data('HRSN_GHIB_BP2_20071026_24hr');
[t, x(:,2,2), samplingRate] = get_channel_data('HRSN_EADB_BP2_20071026_24hr');
[t, x(:,3,2), samplingRate] = get_channel_data('HRSN_JCNB_BP2_20071026_24hr');
[t, x(:,4,2), samplingRate] = get_channel_data('HRSN_FROB_BP2_20071026_24hr');
[t, x(:,5,2), samplingRate] = get_channel_data('HRSN_VCAB_BP2_20071026_24hr');
[t, x(:,6,2), samplingRate] = get_channel_data('HRSN_MMNB_BP2_20071026_24hr');
[t, x(:,7,2), samplingRate] = get_channel_data('HRSN_LCCB_BP2_20071026_24hr');
[t, x(:,8,2), samplingRate] = get_channel_data('HRSN_RMNB_BP2_20071026_24hr');
[t, x(:,9,2), samplingRate] = get_channel_data('HRSN_CCRB_BP2_20071026_24hr');
[t, x(:,10,2), samplingRate] = get_channel_data('HRSN_SMNB_BP2_20071026_24hr');
[t, x(:,11,2), samplingRate] = get_channel_data('HRSN_SCYB_BP2_20071026_24hr');
[t, x(:,12,2), samplingRate] = get_channel_data('HRSN_VARB_BP2_20071026_24hr');
[t, x(:,13,2), samplingRate] = get_channel_data('HRSN_JCSB_BP2_20071026_24hr');

[t, x(:,1,1), samplingRate] = get_channel_data('HRSN_GHIB_BP1_20071026_24hr');
[t, x(:,2,1), samplingRate] = get_channel_data('HRSN_EADB_BP1_20071026_24hr');
[t, x(:,3,1), samplingRate] = get_channel_data('HRSN_JCNB_BP1_20071026_24hr');
[t, x(:,4,1), samplingRate] = get_channel_data('HRSN_FROB_BP1_20071026_24hr');
[t, x(:,5,1), samplingRate] = get_channel_data('HRSN_VCAB_BP1_20071026_24hr');
[t, x(:,6,1), samplingRate] = get_channel_data('HRSN_MMNB_BP1_20071026_24hr');
[t, x(:,7,1), samplingRate] = get_channel_data('HRSN_LCCB_BP1_20071026_24hr');
[t, x(:,8,1), samplingRate] = get_channel_data('HRSN_RMNB_BP1_20071026_24hr');
[t, x(:,9,1), samplingRate] = get_channel_data('HRSN_CCRB_BP1_20071026_24hr');
[t, x(:,10,1), samplingRate] = get_channel_data('HRSN_SMNB_BP1_20071026_24hr');
[t, x(:,11,1), samplingRate] = get_channel_data('HRSN_SCYB_BP1_20071026_24hr');
[t, x(:,12,1), samplingRate] = get_channel_data('HRSN_VARB_BP1_20071026_24hr');
[t, x(:,13,1), samplingRate] = get_channel_data('HRSN_JCSB_BP1_20071026_24hr');

% det_color = { {'b', 'b', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'k', 'b'}, ...
%     {'k', 'b', 'b', 'b', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'k', 'k'}, ...
%     {'b', 'b', 'b', 'b', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'k', 'k'} }; % 27 ch
% outdir = '../outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_27ch_20071026_24hr/';
% load('../data/totalMatrix_HRSN_27ch_20071026_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.5.mat');

% det_color = { {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'k'}, ...
%     {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b'}, ...
%     {'k', 'k', 'b', 'b', 'b', 'b', 'b', 'k', 'k', 'b', 'b', 'k', 'k'} }; % 18 ch
% outdir = '../outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_18ch_20071026_24hr/';
% load('../data/totalMatrix_HRSN_18ch_20071026_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat');

det_color = { {'k', 'k', 'b', 'k', 'k', 'k', 'k', 'k', 'k', 'b', 'b', 'k', 'k'}, ...
    {'k', 'k', 'b', 'k', 'k', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b'}, ...
    {'k', 'k', 'b', 'k', 'k', 'b', 'k', 'k', 'k', 'b', 'b', 'k', 'k'} }; % 12 ch
outdir = './outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_12ch_20071026_24hr/';
load('../data/haar_coefficients/totalMatrix_HRSN_12ch_20071026_24hr/fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat');
% outdir = './outputs/HRSN_detections_20071026_24hr/autocorr_totalMatrix_HRSN_12ch_20071026_24hr/';
% load('../data/haar_coefficients/totalMatrix_HRSN_12ch_20071026_24hr/autocorr_sigma3.5_thresh0.5_timewin5_12ch.mat');

date_comp_str = {'2007-10-26, BP1', '2007-10-26, BP2', '2007-10-26, BP3'};
titlestr = {'GHIB', 'EADB', 'JCNB', 'FROB', 'VCAB', 'MMNB', 'LCCB', 'RMNB', ...
    'CCRB', 'SMNB', 'SCYB', 'VARB', 'JCSB'};


s = size(x);
nch = s(2);
dt_fp = 0.5;
% dt_fp = 0.05;

% % Figure S1, 600 s
% start_time = 37179;
% end_time = 37779;
% scale_amp = 5;
% xtext = 60;

% % Figure S1, 25 s
% start_time = 37474;
% end_time = 37499;
% scale_amp = 2;
% xtext = 2;

% Sort detection outputs
[sort_det, ix_sort] = sort(detection_out{2}, 'descend');
sort_det_times = double(detection_out{1}(ix_sort))*dt_fp;
sort_det_sim = detection_out{2}(ix_sort);

% start_time = sort_det_times(1:30);
% start_time = sort_det_times(31:60);
% start_time = sort_det_times(61:90);
start_time = sort_det_times(1:300);

% start_time = [45899 45483 1941 925 22152 20030.5];
% start_time = [22152 20030.5 73698 66481 66101.5 66055 72765 59808];
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
% for q=1:length(start_time)
% 
%     waveformMatrix = zeros(nsamples, nch);
%     for k=1:nch
%         waveformMatrix(:,k) = extract_window(x(:,k), startIndex(q), nsamples);
%     end
%     
%     FigHandle = figure('Position',[1500 150 256 1536]);
%     set(gca,'FontSize',16);
%     set(gca,'YDir','reverse');
%     hold on
%     for k=1:nch
%         wvf = scale_amp*waveformMatrix(:,k) + k;
%         plot(time_values, wvf, det_color{k}, 'LineWidth', 1);
%         text(xtext, k-0.6, titlestr{k}, 'FontSize', 14, ...
%         'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
%     end
%     hold off
%     xlabel(['Time (s), start = ', num2str(start_time(q))]);
%     ylabel('Trace number');
%     title({date_comp_str; [' network similarity = ', num2str(sort_det_sim(q))]});
%     ylim([0 nch+1]);
% end

% New method, plot 3 components at a time
FigHandle = figure('Position',[1500 150 1000 1536]);
for q=1:length(start_time)
    
%     FigHandle = figure('Position',[1500 150 1000 1536]);
    
    for ic=1:3 % loop over components

        waveformMatrix = zeros(nsamples, nch);
        for k=1:nch
            waveformMatrix(:,k) = extract_window(x(:,k,ic), uint32(startIndex(q)), nsamples);
        end

        subplot(1,3,ic);
        set(gca,'FontSize',14);
        set(gca,'YDir','reverse');
        hold on
        for k=1:nch
            wvf = scale_amp*waveformMatrix(:,k) + k;
            plot(time_values, wvf, det_color{ic}{k}, 'LineWidth', 1);
            text(xtext, k-0.8, titlestr{k}, 'FontSize', 12, ...
            'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
        end
        hold off
        xlabel(['Time (s), start = ', num2str(start_time(q))]);
        ylabel('Trace number');
        title({date_comp_str{ic}; [' network similarity = ', num2str(sort_det_sim(q))]});
        ylim([0 nch+1]);
    
    end

    % Output plot
    filename = [outdir 'waveforms_rank' num2str(q,'%04d') '_sim' ...
        num2str(sort_det_sim(q)) '_time' num2str(start_time(q)) '.png'];
    print('-dpng', filename);
    clf reset;
end
