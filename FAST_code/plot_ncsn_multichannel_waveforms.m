close all
clear

% Read in data
addpath('input_data');

% blue: used for detection, black: not used for detection (correlated noise)

%----------------------------------------------------------------------------

% Old method, plot 1 component at a time
addpath('input_data');
% [t, x, samplingRate] = get_channel_data('NCSN_Calaveras_7ch_24hr');
[t, x, samplingRate] = get_NCSN_Calaveras_7ch_1wk;
date_comp_str = '2011-01-08';
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
    'CHR.EHZ', 'CML.EHZ'};

% outdir = './outputs/NCSN_detections_20110108_24hr/NCSN_CCOB_EHN_20110108_1wk/';
% load('../data/haar_coefficients/NCSN_CCOB_EHN_1wk/fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.08.mat');
% outdir = './outputs/NCSN_detections_20110108_24hr/autocorr_NCSN_CCOB_EHN_20110108_1wk/';
% load('../data/haar_coefficients/NCSN_CCOB_EHN_1wk/autocorr_detections_NCSN_CCOB_EHN_1wk.mat');

% outdir = './outputs/NCSN_detections_20110108_24hr/totalMatrix_NCSN_Calaveras_7ch_20110108_24hr/';
% load('../data/haar_coefficients/totalMatrix_NCSN_Calaveras_7ch_24hr/fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.mat');
% outdir = './outputs/NCSN_detections_20110108_24hr/autocorr_totalMatrix_NCSN_Calaveras_7ch_20110108_24hr/';
% load('../data/haar_coefficients/totalMatrix_NCSN_Calaveras_7ch_24hr/autocorr_sigma3_total_matrix_NCSN_Calaveras_7ch_24hr.mat');

outdir = './outputs/NCSN_detections_20110108_1wk/totalMatrix_NCSN_Calaveras_7ch_20110108_1wk/';
load('../data/haar_coefficients/totalMatrix_NCSN_Calaveras_7ch_1wk/fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.mat');
% outdir = './outputs/NCSN_detections_20110108_1wk/autocorr_totalMatrix_NCSN_Calaveras_7ch_20110108_1wk/';
% load('../data/haar_coefficients/totalMatrix_NCSN_Calaveras_7ch_1wk/autocorr_sigma4_timewin21_thresh1.0627.mat');

s = size(x);
nch = s(2);
dt_fp = dt;
% dt_fp = 0.05;

if ~exist('detection_out')
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt, time_window);
    [detection_out] = make_detection_list(topdata, thresh, dt, time_window);   
end

% Sort detection outputs
[sort_det, ix_sort] = sort(detection_out{2}, 'descend');
sort_det_times = double(detection_out{1}(ix_sort))*dt_fp;
sort_det_sim = detection_out{2}(ix_sort);

% start_time = sort_det_times(1:1000);
start_time = sort_det_times(1:500);
% start_time = sort_det_times(1:20);
% start_time = sort_det_times(1:60);

% start_time = [45899 45483 1941 925 22152 20030.5];
% start_time = [22152 20030.5 73698 66481 66101.5 66055 72765 59808];
% start_time = [64089];
% ****
% % start_time = [46121 48298.5 51609.5 46720.5 46620];
% % sort_det_sim = [sort_det_sim(49) sort_det_sim(59) sort_det_sim(126) sort_det_sim(129) sort_det_sim(147)];
window_duration = 20; % window duration (s)
end_time = start_time + window_duration;
scale_amp = 2;
xtext = 16;

startIndex = start_time * samplingRate;
endIndex = end_time * samplingRate;
nsamples_arr = endIndex - startIndex + 1;
nsamples = nsamples_arr(1);

dt = 1.0/samplingRate;
time_values = [0:dt:nsamples/samplingRate];
time_values = time_values(1:end-1);

% Old method, plot 1 component at a time
FigHandle = figure('Position',[1500 150 300 1000]);
for q=1:length(start_time)

    waveformMatrix = zeros(nsamples, nch);
    for k=1:nch
        waveformMatrix(:,k) = extract_window(x(:,k), startIndex(q), nsamples);
    end

    set(gcf,'PaperPositionMode','auto');
    set(gca,'YDir','reverse');
    hold on
    for k=1:nch
        wvf = scale_amp*waveformMatrix(:,k) + k;
        plot(time_values, wvf, 'b', 'LineWidth', 1);
        set(gca,'FontSize',16,'FontWeight','bold'); box on;
        text(xtext, k-0.65, titlestr{k}, 'FontSize', 16, 'FontWeight','bold', ...
        'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    end
    hold off
    xlabel(['Time (s), start = ', num2str(start_time(q))]);
    ylabel('Trace number');
    title({date_comp_str; [' network similarity = ', num2str(sort_det_sim(q))]});
%     title({date_comp_str; [' CC = ', num2str(sort_det_sim(q))]});
    ylim([0 nch+1]);
    set(gca, 'YTick', [0:1:nch+1]);
    set(gca,'YTickLabel', ['  ';' 1';' 2';' 3';' 4';' 5';' 6';' 7';'  ']);
    
     % Output plot
    filename = [outdir 'waveforms_rank' num2str(q,'%04d') '_sim' ...
        num2str(sort_det_sim(q)) '_time' num2str(start_time(q)) '.png'];
    print('-dpng', filename);
%     filename = [outdir 'waveforms_rank' num2str(q,'%04d') '_sim' ...
%         num2str(sort_det_sim(q)) '_time' num2str(start_time(q)) '.eps'];
%     print('-depsc', filename);
    clf reset;
end
