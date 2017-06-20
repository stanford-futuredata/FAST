close all
clear

%---------------------------INPUTS----------------------------------

baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';

% catalogFile = '../../data/TimeSeries/HRSN/cat20060509.txt';
% refDate = [2006 5 9 0 0 0];
% % dataFolder = 'totalMatrix_HRSN_21ch_20060509_24hr';
% % dataFolder = 'totalMatrix_HRSN_15ch_20060509_24hr';
% dataFolder = 'totalMatrix_HRSN_12ch_20060509_24hr';
% % fast.thresh = [1.2]; % 20060509
% % fast.thresh = [1]; % 20060509
% % fast.thresh = [0.8]; % 20060509
% % fast.thresh = [0.6]; % 20060509
% % fast.thresh = [0.4]; % 20060509
% % fast.thresh = [0.35]; % 20060509
% % fast.thresh = [0.3]; % 20060509
% % fast.thresh = [0.25]; % 20060509
% fast.thresh = [0.2]; % 20060509

catalogFile = '../../data/TimeSeries/HRSN/cat20071026.txt';
refDate = [2007 10 26 0 0 0];
% dataFolder = 'totalMatrix_HRSN_27ch_20071026_24hr';
% dataFolder = 'totalMatrix_HRSN_18ch_20071026_24hr';
dataFolder = 'totalMatrix_HRSN_12ch_20071026_24hr';
% fast.thresh = [1.2]; % 20071026
% fast.thresh = [1.18]; % 20071026
% fast.thresh = [1]; % 20071026
% fast.thresh = [0.8]; % 20071026
% fast.thresh = [0.6]; % 20071026
% fast.thresh = [0.5]; % 20071026
% fast.thresh = [0.45]; % 20071026
% fast.thresh = [0.4]; % 20071026
% fast.thresh = [0.35]; % 20071026
fast.thresh = [0.3]; % 20071026
% fast.thresh = [0.25]; % 20071026
% fast.thresh = [0.2]; % 20071026

% These files should be set at low thresholds (including false detections)
% autocorrFile should have detection flags set to 1 by visual inspection - 'ground truth'

autocorrFile = 'autocorr_timewin5_thresh1.5.txt';
fastFile = 'fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.2.txt';
% ac.thresh = [1.3]; % 20071026
% ac.thresh = [1.4]; % 20071026
% ac.thresh = [1.5]; % 20071026
% ac.thresh = [1.6]; % 20071026
% ac.thresh = [1.8]; % 20071026
ac.thresh = [1.87]; % 20071026
% ac.thresh = [2]; % 20071026
% fast.thresh = [0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.37 0.4 0.45 0.5];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.3 1.34 1.38 1.4 1.42 1.44 1.46 1.47 1.48 1.49 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84];

%---------------------------SETUP----------------------------------

% Read in catalog file, first 2 columns: {date, time}
% Treat this as ground truth for both autocorrelation and fast
fid = fopen(catalogFile, 'r');
catData = textscan(fid, '%s %s %s %s %s %s %s %s %*[^\n]');
fclose(fid);
catDates = [str2double(catData{1}) str2double(catData{2}) str2double(catData{3}) ...
    str2double(catData{5}) str2double(catData{6}) str2double(catData{7})];
catCCSum = [str2double(catData{8})];
s = size(catDates);
ncatalog = s(1); % number of catalog events
catTimes = zeros(ncatalog,1); % catalog time (s)
for k=1:ncatalog
    catTimes(k) = etime(catDates(k,:), refDate);
end

% Read in autocorrelation file - treat this as ground truth
autocorrPath = strcat(baseDir, dataFolder, '/', autocorrFile);
[ac.times, ac.sim, ac.detflag] = textread(autocorrPath, '%f %f %d');

% Limit autocorrelation inputs to those above ac.thresh
ind_keep_ac = find(ac.sim >= ac.thresh);
ac.times = ac.times(ind_keep_ac);
ac.sim = ac.sim(ind_keep_ac);
ac.detflag = ac.detflag(ind_keep_ac);
ac.output_flag = 1; % flag to output autocorrelation vs catalog comparison to file

% Read in fingerprint/similarity search file
fastPath = strcat(baseDir, dataFolder, '/', fastFile);
[fast.paramstr] = textread(fastPath, '%s', 1);
[fast.times, fast.sim] = textread(fastPath, '%f %f', 'headerlines', 1);
fast.output_flag = 1; % flag to output FAST vs catalog comparison to file

match_time_window = 10.0; % matching detections if they fall within this time window (s)

%---------------------------FAST VS AUTOCORRELATION-------------------------

% Compare fast against autocorrelation results
[detections] = compare_FAST_detections_with_autocorr(ac, fast, baseDir, dataFolder, match_time_window);
disp(dataFolder);

ac.nthresh = length(ac.thresh);
ac.precision = zeros(ac.nthresh,1);
ac.recall = zeros(ac.nthresh,1);
disp('Autocorrelation detections:');
for k=1:ac.nthresh
    ac.precision(k) = detections.ac(k).precision;
    ac.recall(k) = detections.ac(k).recall;
    disp(detections.ac(k))
end
ac.labels = cellstr(num2str(ac.thresh'));

fast.nthresh = length(fast.thresh);
fast.precision = zeros(fast.nthresh,1);
fast.recall = zeros(fast.nthresh,1);
disp('Fingerprint/similarity search detections:');
for k=1:fast.nthresh
    fast.precision(k) = detections.fast(k).precision;
    fast.recall(k) = detections.fast(k).recall;
    disp(detections.fast(k))
end
fast.labels = cellstr(num2str(fast.thresh'));

% % Plot precision-recall curve
% figure
% set(gca, 'FontSize', 16);
% plot(fast.recall, fast.precision, 'bo', ac.recall, ac.precision, 'ro')
% hold on
% plot(fast.recall, fast.precision, 'b', ac.recall, ac.precision, 'r')
% text(fast.recall, fast.precision, fast.labels, 'FontSize', 14, ...
%     'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
% text(ac.recall, ac.precision, ac.labels, 'FontSize', 14, ...
%     'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
% hold off
% legend('FAST', 'Autocorrelation', 'Location', 'SouthWest');
% xlabel('Recall');
% ylabel('Precision');
% ttt=title(['Precision-recall curve, ', dataFolder]);
% set(ttt,'Interpreter','none');

%-------------------FAST VS CATALOG, AUTOCORRELATION VS CATALOG-------------------

% Compare fast, autocorrelation against catalog results
[det_cat] = compare_detections_with_catalog(ac, fast, catTimes, catCCSum, baseDir, dataFolder, match_time_window);

% Can view contents of det_cat.fast, det_cat.ac as desired
