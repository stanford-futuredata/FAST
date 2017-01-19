close all
clear

% Read in data
addpath('input_data');
[t, x(:,1), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
[t, x(:,2), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
[t, x(:,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
titlestr = {'JCNB', 'SMNB', 'SCYB'};
s = size(x);
nch = s(2);
t_hr = t/3600;

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
eqcatTimes = [2233 6617.5 29472 29935.5 31443.5 34634 35389.5 37907 43536.5 64091.5 68890.5 78295.5 85999.5];
eqcatValues = 10*ones(size(eqcatTimes));

% Normalize data
scale_amp = 200;
nsamples = s(1);
norm_x = zeros(nch, nsamples);
for k=1:nch
    norm_x(k,:) = scale_amp * (x(:,k) ./ norm(x(:,k)));
end
xtext=5000;

for ifile=1:length(folderStr)
    inputFile = strcat(baseDir, folderStr{ifile}, '/', fileName);
    load(inputFile);

    % Plot seismogram data
    FigHandle = figure('Position',[1500 150 1600 1536]);
    subplot(2,1,1);
    stem(catTimes, catValues, 'm');
    set(gca,'FontSize',16);
    set(gca,'YDir','reverse');
    hold on
    qq=stem(eqcatTimes, eqcatValues);
    set(qq, 'color', [0 0.8 0]);
    for k=1:nch
        wvf = norm_x(k,:) + k;
        plot(t, wvf, 'k');
        text(xtext, k-0.7, titlestr{k}, 'FontSize', 16, ...
            'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    end
    xlim([0 86400]);
    ylim([0 4]);
    xlabel('Time (s)');
    ylabel('Trace number');
    hold off
    
    % Plot detection data
    subplot(2,1,2);
    set(gca,'YDir','normal');
    stem(catTimes, catValues, 'm');
    hold on
    qq=stem(eqcatTimes, eqcatValues);
    set(qq, 'color', [0 0.8 0]);
    plot_detection_indices(totalPairs.i, totalPairs.j, totalPairs.k, dt_fp, ...
        folderStr{ifile}, 'Network similarity');
    hold off
    ylim([0 8]);

    outfile = [out_dir 'seismogram_' folderStr{ifile} '_fpss_detections.png'];
%     print('-dpng', outfile);
end
