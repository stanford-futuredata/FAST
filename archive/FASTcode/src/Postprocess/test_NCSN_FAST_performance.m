close all
clear

%---------------------------INPUTS----------------------------------

% These files should be set at low thresholds (including false detections)
% autocorrFile should have detection flags set to 1 by visual inspection - 'ground truth'

baseDir = '../../data/OutputFAST/';

% dataFolder = 'NCSN_CCOB_EHE_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.5401.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % Set comparison thresholds
% ac.thresh = [0.58];
% fast.thresh = [0.09];
% % fast.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.22]; % precision-recall test
% % ac.thresh = [0.5401 0.56 0.58 0.6 0.62 0.64 0.66]; % precision-recall test

% dataFolder = 'NCSN_CCOB_EHN_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.5514.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.58];
% fast.thresh = [0.09];
% % fast.thresh = [0.05 0.07 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.17 0.19]; % precision-recall test
% % ac.thresh = [0.5514 0.56 0.57 0.58 0.59 0.6 0.62 0.64 0.66]; % precision-recall test

% dataFolder = 'NCSN_CCOB_EHZ_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.581.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.58];
% fast.thresh = [0.09];
% % fast.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.23 0.25 0.27]; % precision-recall test
% % ac.thresh = [0.58 0.585 0.59 0.6 0.61 0.62 0.63]; % precision-recall test

% dataFolder = 'NCSN_CADB_EHZ_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.49.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.5];
% fast.thresh = [0.07];
% % fast.thresh = [0.05 0.07 0.09 0.1]; % precision-recall test
% % ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61]; % precision-recall test

% dataFolder = 'NCSN_CAO_EHZ_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.49.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.5];
% fast.thresh = [0.07];
% % fast.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.2 0.22 0.25 0.28 0.33 0.35]; % precision-recall test
% % ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61]; % precision-recall test

% dataFolder = 'NCSN_CHR_EHZ_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.49.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.5];
% fast.thresh = [0.05];
% % fast.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.19 0.21 0.23]; % precision-recall test
% % ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61]; % precision-recall test

% dataFolder = 'NCSN_CML_EHZ_24hr';
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog.txt';
% autocorrFile = 'autocorr_timewin21_thresh0.57.txt'; % manually modified text file
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% ac.thresh = [0.58];
% fast.thresh = [0.07];
% % fast.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.25 0.3 0.32]; % precision-recall test
% % ac.thresh = [0.57 0.575 0.58 0.585 0.59 0.595 0.6 0.605 0.61 0.62 0.64 0.66 0.68]; % precision-recall test

dataFolder = 'totalMatrix_NCSN_CCOB_3comp_24hr';
catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog_center.txt'; % now has 13 events
autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
ac.thresh = [1.15];
fast.thresh = [0.26];
% fast.thresh = [0.05 0.1 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.2 0.25 0.3 0.35 0.4];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.28 1.3 1.32 1.34 1.36 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.6 1.66 1.72 1.76 1.8 1.84];

% dataFolder = 'NCSN_CCOB_3comp_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue600_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.06.txt';
% % ac.thresh = [1.15];
% % fast.thresh = [0.14];
% fast.thresh = [0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.28 1.3 1.32 1.34 1.36 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.6 1.66 1.72 1.76 1.8 1.84];

% dataFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% % fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% % fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue2800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue5600_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% % % ac.thresh = [1.1];
% % ac.thresh = [1.48];
% % fast.thresh = [0.18];
% ac.thresh = [1.46];
% fast.thresh = [0.25];
% % % fast.thresh = [0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.1 1.2 1.3 1.4 1.5];
% % fast.thresh = [0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.25 0.27 0.3 0.35 0.4 0.6 0.8 1.0 1.2 1.4 1.5 1.6];
% % ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.3 1.34 1.38 1.4 1.42 1.44 1.46 1.47 1.48 1.49 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84];

% dataFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr'; % use autocorrelation as baseline for comparison
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_catalog_center.txt'; % now has 13 events
% % autocorrFile = 'autocorr_timewin21_thresh1.48.txt'; % precision-recall test - manually modified
% autocorrFile = 'autocorr_timewin21_thresh1.75.txt'; % final results
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.txt';
% ac.thresh = [1.75]; % final results
% fast.thresh = [0.17]; % final results
% % fast.thresh = [0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.25 0.27 0.3 0.35 0.4 0.6 0.8 1.0 1.2 1.4 1.5 1.6]; % precision-recall test
% % ac.thresh = [1.48 1.49 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84 2.0 2.5 3.0 3.3]; % precision-recall test

% dataFolder = 'NCSN_CCOB_EHN_1wk';
% % catalogFile = '../data/ncsn/calaveras_20110108_1week_catalog.txt'; % large box
% catalogFile = '../../data/TimeSeries/NCSN/calaveras_20110108_1week_hypoDD_catalog_smallbox.txt'; % small box, hypoDD
% % autocorrFile = 'autocorr_timewin21_thresh0.56.txt'; % precision-recall test - manually modified text file
% autocorrFile = 'autocorr_timewin21_thresh0.8179.txt'; % final results
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.08.txt';
% % fast.thresh = [0.05 0.07 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31 0.33 0.35 0.37 0.39 0.41 0.45 0.5]; % precision-recall test
% % ac.thresh = [0.56 0.57 0.58 0.59 0.6 0.62 0.64 0.66 0.7 0.72 0.74 0.76 0.78 0.8]; % precision-recall test
% ac.thresh = [0.8179]; % final results
% fast.thresh = [0.19]; % final results


% dataFolder = 'NCSN_Calaveras_7ch_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.06.txt';
% % ac.thresh = [1.1];
% % fast.thresh = [0.17];
% fast.thresh = [0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.3 1.34 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84];

% catalogFile = '../data/ncsn/calaveras_20110108_20110115_hypodd_catalog.txt';

%---------------------------SETUP----------------------------------

% Read in catalog file, first 2 columns: {date, time}
% Treat this as ground truth for both autocorrelation and fast
fid = fopen(catalogFile, 'r');
catData = textscan(fid, '%s %s %s %s %s %f %*[^\n]', 'HeaderLines', 2);
fclose(fid);
catMag = catData{6}; % catalog magnitudes
catDates = datevec(strcat(catData{1}, {' '}, catData{2}));
refDate = [2011 1 8 0 0 0];
s = size(catDates);
ncatalog = s(1); % number of catalog events
catTimes = zeros(ncatalog,1); % catalog time (s)
for k=1:ncatalog
    catTimes(k) = etime(catDates(k,:), refDate);
end

% Read in autocorrelation file - treat this as ground truth
autocorrPath = strcat(baseDir, dataFolder, '/', autocorrFile);
[ac.times, ac.sim, ac.detflag] = textread(autocorrPath, '%f %f %d');
ac.output_flag = 1; % flag to output autocorrelation vs catalog comparison to file

% Read in fingerprint/similarity search file
fastPath = strcat(baseDir, dataFolder, '/', fastFile);
[fast.paramstr] = textread(fastPath, '%s', 1);
[fast.times, fast.sim] = textread(fastPath, '%f %f', 'headerlines', 1);
fast.output_flag = 1; % flag to output FAST vs catalog comparison to file

match_time_window = 19.0; % matching detections if they fall within this time window (s)

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

% Plot precision-recall curve
figure
set(gca, 'FontSize', 16);
plot(fast.recall, fast.precision, 'bo', ac.recall, ac.precision, 'ro')
hold on
plot(fast.recall, fast.precision, 'b', ac.recall, ac.precision, 'r')
text(fast.recall, fast.precision, fast.labels, 'FontSize', 14, ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
text(ac.recall, ac.precision, ac.labels, 'FontSize', 14, ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
hold off
axis([0 1 0 1]);
legend('FAST', 'Autocorrelation', 'Location', 'SouthWest');
xlabel('Recall');
ylabel('Precision');
ttt=title(['Precision-recall curve, ', dataFolder]);
set(ttt,'Interpreter','none');

%-------------------FAST VS CATALOG, AUTOCORRELATION VS CATALOG-------------------

% Compare fast, autocorrelation against catalog results
[det_cat] = compare_detections_with_catalog(ac, fast, catTimes, catMag, baseDir, dataFolder, match_time_window);

% Can view contents of det_cat.fast, det_cat.ac as desired
