close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/SAC/');

% Get seismogram continuous data
timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10';
[t, x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHN_1wk');
t_hr = t/3600;
s = size(x);
nsamples = s(1);

% Divide up continuous data into 7 sections: one per day
nsections = 7;
nsamples_per_section = nsamples/nsections;

first_ind = nsamples_per_section*[0:nsections-1] + 1;
last_ind = nsamples_per_section*[1:nsections];

ymax_arr = [200 200 200 200 200 200 200];
ymin_arr = -ymax_arr;

t_end = [1:7]*24;

% Detection codes:
% 1: catalog
% 2: new detection
% 3: false detection
% 4: below threshold, don't plot
plot_colors = [ [0, 0, 1]; [1, 0, 0]; [0, 1, 1]; [0, 0, 0]];
% plot_colors = {'b', 'r', 'g', 'k'};
% plot_colors = {'b', 'r', 'k', 'k'}; % do not plot false detections

folder = '../../../data/OutputFAST/NCSN_CCOB_EHN_1wk/';

%-------------------------------------------------------
% Load list of detections from fingerprint/similarity search
filename = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.19.txt';
filepath = strcat(folder, filename);
detection_out = dlmread(filepath, ' ', 1, 0);
thresh = 0.19; % FAST threshold

% t=800, top deviation coefficients, thresh=0.19
ndet = 101;
detection_codes = 2 * ones(1,ndet);
ind_catalog = [1 2 3 5 7 9 11 13 15 19 ...
    20 28 29 32 34 36 37 38 39 65 101]; % catalog indices
ind_false = [23 24 40 48 49 53 54 68 72 83 ...
    99 100]; % false detection indices
detection_codes(ind_catalog) = 1;
detection_codes(ind_false) = 3;

%-------------------------------------------------------
% % Load list of detections from autocorrelation
% % filename = 'autocorr_detections_NCSN_CCOB_EHN_1wk.mat';
% filename = 'autocorr_timewin21_thresh0.8179.txt';
% filepath = strcat(folder, filename);
% detection_out = dlmread(filepath);
% thresh = 0.8179; % Autocorrelation threshold
% 
% % Autocorrelation results
% % t=800, top deviation coefficients, thresh=0.8179
% % don't show false detections
% ind_catalog = [1 2 3 5 7 9 11 13 14 17 ...
%     19 24 25 28 30 32 33 34 35 43 ...
%     51 53 63 86];
% detection_codes = 2 * ones(1,86);
% detection_codes(ind_catalog) = 1;

%-------------------------------------------------------

% Load list of detections, get detection times and samples
ind_det = find(detection_out(:,2) >= thresh);
detection_times = double(detection_out(ind_det,1));
detection_samples = round(detection_times * samplingRate);

det_window_time = 19.9; % detection window time (s)
det_window_length = det_window_time * samplingRate; % detection window length

% Loop over time sections
FigHandle = figure('Position',[1500 100 1800 1000]);
ind_last_detection = 0; % initialize
for n=1:nsections
    ind_start = first_ind(n);
    ind_end = last_ind(n);
    
    % Get detection indices for this time section
    ind_first_detection = ind_last_detection+1; % from previous iteration
    ind_last_detection = max(find(detection_samples <= ind_end));

    % Plot continuous data for this time section
    subplot(nsections,1,n);
    plot(t_hr(ind_start:ind_end), x(ind_start:ind_end), 'k');
    set(gca,'FontSize',22,'FontWeight','bold'); box on;
%     set(gca,'FontSize',16); box on;
    xlim([t_hr(ind_start) t_end(n)]);
    ylim([ymin_arr(n) ymax_arr(n)]);

    %set(gca,'xtick',[]);

    % Now plot the detections on top
    hold on
    for ii=ind_first_detection:ind_last_detection
        ind_det_start = detection_samples(ii);
        ind_det_end = detection_samples(ii) + det_window_length - 1;
%         plot(t_hr(ind_det_start:ind_det_end), x(ind_det_start:ind_det_end), ...
%             plot_colors{detection_codes(ii)}, 'LineWidth', 3);
        plot(t_hr(ind_det_start:ind_det_end), x(ind_det_start:ind_det_end), ...
            'Color', plot_colors(detection_codes(ii),:), 'LineWidth', 3);
    end
    hold off

    set(gca,'xtickmode','auto');
    set(gca, 'XTick', [t_end(n)-24:3:t_end(n)]);
end
xlabel('Time (hr)');

