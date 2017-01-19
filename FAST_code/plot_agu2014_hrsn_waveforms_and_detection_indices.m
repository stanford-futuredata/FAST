close all
clear

% Read in data
addpath('input_data');
[t, x(:,1), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
[t, x(:,2), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
[t, x(:,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
[t, x(:,4), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20071026_24hr');
titlestr = {'JCNB.BP3', 'SMNB.BP3', 'SCYB.BP3', 'MMNB.BP3'};
s = size(x);
nch = s(2);
t_hr = t/3600;

numSamplesInWindow = 200;

% Read in detection data from Fpss
baseDir = '../data/haar_coefficients/';
% baseDir = '../data/';
fileName = 'fpss_wLen6_wLag0.05_fpLen64_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.1.mat';

folderStr = {
   'totalMatrix_HRSN_12ch_20071026_24hr', ...
   };
out_dir = './outputs/HRSN_detections_20071026_24hr/';
catalogFile = '../data/hrsn/cat20071026.txt';
dt_fp = 0.5;

% Read in catalog file
fid = fopen(catalogFile, 'r');
catData = textscan(fid, '%s %s %s %s %s %s %s %s %*[^\n]');
fclose(fid);
catTimes = str2double(catData{4});
catValues = 10*ones(size(catTimes));

% Earthquake times: 20071026
% eqcatTimes = [2233 6617.5 29472 29935.5 31443.5 34634 35389.5 37907 43536.5 64091.5 68890.5 78295.5 85999.5];
eqcatTimes = [2234.05 6616.54 37907.16 43534.17 64083.36]; % NCSN catalog earthquakes
% eqcatTimes = [2234.05 6616.54 29470 29935.5 31442 34634 35389 37907.16 43534.17 64083.36 78301.5 86005]; % NCSN catalog earthquakes (5) + new detections (7)
eqcatValues = 10*ones(size(eqcatTimes));

% Normalize data
scale_amp = 200;
nsamples = s(1);
norm_x = zeros(nch, nsamples);
for k=1:nch
    norm_x(k,:) = scale_amp * (x(:,k) ./ norm(x(:,k)));
end
xtext=20000;


for ifile=1:length(folderStr)
    inputFile = strcat(baseDir, folderStr{ifile}, '/', fileName);
    load(inputFile);

    % Eliminate duplicate pairs
    time_window = 5.0;
    thresh = 1.18;
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt_fp, time_window);
    [detection_out] = make_detection_list(topdata, thresh, dt_fp, time_window);

    % Plot seismogram data
    FigHandle = figure('Position',[1500 150 1400 1000]);
    subplot(2,1,1);
%     stem(catTimes, catValues, 'm');
%     set(gca,'FontSize',16);
    set(gca,'YDir','reverse');
    hold on
%     qq=stem(eqcatTimes, eqcatValues);
%     set(qq, 'color', [0 0.5 0]);
    for k=1:nch
        wvf = norm_x(k,:) + k;
        plot(t, wvf, 'k');
        set(gca,'FontSize',22,'FontWeight','bold');
%         text(xtext, k-0.5, titlestr{k}, 'FontSize', 16, ...
        text(xtext, k-0.6, titlestr{k}, 'FontSize', 22, 'FontWeight', 'bold', ...
            'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
%         for ii=1:length(catTimes)
%             startIndex = fix(catTimes(ii)*samplingRate);
%             t_cat = t(startIndex:startIndex+numSamplesInWindow-1);
%             wvf_cat = wvf(startIndex:startIndex+numSamplesInWindow-1);
%             plot(t_cat, wvf_cat, 'm', 'LineWidth', 2);
%         end
%         for ii=1:length(eqcatTimes)
%             startIndex = fix(eqcatTimes(ii)*samplingRate);
%             t_cat = t(startIndex:startIndex+numSamplesInWindow-1);
%             wvf_cat = wvf(startIndex:startIndex+numSamplesInWindow-1);
%             qq = plot(t_cat, wvf_cat, 'LineWidth', 2);
%             set(qq, 'color', [0 0.5 1]);
%         end
    end
    xlim([0 86400]);
    ylim([0 5]);
    set(gca, 'XTick', [0:3:24]*3600);
    set(gca,'XTickLabel', [' 0';' 3';' 6';' 9';'12';'15';'18';'21';'24']);
    set(gca,'YTickLabel', [' ';'1';'2';'3';'4';' ']);
    xlabel('Time (hr)');
    ylabel('Trace number');
    box on;
    hold off
    
    % Plot detection data
    subplot(2,1,2);
    set(gca,'YDir','normal');
%     stem(catTimes, catValues, 'm', 'LineWidth', 3);
%     set(gca, 'FontSize', 16);
    hold on
%     qq=stem(eqcatTimes, eqcatValues, 'LineWidth', 3);
%     set(qq, 'color', [0 0.5 1]);
%     plot_detection_indices(totalPairs.i, totalPairs.j, totalPairs.k, dt_fp, folderStr{ifile}, 'Network similarity');
%     plot_detection_indices(totalPairs.i, totalPairs.j, totalPairs.k, dt_fp, '', 'Network similarity');
    stem(double(detection_out{1})*dt_fp, detection_out{2}, 'k', 'LineWidth', 2);
    set(gca,'FontSize',22,'FontWeight','bold');
    ylabel('Network similarity');
    hold off
    xlim([0 86400]); % 24 hr
    ylim([0 4]);
    set(gca, 'XTick', [0:3:24]*3600);
    set(gca,'XTickLabel', [' 0';' 3';' 6';' 9';'12';'15';'18';'21';'24']);
    xlabel('Time (hr)');
    box on;
    
    outfile = [out_dir 'seismogram_' folderStr{ifile} '_fpss_detections.png'];
%     print('-dpng', outfile);
end
