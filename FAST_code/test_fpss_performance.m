close all
clear

%---------------------------INPUTS----------------------------------

catalogFile = '../data/ncsn/calaveras_20110108_catalog.txt';

% These files should be set at low thresholds (including false detections)
% autocorrFile should have detection flags set to 1 by visual inspection - 'ground truth'

baseDir = '../data/haar_coefficients/';

% dataFolder = 'NCSN_CCOB_EHE_24hr';
% autocorrFile = 'autocorr_CCOB.EHE.D.SAC.bp4to10_timewin20_thresh0.5401.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % Set comparison thresholds
% % ac.thresh = [0.58];
% % fpss.thresh = [0.2];
% % fpss.thresh = [0.05 0.1 0.15 0.18 0.21 0.24 0.27 0.3 0.33 0.36 0.4 0.45 0.5 0.6];
% % fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.22 0.24 0.27];
% fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.22];
% ac.thresh = [0.5401 0.56 0.58 0.6 0.62 0.64 0.66];

% dataFolder = 'NCSN_CCOB_EHN_24hr';
% autocorrFile = 'autocorr_CCOB.EHN.D.SAC.bp4to10_timewin20_thresh0.5514.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.58];
% % fpss.thresh = [0.24];
% % fpss.thresh = [0.05 0.15 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31 0.33 0.35 0.4 0.45 0.5 0.6];
% % fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.25 0.29 0.33 0.35 0.4];
% fpss.thresh = [0.05 0.07 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.17 0.19];
% ac.thresh = [0.5514 0.56 0.57 0.58 0.59 0.6 0.62 0.64 0.66];

% dataFolder = 'NCSN_CCOB_EHZ_24hr';
% autocorrFile = 'autocorr_CCOB.EHZ.D.SAC.bp4to10_timewin20_thresh0.581.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.58];
% % fpss.thresh = [0.24];
% % fpss.thresh = [0.05 0.1 0.15 0.2 0.24 0.27 0.29 0.3 0.33 0.35 0.37 0.4 0.45 0.47 0.5 0.55 0.6 0.7 0.8 0.9 1.0];
% % fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31 0.33 0.35 0.4 0.45];
% fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.23 0.25 0.27];
% ac.thresh = [0.58 0.585 0.59 0.6 0.61 0.62 0.63];

% dataFolder = 'NCSN_CADB_EHZ_24hr';
% autocorrFile = 'autocorr_CADB.EHZ.D.SAC.bp2to10_timewin20_thresh0.49.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.5];
% % fpss.thresh = [0.21];
% % fpss.thresh = [0.05 0.1 0.13 0.15 0.17 0.19 0.2 0.22];
% % fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17];
% fpss.thresh = [0.05 0.07 0.09 0.1];
% ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61];

% dataFolder = 'NCSN_CAO_EHZ_24hr';
% autocorrFile = 'autocorr_CAO.EHZ.D.SAC.bp2to10_timewin20_thresh0.49.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.5];
% % fpss.thresh = [0.19];
% % fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.19 0.21 0.25 0.28 0.3 0.35 0.4 0.45 0.5];
% % fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.2 0.22 0.25 0.28 0.33 0.35 0.4];
% fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.2 0.22 0.25 0.28 0.33 0.35];
% ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61];

% dataFolder = 'NCSN_CHR_EHZ_24hr';
% autocorrFile = 'autocorr_CHR.EHZ.D.SAC.bp2to10_timewin20_thresh0.49.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.5];
% % fpss.thresh = [0.21];
% % fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.16 0.17 0.18 0.19 0.21 0.24 0.27 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
% % fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.19 0.21 0.25 0.3 0.4 0.5 0.58 0.6];
% fpss.thresh = [0.05 0.07 0.09 0.1 0.12 0.15 0.17 0.19 0.21 0.23];
% ac.thresh = [0.49 0.5 0.505 0.51 0.52 0.53 0.54 0.55 0.57 0.59 0.61];

% dataFolder = 'NCSN_CML_EHZ_24hr';
% autocorrFile = 'autocorr_CML.EHZ.D.SAC.bp2to6_timewin20_thresh0.57.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [0.58];
% % fpss.thresh = [0.39];
% % fpss.thresh = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.6 0.7 0.8 1.0 1.2 1.5];
% % fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.25 0.3 0.32 0.35 0.4 0.45 0.5];
% fpss.thresh = [0.05 0.07 0.09 0.11 0.13 0.15 0.17 0.19 0.21 0.25 0.3 0.32];
% ac.thresh = [0.57 0.575 0.58 0.585 0.59 0.595 0.6 0.605 0.61 0.62 0.64 0.66 0.68];

% dataFolder = 'totalMatrix_NCSN_CCOB_3comp_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue600_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1200_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue2400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.05.txt';
% % ac.thresh = [1.15];
% % fpss.thresh = [0.26];
% % fpss.thresh = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.8 0.9 1.0];
% % fpss.thresh = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
% fpss.thresh = [0.05 0.1 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.2 0.25 0.3 0.35 0.4];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.28 1.3 1.32 1.34 1.36 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.6 1.66 1.72 1.76 1.8 1.84];

% dataFolder = 'NCSN_CCOB_3comp_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue600_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.06.txt';
% % ac.thresh = [1.15];
% % fpss.thresh = [0.14];
% fpss.thresh = [0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.28 1.3 1.32 1.34 1.36 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.6 1.66 1.72 1.76 1.8 1.84];

% dataFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% % fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue2800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue5600_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.1.txt';
% % % ac.thresh = [1.1];
% % ac.thresh = [1.48];
% % fpss.thresh = [0.18];
% ac.thresh = [1.46];
% fpss.thresh = [0.25];
% % % fpss.thresh = [0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.1 1.2 1.3 1.4 1.5];
% % fpss.thresh = [0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.25 0.27 0.3 0.35 0.4 0.6 0.8 1.0 1.2 1.4 1.5 1.6];
% % ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.3 1.34 1.38 1.4 1.42 1.44 1.46 1.47 1.48 1.49 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84];

% catalogFile = '../data/ncsn/calaveras_20110108_catalog_center.txt'; % now has 13 events
% dataFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr'; % use autocorrelation as baseline for comparison
% % autocorrFile = 'autocorr_timewin21_thresh1.48.txt';
% autocorrFile = 'autocorr_timewin21_thresh1.75.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.04.txt';
% % ac.thresh = [1.48];
% ac.thresh = [1.75];
% fpss.thresh = [0.17];
% % % fpss.thresh = [0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.1 1.2 1.3 1.4 1.5];
% % fpss.thresh = [0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.25 0.27 0.3 0.35 0.4 0.6 0.8 1.0 1.2 1.4 1.5 1.6];
% % ac.thresh = [1.48 1.49 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84 2.0 2.5 3.0 3.3];

% catalogFile = '../data/ncsn/calaveras_20110108_1week_catalog.txt'; % large box
catalogFile = '../data/ncsn/calaveras_20110108_1week_hypoDD_catalog_smallbox.txt'; % small box, hypoDD
dataFolder = 'NCSN_CCOB_EHN_1wk';
% autocorrFile = 'autocorr_CCOB..EHN.D.SAC.bp4to10_timewin21_thresh0.56.txt';
% autocorrFile = 'autocorr_CCOB..EHN.D.SAC.bp4to10_timewin21_thresh0.57.txt';
% autocorrFile = 'autocorr_CCOB..EHN.D.SAC.bp4to10_timewin21_thresh0.7.txt';
% autocorrFile = 'autocorr_CCOB..EHN.D.SAC.bp4to10_timewin21_thresh0.8165.txt';
autocorrFile = 'autocorr_CCOB..EHN.D.SAC.bp4to10_timewin21_thresh0.8179.txt';
fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.08.txt';
% fpss.thresh = [0.05 0.07 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31 0.33 0.35 0.37 0.39 0.41 0.45 0.5];
% ac.thresh = [0.5514 0.56 0.57 0.58 0.59 0.6 0.62 0.64 0.66 0.7 0.72 0.74 0.76 0.78 0.8];
% ac.thresh = [0.8165];
ac.thresh = [0.8179];
fpss.thresh = [0.19];
% fpss.thresh = [0.27];


% dataFolder = 'NCSN_Calaveras_7ch_24hr';
% autocorrFile = 'autocorr_timewin21_thresh1.0627.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400_nfuncs5_ntbls100_nvotes2_timewin21_thresh0.06.txt';
% % ac.thresh = [1.1];
% % fpss.thresh = [0.17];
% fpss.thresh = [0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22];
% ac.thresh = [1.06 1.1 1.14 1.18 1.22 1.26 1.3 1.34 1.38 1.4 1.42 1.44 1.46 1.5 1.54 1.58 1.62 1.68 1.72 1.76 1.8 1.84];

% catalogFile = '../data/ncsn/calaveras_20110108_20110115_hypodd_catalog.txt';

%---------------------------SETUP----------------------------------

% Read in catalog file, first 2 columns: {date, time}
% Treat this as ground truth for both autocorrelation and fpss
fid = fopen(catalogFile, 'r');
catData = textscan(fid, '%s %s %s %s %s %s %*[^\n]', 'HeaderLines', 2);
fclose(fid);
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

% Read in fingerprint/similarity search file
fpssPath = strcat(baseDir, dataFolder, '/', fpssFile);
[fpss.paramstr] = textread(fpssPath, '%s', 1);
[fpss.times, fpss.sim] = textread(fpssPath, '%f %f', 'headerlines', 1);

%---------------------------FPSS VS AUTOCORRELATION-------------------------

% Compare fpss against autocorrelation results
[detections] = compare_fpss_detections_with_autocorr(ac, fpss, baseDir, dataFolder);
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

fpss.nthresh = length(fpss.thresh);
fpss.precision = zeros(fpss.nthresh,1);
fpss.recall = zeros(fpss.nthresh,1);
disp('Fingerprint/similarity search detections:');
for k=1:fpss.nthresh
    fpss.precision(k) = detections.fpss(k).precision;
    fpss.recall(k) = detections.fpss(k).recall;
    disp(detections.fpss(k))
end
fpss.labels = cellstr(num2str(fpss.thresh'));

% Plot precision-recall curve
figure
set(gca, 'FontSize', 16);
plot(fpss.recall, fpss.precision, 'bo', ac.recall, ac.precision, 'ro')
hold on
plot(fpss.recall, fpss.precision, 'b', ac.recall, ac.precision, 'r')
text(fpss.recall, fpss.precision, fpss.labels, 'FontSize', 14, ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
text(ac.recall, ac.precision, ac.labels, 'FontSize', 14, ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
hold off
axis([0 1 0 1]);
legend('FPSS', 'Autocorrelation', 'Location', 'SouthWest');
xlabel('Recall');
ylabel('Precision');
ttt=title(['Precision-recall curve, ', dataFolder]);
set(ttt,'Interpreter','none');

%-------------------FPSS VS CATALOG, AUTOCORRELATION VS CATALOG-------------------

% Compare fpss, autocorrelation against catalog results
[det_cat] = compare_detections_with_catalog(ac, fpss, catTimes, baseDir, dataFolder);

% Can view contents of det_cat.fpss, det_cat.ac as desired
