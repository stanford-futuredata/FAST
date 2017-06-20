close all
clear

addpath('../Postprocess/');

%---------------------------INPUTS----------------------------------

baseDir = '../../data/OutputFAST/';

% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05'; % Used in Science Advances paper
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03'; % Used in Science Advances paper
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02';
dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'; % Used in Science Advances paper
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02';
% dataFolder = 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01';
autocorrFile = 'autocorr_timewin21_thresh0.5.txt';
fastFile = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.04.txt';
% fast.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.12 0.14 0.16 0.18 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.68 0.7 0.8 0.9 1];

% % 24-36, 0.05
% fast.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.7];
% scale_factor = 0.05;

% % 24-36, 0.03
% fast.thresh = [0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.15 0.18 0.2];
% ac.thresh = [0.5 0.52 0.54 0.56 0.58 0.6 0.62 0.64 0.66 0.7 0.8 0.82];
% scale_factor = 0.03;

% 24-36, 0.01
fast.thresh = [0.04 0.05 0.06 0.07 0.08 0.1 0.12 0.15 0.18];
ac.thresh = [0.5 0.52 0.54 0.58 0.62];
scale_factor = 0.01;

%---------------------------SETUP----------------------------------

catTimes = [900:1800:42300]; % 'ground truth' times for synthetic data
catMag = scale_factor*ones(numel(catTimes));

% Read in autocorrelation file - treat this as ground truth
autocorrPath = strcat(baseDir, dataFolder, '/', autocorrFile);
[ac.times, ac.sim, ac.detflag] = textread(autocorrPath, '%f %f %d');
ac.output_flag = 0; % flag to output autocorrelation vs catalog comparison to file

% Read in fingerprint/similarity search file
fastPath = strcat(baseDir, dataFolder, '/', fastFile);
[fast.paramstr] = textread(fastPath, '%s', 1);
[fast.times, fast.sim] = textread(fastPath, '%f %f', 'headerlines', 1);
fast.output_flag = 0; % flag to output FAST vs catalog comparison to file

match_time_window = 19.0; % matching detections if they fall within this time window (s)

%---------------------------FAST VS AUTOCORRELATION-------------------------

% Compare fast, autocorrelation results against 'ground truth'
[detections] = compare_detections_with_catalog(ac, fast, catTimes, catMag, baseDir, dataFolder, match_time_window);
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

fast.nthresh = length(fast.thresh);
fast.precision = zeros(fast.nthresh,1);
fast.recall = zeros(fast.nthresh,1);
disp('Fingerprint/similarity search detections:');
for k=1:fast.nthresh
    fast.precision(k) = detections.fast(k).match/(detections.fast(k).match + detections.fast(k).new);
    fast.recall(k) = detections.fast(k).match/(detections.fast(k).match + detections.fast(k).missed);
    disp(detections.fast(k))
end
fast.labels = cellstr(num2str(fast.thresh'));

% Plot precision-recall curve
% FigHandle = figure('Position',[300 300 600 600]);
figure
set(gca, 'FontSize', 16);
plot(fast.recall, fast.precision, 'bo', ac.recall, ac.precision, 'ro', 'LineWidth',2)
hold on
plot(fast.recall, fast.precision, 'b', ac.recall, ac.precision, 'r', 'LineWidth',2)
text(fast.recall, fast.precision, fast.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [0,0,1], ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
if (scale_factor < 0.011)
   text(ac.recall, ac.precision, ac.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [1,0,0], ...
       'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
else
   text(ac.recall, ac.precision, ac.labels, 'FontSize', 16, 'FontWeight','bold', 'Color', [1,0,0], ...
       'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
end
hold off
% axis image;
axis([0 1 0 1]);
legend('FAST', 'Autocorrelation', 'Location', 'best');
xlabel('Recall');
ylabel('Precision');
% ttt=title(['Precision-recall curve, ', dataFolder]);
% ttt=title([dataFolder]);
% set(ttt,'Interpreter','none');
title(['Synthetic data, scaling factor ' num2str(scale_factor)]);

% outfile = strcat('./output_synthetic_test/prec_recall/', 'precision_recall_', dataFolder, '.eps');
% print('-depsc', outfile);
