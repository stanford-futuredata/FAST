close all
clear

% Plot Fraction of Hash Buckets containing pair, vs. Jaccard Similarity

% Data directory
data_dir = '../data/haar_coefficients/NCSN_CCOB_EHN_1wk/';

% Read in fingerprints
load(strcat(data_dir, 'binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat'));

% Read in detection pairs (ALL)
load(strcat(data_dir, 'detdata_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4.mat'));

%------------
% % Eliminate duplicate pairs
% time_window = 21.0;
% detdata = get_autocorr_detections(detdata.pair_i, detdata.pair_j, detdata.pair_k, dt_fp, time_window);
% detdata.pair_i = detdata.cc_i;
% detdata.pair_j = detdata.cc_j;
% detdata.pair_k = detdata.cc;
%------------

% Sort pairs in descending order of search success rate (fraction of hash buckets with pair)
[sortedk, ix] = sort(detdata.pair_k, 'descend');

npairs = numel(detdata.pair_i);
% npairs = 60000;
search_succ_frac = zeros(npairs,1);
jaccard_sim_fp = zeros(npairs,1);

for k=1:npairs
    ind1 = detdata.pair_i(ix(k))+1;
    ind2 = detdata.pair_j(ix(k))+1;
    jaccard_sim_fp(k) = jaccard(binaryFingerprint(:,ind1), binaryFingerprint(:,ind2));
    search_succ_frac(k) = sortedk(k);
end

FigHandle = figure('Position',[300 300 800 800]);
set(gca,'FontSize',16);
plot(jaccard_sim_fp, search_succ_frac, 'bo');
xlim([0 1]);
ylim([0 0.7]);
xlabel('Jaccard similarity from fingerprints');
ylabel('FAST similarity: fraction of tables containing pair in same bucket');
title('CCOB.EHN 1 week data: FAST vs. Jaccard similarity');

jsim = [0:0.001:1]; % possible Jaccard similarity
thresh_FAST = 0.19; % detection threshold for search success rate
hold on
plot(jsim, thresh_FAST*ones(size(jsim)), 'k-.');
hold off
