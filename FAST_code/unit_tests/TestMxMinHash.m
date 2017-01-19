function [passed] = TestMxMinHash()

% Unit test for mxMinHash.cpp
% passed = 1 if all tests pass, passed = 0 if any test fails

% Load in input and expected output (generated with seed=1e12)
load('fingerprintsMxMinHash.mat', 'fingerprints');
load('sigMxMinHash.mat', 'sig');
sigExpectedDim = size(sig);

% Use same seed so we get same result every time
seed = 1e12;

% Use same input parameters from results generation
ntbls = 46;
nfuncs = 4;

% Run mxMinHash
path(path,'~/Documents/research/similarity_search');
run_sig = mxMinHash(fingerprints,ntbls*nfuncs,seed);
sigActualDim = size(run_sig);

% Check dimensions
passed = logical(1);
passed = passed & (sigExpectedDim(1) == sigActualDim(1));
passed = passed & (sigExpectedDim(2) == sigActualDim(2));

% Check that sig (expected output) and run_sig (generated output) match
diff_sig = run_sig - sig;
passed = passed & (sum(diff_sig(:) == 0));

end

