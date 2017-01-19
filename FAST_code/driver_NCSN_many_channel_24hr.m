% Driver for NCSN many channel 24 hour data
% See get_fpss_input_parameters.m for input parameters
%
close all
clear

% [mem, u] = logmemory();
% disp(['MEMORY, start: ' num2str(mem) ' ' u]);

% Get FingerPrint / Similarity Search input parameters
inp = get_fpss_input_parameters();

% Loop over multiple channels...
for ifile=1:length(inp.fileNameStr)
    
    disp(['inp.fileNameStr = ', inp.fileNameStr{ifile}]);

% If data directory does not exist, create it
% baseDir = strcat('../data/haar_coefficients/', inp.fileNameStr{ifile},'/');
% baseDir = strcat('/farmshare/user_data/ceyoon/', inp.fileNameStr{ifile},'/');
baseDir = strcat('/lfs/raiders2/0/egan1/', inp.fileNameStr{ifile},'/');
if (7 ~= exist(baseDir, 'dir'))
    disp('Creating data directory');
    mkdir(baseDir);
end

% Create spectrogram directory file name
wStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', num2str(inp.windowLag));
for k=1:length(inp.specFolderStr{ifile})
    inp.specFolderStr{ifile}{k} = strcat(inp.specFolderStr{ifile}{k}, wStr);
end

% If fingerprint file does not exist, create it
specStr = strcat(wStr, '_fpLen', num2str(inp.fingerprintLength), '_fpLag', num2str(inp.fingerprintLag));
fpStr = strcat(specStr, '_tvalue', num2str(inp.t_value));
fpFileName = strcat(baseDir, 'binaryFingerprint', fpStr, '.mat');
if (2 ~= exist(fpFileName, 'file')) % <<<<--------------- binary fingerprint file does not exist

    disp('Creating fingerprint file');
    binaryFingerprint = logical([]);

    % If first partition fingerprint file does not exist, create it
    % Assume if first partition exists, all others exist
    firstFpFileName = strcat(baseDir, 'binaryFp', fpStr, '_part1.mat');
    if (2 ~= exist(firstFpFileName, 'file')) % <<<<--------------- binary fingerprint partition file does not exist

       disp('Creating fingerprint partition file');

       % Assumes that if Haar images for first partition exist,
       % then they exist for all other partitions
       p=1;
       sum_p = [];
       N_p = 0;
       firstHaarFileName = strcat(baseDir, 'normHaarImages', specStr, '_part', num2str(p), '.mat');
       if (2 ~= exist(firstHaarFileName, 'file')) % <<<<--------------- normalized Haar image partition file does not exist

           disp('Creating Haar wavelet transform images');

           % Get seismogram continuous data
           addpath('input_data');
           [t, x, samplingRate] = get_channel_data(inp.fileNameStr{ifile});
           s = size(x);
           nsamples = s(1);
           nch = s(2);

           %%%%%%%%%%%%%%%%%%%%%% SPECTROGRAM %%%%%%%%%%%%%%%%%%%%%%

           % Loop over channels
           for k=1:nch
               % Set up spectrogram settings
               specSettings(k) = setup_spectrogram_settings(nsamples, samplingRate, ...
                      inp.numPartitions, inp.specFolderStr{ifile}{k}, inp.windowDuration, inp.windowLag);

               % If spectrogram does not exist, create and save it
               specDir = strcat(specSettings(k).data.dir, inp.specFolderStr{ifile}{k});
               if (7 ~= exist(specDir, 'dir')) % <<<<--------------- spectrogram directory does not exist
                   disp('Creating partitioned spectrograms');
                   [part, spectrogramRuntime] = pspectrogram(x(:,k), specSettings(k));
                   clear part;
                   disp(['Runtime all partitions, spectrogram: ' num2str(spectrogramRuntime)]);
               end
           end
           clear t x;

           % Initial start offset for first partition, spectral image generation
           startOffset = 0;

           % Length (time samples) of spectrogram overlap section
           noverlap = inp.fingerprintLength-1;

           % Get partition p in this spectrogram
           specHaarRuntime = 0;
           for p=1:inp.numPartitions

               % Output spectral images and wavelet transformed spectral images
               % for this partition
               [normHaarImages, dt_fp, newStartOffset, partRuntime] = output_one_partition(p, startOffset, ...
                   noverlap, nch, inp, specSettings, baseDir, specStr);
               specHaarRuntime = specHaarRuntime + partRuntime;

               % Update sum and number of Haar coefficients
               [sum_p, N_p] = update_sum_number_haar(p, normHaarImages, sum_p, N_p);

               % Update start offset
               startOffset = newStartOffset;
           end
           disp(['Runtime all partitions, spectral image and wavelet transform: ' num2str(specHaarRuntime)]);

       else % <<<<--------------- normalized Haar image partition file already exists
           % Get partition p in this spectrogram
           for p=1:inp.numPartitions

               % Load Haar images from file
               load([baseDir 'normHaarImages' specStr '_part' num2str(p) '.mat']);

               % Update sum and number of Haar coefficients
               [sum_p, N_p] = update_sum_number_haar(p, normHaarImages, sum_p, N_p);
           end
       end

       % Compute mean and standard deviation of each Haar coefficient over entire data set
       time = tic;
       [means, stdevs] = mean_stdev_haar_dataset(inp.numPartitions, baseDir, specStr, sum_p, N_p);
       disp(['Runtime all partitions, compute mean/stdev Haar coefficients, include IO: ' num2str(toc(time))]);

       binaryFpRuntime = 0;
       stdHaarRuntime = 0;
       for p=1:inp.numPartitions
           % Standardize Haar coefficients
           time = tic;
           load([baseDir 'normHaarImages' specStr '_part' num2str(p) '.mat']);
           [normHaarImages] = standardize_haar_coeff(normHaarImages, means, stdevs);
           stdHaarRuntime = stdHaarRuntime + toc(time);

           % Create binary fingerprints
           [binaryFp_p, partRuntime] = get_fingerprints_3component(normHaarImages, inp.t_value); clear normHaarImages;
           binaryFpRuntime = binaryFpRuntime + partRuntime;
           save([baseDir 'binaryFp' fpStr '_part' num2str(p) '.mat'], 'binaryFp_p', 'dt_fp', inp.saveVersion);

           % Concatenate binary fingerprints from each partition to binaryFingerprint
           binaryFingerprint = cat(2, binaryFingerprint, binaryFp_p); clear binaryFp_p;
       end
       disp(['Runtime all partitions, standardize Haar coefficients, include IO: ' num2str(stdHaarRuntime)]);
       disp(['Runtime all partitions, binary fingerprint: ' num2str(binaryFpRuntime)]);

    else % <<<<--------------- binary fingerprint partition file already exists
       for p=1:inp.numPartitions
           load([baseDir 'binaryFp' fpStr '_part' num2str(p) '.mat']);

           % Concatenate binary fingerprints from each partition to binaryFingerprint
           binaryFingerprint = cat(2, binaryFingerprint, binaryFp_p); clear binaryFp_p;
       end
    end

    % Save fingerprints
    save(fpFileName, 'binaryFingerprint', 'dt_fp', inp.saveVersion);

else % <<<<--------------- binary fingerprint file already exists
    % Load fingerprints
    load(fpFileName);
end


% [mem, u] = logmemory();
% disp(['MEMORY, binaryFingerprint: ' num2str(mem) ' ' u]);

%%%%%%%%%%%%%%%%%%%%%%% SIMILARITY SEARCH %%%%%%%%%%%%%%%%%%%%%%

% Check for similar window pairs
nfp = size(binaryFingerprint,2);
disp('Initializing database');
data = similarity_search(binaryFingerprint, nfp, 1, inp.settings, 'initialize');
disp(['Similarity search, min-hash, took: ' num2str(data(1))]);
disp(['Similarity search, populate hash tables, took: ' num2str(data(2))]);
clear binaryFingerprint;

% [mem, u] = logmemory();
% disp(['MEMORY, initialize database: ' num2str(mem) ' ' u]);

disp('Searching database');
detdata = similarity_search([], nfp, 1:nfp, inp.settings, 'search');
disp(detdata.times);

% [mem, u] = logmemory();
% disp(['MEMORY, similarity search: ' num2str(mem) ' ' u]);

% For plotting only
flag_plot_detections = 1;
if (flag_plot_detections)
    plot_thresh = 0.05;
    list = find(detdata.pair_k > plot_thresh);
    plot_detection_indices(detdata.pair_i(list), detdata.pair_j(list), detdata.pair_k(list), dt_fp, ...
        inp.fileNameStr{ifile}, 'Fraction of tables found')
    out_dir = './';
    outfile = [out_dir inp.fileNameStr{ifile} '_fpss_detections.png'];
    print('-dpng', outfile);
end

flag_plot_bucket_data = 0;
if (flag_plot_bucket_data)
    figure; set(gca,'FontSize',16);
    stem(nfp./double(detdata.num_buckets));
    xlabel('Hash table'); ylabel('Number of fingerprints in hash bucket');
    title('Desired number of fingerprints per hash bucket');
    outfile = [out_dir inp.fileNameStr{ifile} '_nfuncs' num2str(inp.settings.nfuncs) '_desired_bucket.png'];
    print('-dpng', outfile);
    
    figure; set(gca,'FontSize',16);
    stem(detdata.max_items_bucket);
    xlabel('Hash table'); ylabel('Number of fingerprints in hash bucket');
    title('Maximum number of fingerprints per hash bucket');
    outfile = [out_dir inp.fileNameStr{ifile} '_nfuncs' num2str(inp.settings.nfuncs) '_maximum_bucket.png'];
    print('-dpng', outfile);
end

flag_save_similarity_output = 1;
if (flag_save_similarity_output)
   detStr = strcat(fpStr, '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', ...
       num2str(inp.settings.ntbls), '_nvotes', num2str(inp.settings.nvotes));
   save([baseDir 'detdata' detStr '.mat'], 'detdata', 'dt_fp', 'nfp', inp.saveVersion);
end

disp('Finalizing database');
similarity_search([], nfp, 1, inp.settings, 'finalize');

end
