% Timing results - check scaling of min hash
% Clara Yoon, Friday 2013-06-21

% run similarity_search.m with ntrials = 1
% query = uint32([point]'); so compare one window with all other windows

% Inputs to similarity_search.m
nfuncs = 8;
ntbls = 4;
ntrials = 1;
N = [1e3 1e4 1e5 1e6 1e7]; % length of 'data' vector
ntimes = length(N);

NWindowLength = 100; % number of samples in window
NLagSize = 2; % Number of samples in lag between 2 adjacent windows
NWindows = (N - NWindowLength) / NLagSize + 1; % number of windows

% Arrays for run times (s)
t_min_hash = zeros(1,ntimes);
t_populate_tables = zeros(1,ntimes);
t_retrieve_matches = zeros(1,ntimes);
t_linear = zeros(1,ntimes);

% Run similarity_search.m
for k=1:ntimes
    [t_min_hash(k) t_populate_tables(k) t_retrieve_matches(k) t_linear(k)] = ...
        similarity_search(nfuncs, ntbls, ntrials, N(k));
end

figure
set(gca,'FontSize',18)
loglog(NWindows, t_min_hash, '-bo', NWindows, t_populate_tables, '-ro', ...
    NWindows, t_retrieve_matches, '-ko', NWindows, t_linear, '-go')
xlabel('Number of windows')
ylabel('run time (s)')
title(['Similarity search, 1 window query, ' num2str(nfuncs) ...
    ' hash functions, ' num2str(ntbls) ' hash tables'])
legend('Min-hash', 'Populate tables', 'Retrieve matches', 'Linear', ...
    'Location','NorthWest')