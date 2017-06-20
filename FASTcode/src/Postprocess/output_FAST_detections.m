% output_FAST_detections.m
%
% Header: parameter string for file names
% Output a list of detections from Fingerprint And Similarity Thresholding, in ascending time order:
%  Time   Similarity Value
%  85.0   0.17
%  169.0  0.17
%  449.0  0.15
%  541.0  1.41
%
% Multichannel:  call this after combine_similarity_results.m
%

close all
clear

%------------------------input section------------------------------%

% Read in Fingerprint And Similarity Thresholding outputs

flag_output_pairs = 1; % flag to output pairs after removing duplicates (useful to compute jaccard similarity)

% --------- EXAMPLE DATA SET, SINGLE CHANNEL --------
flag_multichannel = 0;
baseDir = '../../data/OutputFAST/';
channelFolders = {'NCSN_CCOB_EHN_24hr'};
inp.windowDuration = 10.0;
inp.windowLag = 0.1;
inp.fingerprintLength = 100;
inp.fingerprintLag = 10;
inp.t_value = 800;
inp.settings.nfuncs = 5;
inp.settings.ntbls = 100;
inp.settings.nvotes = 4;
out_thresh = [0.08]; % threshold for writing to output file
time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'NCSN_CCOB_EHN_1wk'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% out_thresh = [0.08]; % threshold for writing to output file
% % out_thresh = [0.19]; % Final threshold for Science Advances paper
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%     'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%     'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% out_thresh = [0.05 0.05 0.05 0.05 0.05 0.05 0.05]; % threshold for writing to output file
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1', 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1', 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04', 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02', 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1', 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1', 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04', 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03', ...
%    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02', 'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% out_thresh = [0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04 0.04]; % threshold for writing to output file
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% % --------- EXAMPLE DATA SET, MULTIPLE CHANNELS --------
% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_NCSN_CCOB_3comp_24hr'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.05]; % threshold from combine_similarity_results
% out_thresh = [0.09]; % threshold for writing to output file
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_NCSN_Calaveras_7ch_24hr'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.04]; % threshold from combine_similarity_results
% out_thresh = [0.04]; % threshold for writing to output file
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_NCSN_Calaveras_7ch_1wk'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.04]; % threshold from combine_similarity_results
% out_thresh = [0.04]; % threshold for writing to output file
% time_window = 21.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% % channelFolders = {'totalMatrix_HRSN_12ch_20060509_24hr'};
% channelFolders = {'totalMatrix_HRSN_12ch_20071026_24hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.2]; % threshold for writing to output file
% time_window = 5.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% % channelFolders = {'totalMatrix_HRSN_15ch_20060509_24hr'};
% channelFolders = {'totalMatrix_HRSN_18ch_20071026_24hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.3]; % threshold for writing to output file
% time_window = 5.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% channelFolders = {'totalMatrix_HRSN_21ch_20060509_24hr'};
% % channelFolders = {'totalMatrix_HRSN_28ch_20071026_24hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.2]; % threshold from combine_similarity_results
% out_thresh = [0.5]; % threshold for writing to output file
% time_window = 5.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% % channelFolders = {'totalMatrix_HRSN_36ch_20060509_24hr'};
% channelFolders = {'totalMatrix_HRSN_39ch_20071026_24hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.3]; % threshold from combine_similarity_results
% out_thresh = [0.9]; % threshold for writing to output file
% time_window = 5.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20101101_3ch_01hr'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% % inp.fingerprintLength = 100;
% inp.fingerprintLength = 64;
% % inp.fingerprintLength = 32;
% inp.fingerprintLag = 10;
% % inp.fingerprintLag = 5;
% inp.t_value = 800;
% % inp.t_value = 400;
% % inp.t_value = 200;
% inp.settings.nfuncs = 5;
% % inp.settings.nfuncs = 6;
% % inp.settings.nfuncs = 4;
% inp.settings.ntbls = 100;
% % inp.settings.ntbls = 500;
% inp.settings.nvotes = 2;
% in_thresh = [0.04]; % threshold from combine_similarity_results
% out_thresh = [0.06]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20101101_3ch_24hr'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100701_3ch_1wk'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100701_3ch_2wk'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100701_3ch_1month'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100801_3ch_1month'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100601_3ch_1month'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.15]; % threshold from combine_similarity_results
% out_thresh = [0.3]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelFolders = {'totalMatrix_WHAR_20100601_3ch_3month'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% in_thresh = [0.25]; % threshold from combine_similarity_results
% out_thresh = [0.25]; % threshold for writing to output file
% % out_thresh = [0.33]; % threshold for writing to output file
% time_window = 4.0; % detection times within this time window (s) are removed as duplicates

% flag_multichannel = 1;
% baseDir = '/data/beroza/ceyoon/FASTcode/data/OutputFAST/';
% channelFolders = {'totalMatrix_CI_HectorMine_9ch_20hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.2;
% inp.fingerprintLength = 32;
% inp.fingerprintLag = 5;
% inp.t_value = 400;
% % inp.windowLag = 0.1;
% % inp.fingerprintLength = 64;
% % inp.fingerprintLag = 10;
% % inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.1]; % threshold from combine_similarity_results
% % out_thresh = [0.14]; % threshold for writing to output file
% out_thresh = [0.29]; % threshold for writing to output file
% time_window = 12;

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% % channelFolders = {'totalMatrix_IG_PNIG_10to11day_3ch_24hr_Filter3to20'};
% % channelFolders = {'totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to20'};
% % channelFolders = {'totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to20'};
% % channelFolders = {'totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to30'};
% % channelFolders = {'totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to30'};
% channelFolders = {'totalMatrix_IG_PNIG_15days_3ch_Filter3to20'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.2;
% inp.fingerprintLength = 128;
% inp.fingerprintLag = 10;
% inp.t_value = 1600;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% in_thresh = [0.06]; % threshold from combine_similarity_results
% out_thresh = [0.08]; % threshold for writing to output file
% time_window = 25;

%-----------------End of input section------------------------------%

paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
    num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
    '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
    '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
    '_nvotes', num2str(inp.settings.nvotes));

if (flag_multichannel)
   inDataStr = strcat('fast', paramStr, '_thresh', num2str(in_thresh(1)), '.mat');
else
   inDataStr = strcat('detdata', paramStr, '.mat');
end

epsilon = 1.0e-5;
for k=1:length(channelFolders)

    actual_thresh(k) = out_thresh(k) - epsilon; % prevent roundoff error - ensure all events above threshold are output to file
    currentFilePath = strcat(baseDir, channelFolders{k}, '/', inDataStr);
    load(currentFilePath);
    if (flag_multichannel)
       totalPairs.i = uint32(totalPairs.i);
       totalPairs.j = uint32(totalPairs.j);
       totalPairs.k = single(totalPairs.k);
    else
       totalPairs.i = uint32(detdata.pair_i);
       totalPairs.j = uint32(detdata.pair_j);
       totalPairs.k = single(detdata.pair_k);
       dt = dt_fp;
    end
    disp(['Output FAST detections: Processing channel ' channelFolders(k)]);
    
    % Eliminate duplicate pairs
    skip_samples = round(time_window/dt);
    tic;
%    topdata = remove_duplicates(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), skip_samples); % slow MATLAB version
    [topdata.cc_i, topdata.cc_j, topdata.cc] = mxRemoveDuplicatePairs(...
        totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), skip_samples);
    disp(['Eliminate duplicate pairs C++ took: ', num2str(toc)]);
    clear totalPairs;
%     view_detection_indices(1:40, topdata.cc_i, topdata.cc_j, topdata.cc, dt);

    if (flag_output_pairs)
        outfilepairs = strcat('pairs', paramStr, '_timewin', num2str(time_window), '_thresh', num2str(out_thresh(k)), '.mat');
        outpairspath = strcat(baseDir, channelFolders{k}, '/', outfilepairs);
        save(outpairspath, 'topdata', 'dt', 'time_window', 'out_thresh', '-v7.3');
    end

    % Get list of detections, remove duplicate events in the process
    tic;
    [detection_out] = make_detection_list(topdata, actual_thresh(k), skip_samples)
    disp(['Make detection list without duplicate events took: ', num2str(toc)]);
    det_times = (double(detection_out{1})*dt); % times (s)
    det_sim = (detection_out{2}); % similarity values

    % Output FAST detections to text file
    C = [det_times det_sim];
    outfilename = strcat('fast', paramStr, '_timewin', num2str(time_window), '_thresh', num2str(out_thresh(k)), '.txt');
    outfilepath = strcat(baseDir, channelFolders{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%s\n', paramStr);
    fprintf(fid, '%7.5f %6.5f\n', C');
    fclose(fid);
end
