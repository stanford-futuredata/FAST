close all
clear

%---------------------------INPUTS----------------------------------

baseDir = '../data/haar_coefficients/';

% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02';
dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01';
autocorrFile = 'autocorr_CCOB.EHN.D.SAC.bp4to10_timewin21_thresh0.5.txt';
fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.04.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs4_ntbls200_nvotes2_timewin21_thresh0.06.txt';
% fpssFile = 'fpss_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs4_ntbls500_nvotes2_timewin21_thresh0.03.txt';
% fpss.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.12 0.14 0.16 0.18 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.68 0.7 0.8 0.9 1];

% % 24-36, 0.05
% fpss.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.7];

% % 24-36, 0.03
% fpss.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.15 0.18 0.2];
% % fpss.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.2];
% % fpss.thresh = [0.06 0.065 0.07 0.075 0.08 0.085 0.09 0.095 0.1 0.105 0.11 0.115 0.12];
% % fpss.thresh = [0.03 0.032 0.035 0.04 0.043 0.045 0.05 0.055 0.06];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.7 0.8 0.82];

% 24-36, 0.01
fpss.thresh = [0.04 0.05 0.06 0.07 0.08 0.1 0.12 0.15 0.18];
ac.thresh = [0.5 0.52 0.54 0.58 0.62];

%---------------------------SETUP----------------------------------

catTimes = [900:1800:42300]; % 'ground truth' times for synthetic data

% Read in autocorrelation file - treat this as ground truth
autocorrPath = strcat(baseDir, dataFolder, '/', autocorrFile);
[ac.times, ac.sim, ac.detflag] = textread(autocorrPath, '%f %f %d');

% Read in fingerprint/similarity search file
fpssPath = strcat(baseDir, dataFolder, '/', fpssFile);
[fpss.paramstr] = textread(fpssPath, '%s', 1);
[fpss.times, fpss.sim] = textread(fpssPath, '%f %f', 'headerlines', 1);

%---------------------------FPSS VS AUTOCORRELATION-------------------------

% Compare fpss, autocorrelation results against 'ground truth'
[detections] = compare_detections_with_catalog(ac, fpss, catTimes, baseDir, dataFolder);
disp(dataFolder);

ac.nthresh = length(ac.thresh);
ac.precision = zeros(ac.nthresh,1);
ac.recall = zeros(ac.nthresh,1);
disp('Autocorrelation detections:');
for k=1:ac.nthresh
    ac.precision(k) = detections.ac(k).match/(detections.ac(k).match + detections.ac(k).new);
    ac.recall(k) = detections.ac(k).match/(detections.ac(k).match + detections.ac(k).missed);
    disp(detections.ac(k))
end
ac.labels = cellstr(num2str(ac.thresh'));

fpss.nthresh = length(fpss.thresh);
fpss.precision = zeros(fpss.nthresh,1);
fpss.recall = zeros(fpss.nthresh,1);
disp('Fingerprint/similarity search detections:');
for k=1:fpss.nthresh
    fpss.precision(k) = detections.fpss(k).match/(detections.fpss(k).match + detections.fpss(k).new);
    fpss.recall(k) = detections.fpss(k).match/(detections.fpss(k).match + detections.fpss(k).missed);
    disp(detections.fpss(k))
end
fpss.labels = cellstr(num2str(fpss.thresh'));

% Plot precision-recall curve
% FigHandle = figure('Position',[300 300 600 600]);
figure
set(gca, 'FontSize', 16);
plot(fpss.recall, fpss.precision, 'bo', ac.recall, ac.precision, 'ro', 'LineWidth',2)
hold on
plot(fpss.recall, fpss.precision, 'b', ac.recall, ac.precision, 'r', 'LineWidth',2)
text(fpss.recall, fpss.precision, fpss.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [0,0,1], ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
% text(ac.recall, ac.precision, ac.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [1,0,0], ...
%     'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % 0.01 only
text(ac.recall, ac.precision, ac.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [1,0,0], ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
hold off
% axis image;
axis([0 1 0 1]);
legend('FAST', 'Autocorrelation', 'Location', 'best');
xlabel('Recall');
ylabel('Precision');
% ttt=title(['Precision-recall curve, ', dataFolder]);
% ttt=title([dataFolder]);
% set(ttt,'Interpreter','none');
% title('Synthetic data, scaling factor 0.05');
% title('Synthetic data, scaling factor 0.03');
title('Synthetic data, scaling factor 0.01');

% outfile = strcat('./output_synthetic_test/prec_recall/', 'precision_recall_', dataFolder, '.eps');
% print('-depsc', outfile);