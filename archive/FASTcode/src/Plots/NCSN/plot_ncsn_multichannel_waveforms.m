close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

% blue: used for detection, black: not used for detection (correlated noise)

%----------------------------------------------------------------------------

timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHE.D.SAC.bp4to10';
[t, x(:,1), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHE_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10';
[t, x(:,2), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHN_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10';
[t, x(:,3), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CADB.EHZ.D.SAC.bp2to10';
[t, x(:,4), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CADB_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CAO.EHZ.D.SAC.bp2to10';
[t, x(:,5), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CAO_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CHR.EHZ.D.SAC.bp2to10';
[t, x(:,6), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CHR_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CML.EHZ.D.SAC.bp2to6';
[t, x(:,7), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CML_EHZ_24hr');
outdir = '../../../figures/NCSN/outputs/NCSN_detections_20110108_24hr/totalMatrix_NCSN_Calaveras_7ch_20110108_24hr/';
filepath = '../../../data/OutputFAST/totalMatrix_NCSN_Calaveras_7ch_24hr/fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.txt';
detection_out = dlmread(filepath, ' ', 1, 0);
% outdir = '../../../figures/NCSN/outputs/NCSN_detections_20110108_24hr/autocorr_totalMatrix_NCSN_Calaveras_7ch_20110108_24hr/';
% filepath = '../../../data/OutputFAST/totalMatrix_NCSN_Calaveras_7ch_24hr/autocorr_timewin21_thresh1.75.txt';
% detection_out = dlmread(filepath);

% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHE.D.SAC.bp4to10';
% [t, x(:,1), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHE_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10';
% [t, x(:,2), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHN_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHZ.D.SAC.bp4to10';
% [t, x(:,3), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHZ_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CADB..EHZ.D.SAC.bp2to10';
% [t, x(:,4), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CADB_EHZ_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CAO..EHZ.D.SAC.bp2to10';
% [t, x(:,5), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CAO_EHZ_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CHR..EHZ.D.SAC.bp2to10';
% [t, x(:,6), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CHR_EHZ_1wk');
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CML..EHZ.D.SAC.bp2to6';
% [t, x(:,7), samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CML_EHZ_1wk');
% outdir = '../../../figures/NCSN/outputs/NCSN_detections_20110108_1wk/totalMatrix_NCSN_Calaveras_7ch_20110108_1wk/';
% filepath = '../../../data/OutputFAST/totalMatrix_NCSN_Calaveras_7ch_1wk/fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.txt';
% detection_out = dlmread(filepath, ' ', 1, 0);
% % outdir = '../../../figures/NCSN/outputs/NCSN_detections_20110108_1wk/autocorr_totalMatrix_NCSN_Calaveras_7ch_20110108_1wk/';
% % filepath = '../../../data/OutputFAST/totalMatrix_NCSN_Calaveras_7ch_1wk/autocorr_timewin21_thresh1.75.txt';
% % detection_out = dlmread(filepath);

s = size(x);
nch = s(2);
date_comp_str = '2011-01-08';
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
    'CHR.EHZ', 'CML.EHZ'};

% Sort detection outputs
[sort_det_sim, ix_sort] = sort(detection_out(:,2), 'descend');
times_order = detection_out(:,1);
sort_det_times = times_order(ix_sort);

% start_time = sort_det_times(1:1000);
% start_time = sort_det_times(1:500);
start_time = sort_det_times(1:20);
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
