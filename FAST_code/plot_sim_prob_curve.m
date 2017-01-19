close all
clear

jsim = [0:0.001:1]; % possible Jaccard similarity

% Parameters for NCSN_CCOB_EHN_1wk
nhashfuncs = 5;
ntbls = 100;
% nvotes = 4;
nvotes = 19; % actual threshold used

% Parameters for MinHash
% nhashfuncs = 1; ntbls = 1; nvotes = 1;

thresh = (1.0/ntbls)^(1.0/nhashfuncs);


% % Modify number of hash functions
% nhashfuncs = [3 4 5 6];
% ntbls = [100 100 100 100];
% nvotes = [19 19 19 19];

% % Modify number of hash tables
% nhashfuncs = [5 5 5 5];
% ntbls = [25 50 100 200];
% nvotes = [19 19 19 19];

% Modify number of votes
nhashfuncs = [5 5 5 5];
ntbls = [100 100 100 100];
nvotes = [4 10 19 30];


nparam = numel(nhashfuncs);
h = sim_prob_curve(jsim,nhashfuncs,ntbls,nvotes,nparam,'b');
axis image;
% hold on
% % line([thresh, thresh], ylim, 'Color', [0 0 0]);
% % h = sim_prob_curve(jsim,nhashfuncs,ntbls,1,'r');
% plot(jsim, 0.33*ones(size(jsim)), 'k-.');
% hold off

% title('Modify number of hash functions');
% legend('r = 3', 'r = 4', 'r = 5', 'r = 6', 'Location', 'NorthWest');

% title('Modify number of hash tables');
% legend('b = 25', 'b = 50', 'b = 100', 'b = 200', 'Location', 'NorthWest');

title('Modify number of votes');
legend('v = 4', 'v = 10', 'v = 19', 'v = 30', 'Location', 'NorthWest');