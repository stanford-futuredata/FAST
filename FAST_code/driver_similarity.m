% Driver to run similarity search with different hash parameters
% Clara Yoon, 2013-06-19

close all

% Experiment 1 - vary number of trials
clear all
nfuncs = 1;
ntbls = 1;
trials = [1 4 10 20 40 60 80 100];
for k = 1:length(trials)
    similarity_search(nfuncs, ntbls, trials(k));
end

% Experiment 2 - vary number of hash functions, 1 hash table
clear all
nfuncs = [1:8];
ntbls = 1;
trials = 20;
for k = 1:length(nfuncs)
    similarity_search(nfuncs(k), ntbls, trials);
end

% Experiment 3 - vary number of hash functions, 10 hash tables
clear all
nfuncs = [1:8];
ntbls = 10;
trials = 20;
for k = 1:length(nfuncs)
    similarity_search(nfuncs(k), ntbls, trials);
end

% Experiment 4 - vary number of hash tables, 1 hash function
clear all
nfuncs = 1;
ntbls = [1 2 4 6 10 20 40 70];
trials = 20;
for k = 1:length(ntbls)
    similarity_search(nfuncs, ntbls(k), trials);
end

% Experiment 5 - vary number of hash tables, 6 hash functions
clear all
nfuncs = 6;
ntbls = [1 2 4 6 10 20 40 70];
trials = 20;
for k = 1:length(ntbls)
    similarity_search(nfuncs, ntbls(k), trials);
end