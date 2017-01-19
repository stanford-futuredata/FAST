close all
clear

% Plot histogram of similar pairs (count vs. similarity)

% Data directory
data_dir = '../data/haar_coefficients/NCSN_CCOB_EHN_1wk/';

% Read in detection pairs (ALL)
load(strcat(data_dir, 'detdata_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4.mat'));

% Read in Jaccard similarity of fingerprint pairs, in descending order of FAST similarity
% (originally from plot_FAST_similarity_vs_jaccard_similarity.m)
load(strcat(data_dir, 'jaccard_sim_fingerprints.mat'));

% Compute number of pairs not computed
nfp = 604781;
num_total_pairs = nfp*(nfp-1)/2;
num_computed_pairs = numel(jaccard_sim_fp);
num_ignore_pairs = num_total_pairs - num_computed_pairs;

% Plot histogram of fraction of hash tables
bins = [0:0.04:0.68];
FigHandle = figure('Position',[1300 300 800 600]);
yy=hist(detdata.pair_k, bins);
% counts = hist(detdata.pair_k, bins);
% bar(counts ./ sum(counts));

bar(bins, yy, 1);

% ph=get(gca,'children');
% N = length(ph);
% for ii=1:N
%     vn=get(ph(ii),'Vertices');
%     vn(:,2) = vn(:,2)+1;
%     set(ph(ii),'Vertices',vn);
% end
set(gca,'yscale','log');

set(gca,'FontSize',16);
% xlim([-0.05 1.35]);
xlim([0 0.7]);
xlabel('Similarity: Fraction of hash tables with fingerprint pair');
ylabel('Count');
title('Histogram of similar fingerprint pairs from FAST');

% Plot pairs above detection threshold in different color
thresh = 0.19;
det_index = find(bins > thresh);
hold on
bar(bins(det_index:end), yy(det_index:end), 1, 'FaceColor', [0,1,0]);
hold off

% Add histogram bar for pairs not computed
zz = zeros(size(yy));
zz(2) = num_ignore_pairs;
hold on
bar(bins, zz, 1, 'FaceColor',[1,0,0]);
hold off

legend('Candidate Pairs', 'Detected Pairs', 'Total Pairs');


% Plot histogram of Jaccard similarity of fingerprints
jac_bins = [0:0.04:1];
FigHandle = figure('Position',[1400 400 800 600]);
hist(jaccard_sim_fp, jac_bins);

ph=get(gca,'children');
N = length(ph);
for ii=1:N
    vn=get(ph(ii),'Vertices');
    vn(:,2) = vn(:,2)+1;
    set(ph(ii),'Vertices',vn);
end
set(gca,'yscale','log');

set(gca,'FontSize',16);
xlim([0 1]);
xlabel('Jaccard Similarity of Fingerprint Pairs');
ylabel('Count');
title('Histogram of similar fingerprint pairs, CCOB.EHN 1 week');