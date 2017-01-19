close all
clear

% Get seismogram continuous data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_Calaveras_7ch_24hr');
t_hr = t/3600;
s = size(x);
nsamples = s(1);
nch = s(2);
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
    'CHR.EHZ', 'CML.EHZ'};

% nsections = 3;
% nsections = 2;
nsections = 1;
nsamples_per_section = nsamples/nsections;

first_ind = nsamples_per_section*[0:nsections-1] + 1;
last_ind = nsamples_per_section*[1:nsections];

% ymax_arr = [200 200 200 200 200 200 200; ...
%     100 100 100 100 100 100 100; ...
%     100 100 100 100 100 100 100; ...
%     100 100 100 100 100 300 100];
% ymax_arr = [200 200 200 200 200 200 200; ...
%     100 100 100 100 100 100 100; ...
%     100 100 100 100 100 100 100];
% ymax_arr = [200 200 200 200 200 200 200; ...
%     100 100 100 100 100 100 100];
ymax_arr = [200 200 200 200 200 200 200];
ymin_arr = -ymax_arr;

% t_end = [8 16 24];
% t_end = [12 24];
t_end = [24];


% Load list of detections from fingerprint/similarity search
% Generated with combine_similarity_results()
% load('plot_scec_2014/NCSN_Calaveras_7ch_24hr_Detections_KeyF.mat');
folder = '../data/haar_coefficients/totalMatrix_NCSN_Calaveras_7ch_24hr/';
filename = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.mat';
filepath = strcat(folder, filename);
load(filepath);

if ~exist('detection_out')
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt, time_window);
    [detection_out] = make_detection_list(topdata, thresh, dt, time_window);   
end

dt = 1.0;
thresh = 0.17; % FPSS threshold
ind_det = find(detection_out{2} >= (thresh-eps));
detection_times = double(detection_out{1}(ind_det))*dt;
detection_samples = detection_times * samplingRate;

% Detection codes:
% 1: catalog
% 2: new detection
% 3: false detection

% t=800, top deviation coefficients, thresh=0.32
% don't show false detections
plot_colors = [ [0, 0, 1]; [1, 0, 0]; [0, 0.5, 0]; [0, 0, 0]];
% plot_colors = {'b', 'r', 'k'};
detection_codes = [1 1 3 1 2 1 2 1 2 1 ...
    2 1 2 2 2 2 1 3 2 3 ...
    2 1 2 2 2 1 2 1 2 2 ...
    2 3 3 2 2 1 2 2 1 3 ...
    2 2 3 3 2 2 2];

det_window_time = 19.9; % detection window time (s)
det_window_length = det_window_time * samplingRate; % detection window length

% Loop over time sections
ind_last_detection = 0; % initialize
for n=1:nsections
    ind_start = first_ind(n);
    ind_end = last_ind(n);
    
    % Get detection indices for this time section
    ind_first_detection = ind_last_detection+1; % from previous iteration
    ind_last_detection = max(find(detection_samples <= ind_end));
    FigHandle = figure('Position',[1500 100 1800 1000]);

    % Loop over channels
    for k=1:nch
        subplot(nch,1,k);
        plot(t_hr(ind_start:ind_end), x(ind_start:ind_end,k), 'k'); % xlim([xmin xmax]); title(titlestr{k});
        set(gca,'FontSize',24,'FontWeight','bold'); box on;
%         xlim([t_hr(ind_start) t_hr(ind_end)]);
        xlim([t_hr(ind_start) t_end(n)]);
        ylim([ymin_arr(n,k) ymax_arr(n,k)]);
        
        set(gca,'xtick',[]);
        ylabel(titlestr{k}); 
        set(get(gca,'ylabel'), 'Rotation', 0);
        set(get(gca,'ylabel'), 'Units', 'Normalized', 'Position', [0.5, 1.0, 0]);
        
        % Now plot the detections on top
        hold on
        for ii=ind_first_detection:ind_last_detection
            ind_det_start = detection_samples(ii);
            ind_det_end = detection_samples(ii) + det_window_length - 1;
%             plot(t_hr(ind_det_start:ind_det_end), x(ind_det_start:ind_det_end, k), ...
%                 plot_colors{detection_codes(ii)}, 'LineWidth', 3);
            plot(t_hr(ind_det_start:ind_det_end), x(ind_det_start:ind_det_end, k), ...
                'Color', plot_colors(detection_codes(ii),:), 'LineWidth', 3);
        end
        hold off
    end
    set(gca,'xtickmode','auto');
    xlabel('Time (hr)');
    set(gca, 'XTick', [0:3:24]);
    set(gca,'XTickLabel', [' 0';' 3';' 6';' 9';'12';'15';'18';'21';'24']);
    
% %     outfile = strcat('plot_scec_2014/waveform_detections_3parts_', num2str(n));
%     outfile = strcat('plot_scec_2014/waveform_detections_2dparts_', num2str(n));
%     print('-depsc', outfile);
end


