% Usage (arguments are optional, defaults are provided):
% similarity_search(nfuncs, ntbls, trials, N)
%
% Inputs
% fingerprints: Binary fingerprints to hash
% dt_fp:        Time spacing between fingerprints (s)
%
% Inputs (optional)
% nfuncs: Number of hash functions (must be between 1 and 8)
% ntbls:  Number of hash tables
% trials: Number of times to repeat the experiment
% nvotes: Number of tables (votes) a pair must be found in
% N:      Number of samples in 'time series' data (only with fake data)
%
% Outputs
% detdata:            Structure containing detection outputs
% detdata.fp_row      Row index (i) of detection
% detdata.fp_col      Column index (j) of detection
% detdata.prob_values Probability (relative) of detection
%
% Outputs (optional)
% t_min_hash:  Min-hash run time (s)
% out_time(1): Similarity search - populate tables run time (s)
% out_time(2): Similarity search - retrieve matches run time (s)
% t_linear:    Linear search run time (s)
% 
function [detdata, varargout] = similarity_search(fingerprints, dt_fp, varargin)

% nfp = 1000;        %Number of fingerprints
% nbits = 4096;       %Number of bits in fingerprint
% NNZ = 200;          %Number of non-zero bits in fingerprint
%Generate demo fingerprint
%This fingerprint is a just a bunch ones that are translated
%one step a time. It is a dummy for a true fingerprint scheme
% time = tic;
% fingerprints = fingerprint_demo(nfp,nbits,NNZ);
% disp(['Generating fingerprints took: ' num2str(toc(time))]);

% Default values for input parameters
default_nfuncs = 4;  %Number of hash functions (must be between 1 and 8)
default_ntbls = 8;   %Number of hash tables
default_trials = 20; %Number of times to repeat the experiment
default_votes = 2;   %Number of tables (votes) a pair must be in
default_N = 1000;    %Length of 'time series' data

% Only want 5 optional inputs at most
if (nargin > 7)
    error('must not have more than 7 input parameters');
end

% Set defaults for optional inputs
optargs = {default_nfuncs default_ntbls default_trials ...
    default_votes default_N};

% Overwrite defaults with optional inputs
optargs(1:nargin-2) = varargin;

% Place optional inputs in variables
[nfuncs, ntbls, trials, nvotes, N] = optargs{:}

% near_repeats = 0;   %Discard matches within the near_repeat range
near_repeats = 5;
point = 275;         %Point to plot probability-similarity curve for

% max_num_matches = 50;  %Estimated maximum number of matches per query
%                        %Used for allocation

%%% Get fake fingerprints (nfp, nbits, NNZ will change)
% % [nfp, nbits, NNZ, fingerprints] = fake_fingerprints(N);
% % nfp   %Number of fingerprints
% % nbits %Number of bits in fingerprint
% % NNZ   %Number of non-zero bits in fingerprint

% [fingerprints, dt_fp] = data_1hr_fingerprint; % plot version
% [fingerprints, dt_fp] = spec_fingerprint; % fast version
% [fingerprints, dt_fp] = time_window_fingerprint;
% [fingerprints, dt_fp] = time_window_fingerprint_uniform; % uniform signal
% [fingerprints, dt_fp] = time_window_wavelet_fingerprint;
s = size(fingerprints);
nbits = s(1) %Number of bits in fingerprint
nfp = s(2)   %Number of fingerprints

%Fingerprints to search for. A complete search could be done by setting
%query = uint32([1:nfp]'); It is very important that uint32() is not left out.
%The uint32() ensures the proper data type needed for mex application. 
query = uint32([1:nfp]'); 
query_ind = point; % index of point in query

% query = uint32([1]'); 
% Important to use just 1 query for timing/scaling tests
% query = uint32([point]'); 
% query_ind = 1; % index of point in query

% detections = zeros(nfp,1);

%We repeat the experiment multiple times to confirm that the implementation
%agrees well with theory. In practice, the experiment should not need to
%be repeated much.
seed = 1e12*rand();

time = tic;  
%Insert Min-Hash signatures into the database and perform similarity search
%query = uint32(1);
% [pair_i, pair_j, pair_k, out_time, num_fp_per_bucket] = ...
% mxSimilaritySearch(fingerprints,ntbls,nfuncs,trials,seed,query,near_repeats);
[pair_i, pair_j, pair_k, out_time, num_fp_per_bucket] = ...
    mxSimilaritySearchV(fingerprints,ntbls,nfuncs,trials,seed,query,near_repeats,nvotes);
disp(['Similarity search took: ' num2str(toc(time))]); 
disp(['Similarity search, min-hash, took: ' num2str(out_time(1))]);
disp(['Similarity search, populate hash tables, took: ' num2str(out_time(2))]);
disp(['Similarity search, retrieve matches, took: ' num2str(out_time(3))]);
size(pair_i)
pair_i = real(pair_i); % 0-index
pair_j = real(pair_j); % 0-index
pair_k = real(pair_k);

flag_plot_num_fp_per_bucket = 1;
if (flag_plot_num_fp_per_bucket)
    % Collect metrics - number of fingerprints in each bucket (first hash table, last trial)
    [sorted_fp_per_bucket, sorted_ind] = sort(num_fp_per_bucket, 'descend');
    'Number of buckets = ', length(sorted_fp_per_bucket)
    percent_fp_per_bucket = (100.0/double(nfp)) * double(sorted_fp_per_bucket);
    
    'Number of counts for all pairs = ', sum(sorted_fp_per_bucket.^2)

    figure
    set(gca,'FontSize',18)
    plot(percent_fp_per_bucket, 'o');
    title(['# fingerprints per bucket, ' num2str(nfuncs) ' hash functions, ' ...
        num2str(nfp) ' total fp'])
    xlabel('Bucket index')
    ylabel('% fingerprints in bucket')
    xlim([0 length(sorted_fp_per_bucket)]);
%     ylim([0 0.5+eps]);
%     max(percent_fp_per_bucket)
end

% flag to plot similarity matrix
flag_plot_similarity = 0;
if (flag_plot_similarity)
    figure
    set(gca,'FontSize',18)
    surf(double(CC_matrix)/trials);
    colorbar
    caxis([0.0 1.0])
    title(['MinHash similarity, ' num2str(nfuncs) ' hash functions, ' ...
        num2str(ntbls) ' hash tables, ', num2str(trials) ' trials'])
    xlabel('Window number')
    ylabel('Window number')
    view(2);
    shading interp
end

% Compute threshold for probability from similarity
% Ch 3 Mining of Massive Datasets, page 71
simThreshold = (1.0/ntbls)^(1.0/nfuncs) % approximate similarity threshold (between 0 and 1)
probThreshold = 1.0 - (1.0 - simThreshold^nfuncs)^ntbls % probability threshold

probThreshold*trials

% fp_row, fp_col have indices of window pairs that are a detection
% magic_factor = 0.25;
magic_factor = 0.2;
% magic_factor = 0.1;
% magic_factor = 0.02; 
list = find(double(pair_k) > (magic_factor*probThreshold*trials*ntbls));
detdata.fp_row = pair_i(list) + 1;
detdata.fp_col = pair_j(list) + 1;
numWindowPairDetections = length(detdata.fp_row);

unique(pair_k)

% Save probabilities for detected window pairs
detdata.prob_values = double(pair_k(list)) / (ntbls*trials);


flag_plot_detections = 1;
if (flag_plot_detections)
    plot_detection_indices(detdata.fp_row, detdata.prob_values, dt_fp, 'Fingerprint, index i rows', ...
        'probability of detection')
    plot_detection_indices(detdata.fp_col, detdata.prob_values, dt_fp, 'Fingerprint, index j columns', ...
        'probability of detection')
end
% return

% We compute the true similarity between one selected fingerprint and 
% all other fingerprint. In other words, we perform a linear search and
% compute the Jaccard similarity.
% indices = 1:nfp; 
% detections = detections(indices);
% k = 1;
% sim = zeros(length(indices),1);
% time = tic;
% for i=indices
%     sim(k) = jaccard(fingerprints(:,i),fingerprints(:,query(query_ind)));
%     k = k + 1;
% end
% t_linear = toc(time);
% disp(['Linear search took: ' num2str(t_linear)]);

% figure
% plot(indices,sim);

%Generate a Similarity-Probability curve
% figure
% h = sim_prob_curve(sim,detections,trials,nfuncs,ntbls,nvotes);

% Get optional output arguments
if (nargout == 5)
    varargout{1} = t_min_hash; % Min-hash run time (s)
    varargout{2} = out_time(1); % Similarity search - populate tables run time (s)
    varargout{3} = out_time(2); % Similarity search - retrieve matches run time (s)
    varargout{4} = t_linear; % Linear search run time (s)
end

end
