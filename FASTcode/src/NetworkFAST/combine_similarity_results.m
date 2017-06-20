% Script to compute network similarity matrix: multiple channels, multiple stations
close all
clear

addpath('../Utilities/');

% Read in similarity search output from each channel to use for detection
[simData, baseDir, outFolder, paramStr, nfp, dt, thresh, flag_autocorr] = get_total_similarity_inputs();

%%% ------------ Compute total network similarity matrix ------------ %%%

% Concatenate similarity data from each channel
time = tic;
nch = length(simData);
allData.pair_i = simData(1).detdata.pair_i; % uint32
allData.pair_j = simData(1).detdata.pair_j; % uint32
allData.pair_k = simData(1).detdata.pair_k; % single
for k=2:length(simData)
    allData.pair_i = cat(1, allData.pair_i, simData(k).detdata.pair_i);
    allData.pair_j = cat(1, allData.pair_j, simData(k).detdata.pair_j);
    allData.pair_k = cat(1, allData.pair_k, simData(k).detdata.pair_k);
end
allData.pair_k = single(allData.pair_k);
clear simData;
disp(['Similarity data concatenation took: ' num2str(toc(time))]);

[mem, u] = logmemory();
disp(['MEMORY, similarity data all channels: ' num2str(mem) ' ' u]);

% Add similarity data from each channel (mode=0)
[runTime] = mxAddSimilarityMatrix(allData.pair_i, allData.pair_j, allData.pair_k, nfp, thresh, 0);
disp(['Add similarity matrix took: ' num2str(runTime)]);
clear allData;

[mem, u] = logmemory();
disp(['MEMORY, after adding similarity matrix: ' num2str(mem) ' ' u]);

% Threshold total similarity matrix (mode=1)
[runTime, totalPairs.i, totalPairs.j, totalPairs.k] = mxAddSimilarityMatrix([], [], [], nfp, thresh, 1);
disp(['Threshold similarity matrix took: ' num2str(runTime)]);

[mem, u] = logmemory();
disp(['MEMORY, after threshold similarity matrix: ' num2str(mem) ' ' u]);

%%% ------------ Compute total network similarity matrix ------------ %%%

% Output network similarity matrix
output_flag = 1;
if (output_flag)
    startStr = 'fast';
    if (flag_autocorr)
       startStr = 'autocorr';
    end
    outDataStr = strcat(startStr, paramStr, '_thresh', num2str(thresh), '.mat');

    outDir = strcat(baseDir, outFolder);
    if (7 ~= exist(outDir, 'dir'))
        disp('Creating network similarity data directory');
        mkdir(outDir);
    end

    outFilePath = strcat(outDir, '/', outDataStr);
    save(outFilePath, 'totalPairs', 'dt', 'thresh', '-v7.3');
end
