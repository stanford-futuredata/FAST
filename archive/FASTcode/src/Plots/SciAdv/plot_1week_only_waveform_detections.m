close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

% Get seismogram continuous data
timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'; % bandpass 4-10 Hz
% timeSeriesFile = '../../../data/TimeSeries/NCSN/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC'; % unfiltered data
[t, x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHN_1wk');

flag_plot_fp = 1;
% flag_plot_fp = 0;

%-------------------------------------------------------
folder = '../../../data/OutputFAST/NCSN_CCOB_EHN_1wk/';
if (flag_plot_fp)

   % Load list of detections from fingerprint/similarity search
   filename = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.19.txt';
   filepath = strcat(folder, filename);
   detection_out = dlmread(filepath, ' ', 1, 0);
   thresh = 0.19; % FAST similarity threshold

   % t=800, top deviation coefficients, thresh=0.33
   ndet = 101;
   detection_codes = 2 * ones(1,ndet);
   ind_catalog = [1 2 3 5 7 9 11 13 15 19 ...
       20 28 29 32 34 36 37 38 39 65 101]; % catalog indices
   ind_false = [23 24 40 48 49 53 54 68 72 83 ...
       99 100]; % false detection indices
   detection_codes(ind_catalog) = 1;
   detection_codes(ind_false) = 3;

   ind_new = [14 18 21 26 27 41 42 43 52 55 ...
       66 69 70 75 84 85 86 87 89 90 ...
       91 92 93 94 96]; % new detection indices (not found by autocorrelation)

   % new detection indices (also found by autocorrelation)
   ind_with_ac_new = setdiff([1:ndet], [ind_catalog ind_false ind_new]);

else
   %-------------------------------------------------------
   % Load list of detections from autocorrelation
   filename = 'autocorr_timewin21_thresh0.8179.txt';
   filepath = strcat(folder, filename);
   detection_out = dlmread(filepath);
   thresh = 0.8179; % Autocorrelation threshold

   % Autocorrelation results
   % t=800, top deviation coefficients, thresh=0.8179
   % don't show false detections
   ind_catalog = [1 2 3 5 7 9 11 13 14 17 ...
       19 24 25 28 30 32 33 34 35 43 ...
       51 53 63 86];
   detection_codes = 2 * ones(1,86);
   detection_codes(ind_catalog) = 1;

   % Detections missed by FAST, found in autocorrelation
   % Catalog events: indices 5, 12, 14
   % ind_miss = [20 21 39 42 43 45 46 47 48 49 ...
   %     50 51 52 53 67 75 76 80 84 85];
   ind_new_miss = [18 20 21 39 42 45 46 47 48 49 ...
       50 52 64 67 75 76 80 84 85];
   ind_catalog_miss = [43 51 53];

end
%-------------------------------------------------------

% Load list of detections, get detection times and samples
ind_det = find(detection_out(:,2) >= thresh);
detection_times = double(detection_out(ind_det,1));
detection_samples = round(detection_times * samplingRate);

det_window_time = 19.9; % detection window time (s)
det_window_length = det_window_time * samplingRate; % detection window length

dt_plot = 1.0/samplingRate;
time_values = [0:dt_plot:det_window_time-dt_plot];

ndetect = length(detection_samples);

waveformMatrix = zeros(ndetect, det_window_length);
for k=1:ndetect
    waveformMatrix(k,:) = extract_window(x, detection_samples(k), det_window_length);
end

font_size = 16;
line_width = 1;

if (flag_plot_fp)
    % Plot catalog events (21) - found with FAST
    FigHandle = figure('Position',[1500 150 330 1000]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:length(ind_catalog)
        plot(time_values, waveformMatrix(ind_catalog(k),:) + k, 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('Catalog event time in continuous data (s)');
    ylim([0 length(ind_catalog)+1]);
    set(gca, 'YTick', [0:1:length(ind_catalog)]);
%     set(gca,'YTickLabel', ['         ';'   553.95';'   616.74';'   792.45';'   993.81';'  1264.18';...
%         '  1626.34';'  1786.78';'  4859.12';'  8212.12';' 22925.43';...
%         ' 51805.57';'150967.85';'152038.98';'153018.91';'157526.70';...
%         '161549.05';'166401.85';'174144.37';'175332.16';...
%         '395178.84';'583296.05']); % regular catalog
    set(gca,'YTickLabel', ['         ';'   553.92';'   616.74';'   792.46';'   993.87';'  1264.18';...
        '  1626.20';'  1786.77';'  4859.12';'  8212.14';' 22925.43';...
        ' 51805.53';'150967.84';'152039.04';'153018.94';'157526.72';...
        '161549.02';'166401.84';'174144.37';'175332.14';...
        '395178.83';'583296.00']); % hypoDD catalog
    title('Catalog events');

    % Plot false detections (13) - found with FAST
    FigHandle = figure('Position',[1500 150 300 640]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:length(ind_false)
        plot(time_values, waveformMatrix(ind_false(k),:) + k, 'Color',[0,0.5,0],'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('FAST detection time in continuous data (s)');
    ylim([0 length(ind_false)+1]);
    set(gca, 'YTick', [0:1:length(ind_false)]);
    labels = [{'      '}; cellstr(num2str(detection_times(ind_false)))];
    set(gca, 'YTickLabel', labels);
    title('False detections');

    % Plot new events (21) - found with FAST - not found in autocorrelation
    FigHandle = figure('Position',[1500 150 300 1000]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:length(ind_new)
        plot(time_values, waveformMatrix(ind_new(k),:) + k, 'r', 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('FAST detection time in continuous data (s)');
    ylim([0 length(ind_new)+1]);
    set(gca, 'YTick', [0:1:length(ind_new)]);
    labels = [{'      '}; cellstr(num2str(detection_times(ind_new)))];
    set(gca, 'YTickLabel', labels);
    title({'FAST new events,', 'not in autocorrelation'});

    % Plot new events (22/43: 1-22) - found with FAST - also found in autocorrelation
    FigHandle = figure('Position',[1500 150 300 1000]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:22
        plot(time_values, waveformMatrix(ind_with_ac_new(k),:) + k, 'r', 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('FAST detection time in continuous data (s)');
    ylim([0 23]);
    set(gca, 'YTick', [0:1:22]);
    labels = [{'      '}; cellstr(num2str(detection_times(ind_with_ac_new(1:22))))];
    set(gca, 'YTickLabel', labels);
    title({'FAST new events,', 'also in autocorrelation'});
%     ylim([0 length(ind_with_ac_new)+1]);

    % Plot new events (21/43: 23-43) - found with FAST - also found in autocorrelation
    FigHandle = figure('Position',[1500 150 300 1000]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=23:length(ind_with_ac_new)
        plot(time_values, waveformMatrix(ind_with_ac_new(k),:) + k-22, 'r', 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('FAST detection time in continuous data (s)');
    ylim([0 22]);
    set(gca, 'YTick', [0:1:21]);
    labels = [{'      '}; cellstr(num2str(detection_times(ind_with_ac_new(23:end))))];
    set(gca, 'YTickLabel', labels);
    title({'FAST new events,', 'also in autocorrelation'});
%     ylim([0 length(ind_with_ac_new)+1]);

% Plot missed events (22) - found with autocorrelation - not found with FAST
else % flag_plot_fp == 0
    % Plot missed new events (19)
    FigHandle = figure('Position',[1500 150 330 1000]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:length(ind_new_miss)
        plot(time_values, waveformMatrix(ind_new_miss(k),:) + k, 'k', 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('Autocorrelation detection time in continuous data (s)');
    ylim([0 length(ind_new_miss)+1]);
    set(gca, 'YTick', [0:1:length(ind_new_miss)]);
    labels = [{'      '}; cellstr(num2str(detection_times(ind_new_miss)))];
    set(gca, 'YTickLabel', labels);
    title({'Autocorrelation new events,', 'missed by FAST'});
    
    % Plot missed catalog events (3)
    FigHandle = figure('Position',[1500 150 330 300]);
    set(gca,'YDir','normal');
    set(gca,'FontSize',font_size,'FontWeight','bold');
    hold on
    for k=1:length(ind_catalog_miss)
        plot(time_values, waveformMatrix(ind_catalog_miss(k),:) + k, 'k', 'LineWidth',line_width);
    end
    hold off 
    xlabel('Time (s)');
    ylabel('Catalog event time (s)');
    ylim([0 length(ind_catalog_miss)+1]);
    set(gca, 'YTick', [0:1:length(ind_catalog_miss)]);
%     set(gca,'YTickLabel', ['         ';'314076.86';'336727.14';'361735.92']); % regular catalog
    set(gca,'YTickLabel', ['         ';'314076.87';'336727.12';'361735.86']); % hypoDD catalog
    title('Missed catalog events');
end
