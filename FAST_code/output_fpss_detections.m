% output_fpss_detections.m
%
% Header: parameter string for file names
% Output a list of detections from fingerprint/similarity search, in ascending time order:
%  Time   Similarity Value
%  85.0   0.17
%  169.0  0.17
%  449.0  0.15
%  541.0  1.41

close all
clear

%------------------------input section------------------------------%

% Read in fingerprint/similarity search outputs
baseDir = '../data/haar_coefficients/';
% channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%     'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%     'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
% channelFolders = {'NCSN_CCOB_3comp_24hr'};
% channelFolders = {'NCSN_Calaveras_7ch_24hr'};
channelFolders = {'NCSN_CCOB_EHN_1wk'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02'};
% channelFolders = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'};
inp.windowDuration = 10.0;
inp.windowLag = 0.1;
inp.fingerprintLength = 100;
inp.fingerprintLag = 10;
% inp.t_value = 200;
% inp.t_value = 400;
inp.t_value = 800;
% inp.t_value = 600;
% inp.t_value = 1400;
inp.settings.nfuncs = 5;
inp.settings.ntbls = 100;
inp.settings.nvotes = 4;
% inp.settings.nfuncs = 4; % synthetic
% inp.settings.ntbls = 500; % synthetic
% inp.settings.nvotes = 2; % synthetic
paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
    num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
    '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
    '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
    '_nvotes', num2str(inp.settings.nvotes));
fileNameStr = strcat('detdata', paramStr, '.mat');
dt = 1.0;

% FPSS detection threshold
% thresh = [0.2 0.24 0.24 0.21 0.19 0.21 0.39];
% thresh = [0.15];
% thresh = [0.15 0.15 0.15 0.15 0.15 0.15 0.2];
% thresh = [0.06];
% thresh = [0.05 0.05 0.05 0.05 0.05 0.05 0.05];
% thresh = [0.11];
% thresh = [0.08];
% thresh = [0.33]; % old_votesbug

thresh = [0.08];
% thresh = [0.04]; % synthetic
% thresh = [0.03]; % synthetic
time_window = 21.0;

%-----------------End of input section------------------------------%

for k=1:length(channelFolders)
    disp(['Output FPSS detections: Processing channel ' channelFolders(k)]);
    
    currentFilePath = strcat(baseDir, channelFolders{k}, '/', fileNameStr);
    simData(k) = load(currentFilePath);
    
    % Eliminate duplicate pairs
    topdata = get_autocorr_detections(simData(k).detdata.pair_i(:), ...
        simData(k).detdata.pair_j(:), simData(k).detdata.pair_k(:), dt, time_window);

    % Get list of detections
    [detection_out] = make_detection_list(topdata, thresh(k), dt, time_window);
    det_times = (double(detection_out{1})*dt); % times (s)
    det_sim = (detection_out{2}); % similarity values

    % Output FPSS detections to text file
    C = [det_times det_sim];
    outfilename = strcat('fpss', paramStr, '_timewin', num2str(time_window), '_thresh', num2str(thresh(k)), '.txt');
    outfilepath = strcat(baseDir, channelFolders{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%s\n', paramStr);
    fprintf(fid, '%7.5f %6.5f\n', C');
    fclose(fid);
end

