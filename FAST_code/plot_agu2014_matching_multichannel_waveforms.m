close all
clear

% Save plots of event windows from all components from NCSN 7 channels, Calaveras Fault
% CCOB (3 components), CADB, CAO, CHR, CML
% 2014-06-02 Clara Yoon

%%%%%%%%%%%%%%%%%%% SEISMOGRAMS %%%%%%%%%%%%%%%%%%%

% % Get data from each station
% addpath('input_data');
% [t, x, samplingRate] = get_channel_data('NCSN_Calaveras_7ch_24hr');
% s = size(x);
% nch = s(2);
% titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
%     'CHR.EHZ', 'CML.EHZ'};
% 
% % Get start times for events
% start_time = [555 613 787 827 1157 1266 1340 1628 1728 1784 3531 4710];
% % start_time = [4849 8219 10329 22924 51794 54038 70494 81199 85955 537 818 987];
% % start_time = [1806 4678 4885 4958 7794 11296 11650 23490 25550 51685 54599];
% % start_time = [58284 64068 26464 19790 27229 85923];
% window_duration = 20; % window duration (s)
% 
% % Plot and save
% dir = '../status_earthquake/20140602_multichannel_events/bpfilter/';
% for k=1:length(start_time)
%     plot_matching_multichannel_waveforms(t, x, samplingRate, titlestr, ...
%         start_time(k), window_duration);
%     filename = [dir 'ncsn_7channel_waveforms_' num2str(start_time(k))];
%     print('-depsc', filename);
% end

% % Get data from each station
% addpath('input_data');
% [t, x, samplingRate] = get_channel_data('NCSN_CCOB_3comp_24hr');
% s = size(x);
% nch = s(2);
% titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ'};
% 
% % Get start times for events
% load('detection_out.mat');
% dt = 0.05;
% start_time = double(detection_out{1})*dt;
% window_duration = 20; % window duration (s)
% 
% % Plot and save
% dir = './waveform_output/';
% FigHandle = figure('Position',[2000 100 400 400]);
% for k=1:length(start_time)
%     plot_matching_multichannel_waveforms(t, x, samplingRate, titlestr, ...
%         start_time(k), window_duration);
%     filename = [dir 'ncsn_3comp_waveforms_' num2str(start_time(k))];
%     print('-dpng', filename);
% end

% Get data from each station
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_Calaveras_7ch_24hr');
s = size(x);
nch = s(2);
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
    'CHR.EHZ', 'CML.EHZ'};

% Get start times for events
% load('detections_NCSN_Calaveras_7ch_24hr.mat');
% dt = 0.05;
% start_time = double(detection_out{1})*dt;
% start_time = [6924 25797 25818 25839 53637 54561 66008 76903 76934 76955 ...
%     77309 77484 77530 77556 80449 82496 82519 83378 83728];
start_time = [1161 1808];
window_duration = 20; % window duration (s)

% Plot and save
dir = './waveform_output/';
% dir = './pulses_nofilter/';
% FigHandle = figure('Position',[2000 100 400 1000]);
for ii=1:length(start_time)
    FigHandle = figure('Position',[2000 100 400 1000]);
    xmin = start_time(ii);
    xmax = start_time(ii)+window_duration;
    first_sample = xmin*samplingRate;
    last_sample = xmax*samplingRate;
    for k=1:nch
        subplot(nch,1,k);
        plot(t, x(:,k), 'LineWidth', 2);
        xlim([xmin xmax]);
        set(gca, 'FontSize', 20, 'FontWeight', 'bold');
        box on;
        set(gca, 'xtick', []);
        y_l = get(gca,'ylim');
        text(xmin+6, y_l(2)*1.4, titlestr{k}, 'FontSize', 20, 'FontWeight', 'bold');
    end
    set(gca, 'XTick', [xmin xmin+10 xmin+20]);
    xlabel('Time (s)');

%     filename = [dir 'ncsn_7ch_waveforms_' num2str(start_time(k))];
%     print('-dpng', filename);
%     print('-depsc', filename);
end