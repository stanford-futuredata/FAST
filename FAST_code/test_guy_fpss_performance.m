close all
clear

%---------------------------INPUTS----------------------------------

% These files should be set at low thresholds (including false detections)
% autocorrFile should have detection flags set to 1 by visual inspection - 'ground truth'

baseDir = '../data/haar_coefficients/';

% catalogFile = '../data/GuyArkansas/20101101_01hr_Time.txt';
% magFile = '../data/GuyArkansas/20101101_01hr_Mag.txt';
% dataFolder = 'totalMatrix_WHAR_20101101_3ch_01hr';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag5_tvalue800_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls500_nvotes2_timewin3_thresh0.02.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs4_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen32_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen32_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.06.txt';
% % fpss.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% % fpss.thresh = [0.12 0.16 0.2 0.24 0.28 0.32 0.36]; % fpLen32
% % fpss.thresh = [0.02 0.024 0.028 0.032 0.036 0.04 0.044]; % ntbls500
% fpss.thresh = [0.15];

% catalogFile = '../data/GuyArkansas/20101101_Time.txt';
% magFile = '../data/GuyArkansas/20101101_Mag.txt';
% dataFolder = 'totalMatrix_WHAR_20101101_3ch_24hr';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin3_thresh0.15.txt';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.15.txt';
% % fpss.thresh = [0.15 0.16 0.17 0.18 0.19 0.2];
% % fpss.thresh = [0.21 0.22 0.23 0.24 0.25 0.26];
% fpss.thresh = [0.27 0.28 0.29 0.30 0.31 0.32];

% catalogFile = '../data/GuyArkansas/20100701_20100708_Time.txt';
% magFile = '../data/GuyArkansas/20100701_20100708_Mag.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_1wk';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin3_thresh0.15.txt';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin4_thresh0.15.txt';
% % fpss.thresh = [0.15 0.16 0.17 0.18 0.19 0.2];
% % fpss.thresh = [0.21 0.22 0.23 0.24 0.25 0.26];
% fpss.thresh = [0.27 0.28 0.29 0.30 0.31 0.32];

% catalogFile = '../data/GuyArkansas/20100701_20100715_Time.txt';
% magFile = '../data/GuyArkansas/20100701_20100715_Mag.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_2wk';
% % fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin3_thresh0.15.txt';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fpss.thresh = [0.15 0.16 0.17 0.18 0.19 0.2];
% % fpss.thresh = [0.21 0.22 0.23 0.24 0.25 0.26];
% % fpss.thresh = [0.27 0.28 0.29 0.30 0.31 0.32];

% catalogFile = '../data/GuyArkansas/201007_Time.txt';
% magFile = '../data/GuyArkansas/201007_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_1month';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fpss.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../data/GuyArkansas/201008_Time.txt';
% magFile = '../data/GuyArkansas/201008_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100801_3ch_1month';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fpss.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../data/GuyArkansas/201006_Time.txt';
% magFile = '../data/GuyArkansas/201006_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100601_3ch_1month';
% fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.3.txt';
% fpss.thresh = [0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5];

catalogFile = '../data/GuyArkansas/Template_detection_time_201006_201008.txt';
magFile = '../data/GuyArkansas/Template_detection_mag_corrected_201006_201008.txt';
dataFolder = 'totalMatrix_WHAR_20100601_3ch_3month';
fpssFile = 'fpss_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.25.txt';
fpss.thresh = [0.33];
% fpss.thresh = [0.25 0.3 0.35 0.4];


% Read in catalog file (template matching)
catTimes = dlmread(catalogFile);
catMag = dlmread(magFile);

% Read in fingerprint/similarity search file
fpssPath = strcat(baseDir, dataFolder, '/', fpssFile);
[fpss.paramstr] = textread(fpssPath, '%s', 1);
[fpss.times, fpss.sim] = textread(fpssPath, '%f %f', 'headerlines', 1);


%-------------------FPSS VS CATALOG, AUTOCORRELATION VS CATALOG-------------------

% Compare fpss, autocorrelation against catalog results
[det_cat] = compare_guy_detections_with_catalog(fpss, catTimes, catMag, baseDir, dataFolder);
