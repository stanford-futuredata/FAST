close all
clear

%---------------------------INPUTS----------------------------------

% These files should be set at low thresholds (including false detections)
% autocorrFile should have detection flags set to 1 by visual inspection - 'ground truth'

baseDir = '../../data/OutputFAST/';

% catalogFile = '../../data/TimeSeries/WHAR/20101101_01hr_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/20101101_01hr_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20101101_3ch_01hr';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag5_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls500_nvotes2_timewin4_thresh0.02.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen100_fpLag10_tvalue800_nfuncs4_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen32_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fastFile = 'fast_wLen3_wLag0.03_fpLen32_fpLag10_tvalue200_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.06.txt';
% % fast.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% % fast.thresh = [0.12 0.16 0.2 0.24 0.28 0.32 0.36]; % fpLen32
% % fast.thresh = [0.02 0.024 0.028 0.032 0.036 0.04 0.044]; % ntbls500
% % fast.thresh = [0.15];
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/20101101_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/20101101_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20101101_3ch_24hr';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes2_timewin4_thresh0.15.txt';
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/20100701_20100708_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/20100701_20100708_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_1wk';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes2_timewin4_thresh0.15.txt';
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/20100701_20100715_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/20100701_20100715_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_2wk';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs6_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/201007_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/201007_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100701_3ch_1month';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/201008_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/201008_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100801_3ch_1month';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.15.txt';
% fast.thresh = [0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32];

% catalogFile = '../../data/TimeSeries/WHAR/201006_Time.txt';
% magFile = '../../data/TimeSeries/WHAR/201006_Mag_Corrected.txt';
% dataFolder = 'totalMatrix_WHAR_20100601_3ch_1month';
% fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.3.txt';
% fast.thresh = [0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5];

catalogFile = '../../data/TimeSeries/WHAR/Template_detection_time_201006_201008.txt';
magFile = '../../data/TimeSeries/WHAR/Template_detection_mag_corrected_201006_201008.txt';
dataFolder = 'totalMatrix_WHAR_20100601_3ch_3month';
fastFile = 'fast_wLen3_wLag0.03_fpLen64_fpLag10_tvalue800_nfuncs8_ntbls100_nvotes4_timewin4_thresh0.25.txt';
fast.thresh = [0.33];
% fast.thresh = [0.25 0.3 0.35 0.4];


% Read in catalog file (template matching)
catTimes = dlmread(catalogFile);
catMag = dlmread(magFile);

% Read in fingerprint/similarity search file
fastPath = strcat(baseDir, dataFolder, '/', fastFile);
[fast.paramstr] = textread(fastPath, '%s', 1);
[fast.times, fast.sim] = textread(fastPath, '%f %f', 'headerlines', 1);
fast.output_flag = 1; % flag to output FAST vs catalog comparison to file

% Dummy inputs for autocorrelation
ac.times = [];
ac.thresh = [];
ac.output_flag = 0;

% Only for totalMatrix_WHAR_20100601_3ch_3month
if (strcmp(dataFolder, 'totalMatrix_WHAR_20100601_3ch_3month'))
   disp(['Subtract 1.9 s from each FAST detection time']);
   fast.times = fast.times - 1.9; % subtract 1.9 s (offset) from FAST detection times to match template matching detection times
end

match_time_window = 4.0; % matching detections if they fall within this time window (s)
% match_time_window = 5.7; % matching detections if they fall within this time window (s)

%-------------------FAST VS CATALOG, AUTOCORRELATION VS CATALOG-------------------

% Compare fast, autocorrelation against catalog results
[det_cat] = compare_detections_with_catalog(ac, fast, catTimes, catMag, baseDir, dataFolder, match_time_window);
