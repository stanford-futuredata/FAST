function [passed] = TestMxSimilaritySearch()

% Unit test for mxSimilaritySearch.cpp
% passed = 1 if all tests pass, passed = 0 if any test fails

% Load in input and expected output
load('sigMxMinHash.mat', 'sig');
load('queryMxSimilaritySearch.mat', 'query');
load('resMxSimilaritySearch.mat', 'res');
load('indMxSimilaritySearch.mat', 'ind');

% Use same input parameters from results generation
ntbls = 46;
nfuncs = 4;
near_repeats = 5;

% Run mxSimilaritySearch
path(path,'~/Documents/research/similarity_search');
[run_res, run_ind, out_time, num_fp_per_bucket] = mxSimilaritySearch(...
    sig,query,ntbls,nfuncs,near_repeats);

% Check dimensions
passed = logical(1);
passed = passed & (length(ind) == length(run_ind));
passed = passed & (length(res) == length(run_res));

% Check that expected and generated outputs match
diff_res = run_res - res;
diff_ind = run_ind - ind;
passed = passed & (sum(diff_res(:) == 0));
passed = passed & (sum(diff_ind(:) == 0));

% Check metric - number of fingerprints in each bucket
passed = passed & (length(num_fp_per_bucket) == 3739);

end

