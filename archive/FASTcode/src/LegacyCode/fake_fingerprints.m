% Create fake fingerprint windows
% Clara Yoon, 2013-06-18
%
% Usage (arguments are optional, defaults are provided):
% fake_fingerprints(N)
%
% N: number of samples in 'time series' data
%
function [NWindows, NWindowLength, Nnonzero, fingerprints] = fake_fingerprints(varargin)

% Get length of 'time series'
if (nargin == 1)
    N = varargin{1};
else
    N = 1000;
end

% Generate uniform distribution of 0's and 1's as 'noise'
% data = logical(randi([0 1], 1, N));
% load('mynoise','data'); % use this so that noise doesn't change every time we run this
data = false(1,N); % no noise

% Insert small section of 1's as 'signal'
% Use only 2 sections for now - keep it simple
%%% Nsections = 2;
%%% insert_begin = randi(N-Nnonzero, 1, Nsections);
Nnonzero = 50;
insert_begin = [200 700];
% insert_begin = [493 916];
% insert_begin = [115 444 676];

Nsections = length(insert_begin);

load('sparse_section', 'sparse_signal');

insert_end = insert_begin + Nnonzero - 1;
for k=1:Nsections
%     data(insert_begin(k):insert_end(k)) = true; % section of all 1's
    data(insert_begin(k):insert_end(k)) = sparse_signal; % sparse signal (14 1's out of 50)
end

% Window parameters
NWindowLength = 100; % number of samples in window
NLagSize = 2; % Number of samples in lag between 2 adjacent windows

% Get number of windows, compute window starting indices
[NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(N, NWindowLength, NLagSize);

% Save fingerprints as overlapping windows in the 'data'
fingerprints = false(NWindowLength, NWindows);
time = tic;
for j=1:NWindows
    fingerprints(:,j) = data(window_start_index(j):window_end_index(j));

    % Add noise (1's) in random locations to fingerprint
    % (for purposes of testing with zero noise fingerprints)
    random_one_index = randi(NWindowLength, 1, 4);
    fingerprints(random_one_index, j) = 1;
end
disp(['fake fingerprint generation took: ' num2str(toc(time))]);