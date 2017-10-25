% output_multichannel_fpss_detections.m
%
% Header: parameter string for file names
% Output a list of detections from fingerprint/similarity search, in ascending time order:
%  Time   Similarity Value
%  85.0   0.17
%  169.0  0.17
%  449.0  0.15
%  541.0  1.41
%
% Call this after calling combine_similarity_results.m

close all
clear

%------------------------input section------------------------------%

% Read in fingerprint/similarity search outputs
baseDir = '../data/haar_coefficients/';

% channelFolders = {'totalMatrix_NCSN_Calaveras_7ch_24hr'};
% % channelFolders = {'totalMatrix_NCSN_CCOB_3comp_24hr'};
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% % inp.t_value = 1400;
% % inp.t_value = 600;
% % inp.t_value = 1200;
% % inp.t_value = 2800;
% % inp.t_value = 2400;
% % inp.t_value = 5600;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% dt = 1.0;
% time_window = 21;
% in_thresh = [0.04];
% out_thresh = in_thresh;

% % channelFolders = {'totalMatrix_HRSN_21ch_20060509_24hr'};
% % channelFolders = {'totalMatrix_HRSN_27ch_20071026_24hr'};
% % channelFolders = {'totalMatrix_HRSN_15ch_20060509_24hr'};
% channelFolders = {'totalMatrix_HRSN_12ch_20060509_24hr'};
% % channelFolders = {'totalMatrix_HRSN_18ch_20071026_24hr'};
% % channelFolders = {'totalMatrix_HRSN_12ch_20071026_24hr'};
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% % inp.t_value = 200;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% dt = 0.5;
% time_window = 5;
% % in_thresh = [0.2];
% in_thresh = [0.1];
% out_thresh = in_thresh;

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
% time_window = 3;
% % time_window = 6;

% in_thresh = [0.008];
% out_thresh = [0.02];

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
% % out_thresh = [0.2]; % threshold for writing to output file
% out_thresh = [0.15]; % threshold for writing to output file
% % time_window = 3;
% time_window = 4;

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
% % out_thresh = [0.2]; % threshold for writing to output file
% out_thresh = [0.15]; % threshold for writing to output file
% time_window = 3;
% % time_window = 4;

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
% % out_thresh = [0.2]; % threshold for writing to output file
% out_thresh = [0.15]; % threshold for writing to output file
% % time_window = 3;
% time_window = 4;

% channelFolders = {'totalMatrix_WHAR_20100701_3ch_1month'};
% channelFolders = {'totalMatrix_WHAR_20100801_3ch_1month'};
% channelFolders = {'totalMatrix_WHAR_20100601_3ch_1month'};
% channelFolders = {'totalMatrix_WHAR_20100601_3ch_3month'};
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% % in_thresh = [0.15]; % threshold from combine_similarity_results
% % in_thresh = [0.3];
% in_thresh = [0.25];
% out_thresh = [0.25]; % threshold for writing to output file
% % out_thresh = [0.15]; % threshold for writing to output file
% % out_thresh = [0.3];
% % time_window = 3;
% time_window = 4;

channelFolders = {'totalMatrix_CI_HectorMine_9ch_20hr'};
inp.windowDuration = 6.0;
inp.windowLag = 0.2;
inp.fingerprintLength = 32;
inp.fingerprintLag = 5;
inp.t_value = 400;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
inp.settings.nfuncs = 5;
inp.settings.ntbls = 100;
inp.settings.nvotes = 2;
in_thresh = [0.1]; % threshold from combine_similarity_results
% out_thresh = [0.2]; % threshold for writing to output file
% out_thresh = [0.18]; % threshold for writing to output file
% out_thresh = [0.14]; % threshold for writing to output file
out_thresh = [0.25]; % threshold for writing to output file
% out_thresh = [0.1]; % threshold for writing to output file
time_window = 12;



paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
    num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
    '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
    '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
    '_nvotes', num2str(inp.settings.nvotes));
inDataStr = {strcat('fpss', paramStr, '_thresh', num2str(in_thresh(1)), '.mat')};

%-----------------End of input section------------------------------%

for k=1:length(channelFolders)
    disp(['Output FPSS detections: Processing channel ' channelFolders(k)]);
    
    currentFilePath = strcat(baseDir, channelFolders{k}, '/', inDataStr);
    load(currentFilePath{1});
    
    % Eliminate duplicate pairs
    tic;
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt, time_window);
    disp(['Eliminate duplicate pairs took: ', num2str(toc)]);
%     view_detection_indices(1:40, topdata.cc_i, topdata.cc_j, topdata.cc, dt);

    % Get list of detections
    tic;
    [detection_out] = make_detection_list(topdata, out_thresh(k), dt, time_window);
    disp(['Make detection list without duplicate events took: ', num2str(toc)]);
    det_times = (double(detection_out{1})*dt); % times (s)
    det_sim = (detection_out{2}); % similarity values

    % Output FPSS detections to text file
    C = [det_times det_sim];
    outfilename = strcat('fpss', paramStr, '_timewin', num2str(time_window), '_thresh', num2str(out_thresh(k)), '.txt');
    outfilepath = strcat(baseDir, channelFolders{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%s\n', paramStr);
    fprintf(fid, '%7.5f %6.5f\n', C');
    fclose(fid);
end

