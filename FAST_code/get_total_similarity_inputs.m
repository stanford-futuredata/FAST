% Get each single-channel similarity matrix in simData
function [simData, baseDir, outFolder, paramStr, nfp, dt, thresh] = get_total_similarity_inputs()

    time = tic;

%     %%% NCSN_CCOB_3comp_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr'};
%     inp.windowDuration = 10.0;
%     inp.windowLag = 0.1;
%     inp.fingerprintLength = 100;
%     inp.fingerprintLag = 10;
% %     inp.t_value = 200;
% %     inp.t_value = 400;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 86381;
%     dt = simData(1).dt_fp;
%     thresh = 0.05;
    
%     %%% NCSN_Calaveras_7ch_24hr
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr';
%     inp.channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%         'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%         'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
%     inp.windowDuration = 10.0;
%     inp.windowLag = 0.1;
%     inp.fingerprintLength = 100;
%     inp.fingerprintLag = 10;
% %     inp.t_value = 200;
% %     inp.t_value = 400;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 86381;
%     dt = simData(1).dt_fp;
%     thresh = 0.04;

%     %%% NCSN_Calaveras_7ch_1wk
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_NCSN_Calaveras_7ch_1wk';
%     inp.channelFolders = {'NCSN_CCOB_EHE_1wk', 'NCSN_CCOB_EHN_1wk', ...
%         'NCSN_CCOB_EHZ_1wk', 'NCSN_CADB_EHZ_1wk', 'NCSN_CAO_EHZ_1wk', ...
%         'NCSN_CHR_EHZ_1wk', 'NCSN_CML_EHZ_1wk'};
%     inp.windowDuration = 10.0;
%     inp.windowLag = 0.1;
%     inp.fingerprintLength = 100;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 604781;
%     dt = simData(1).dt_fp;
%     thresh = 0.04;

%     %%% HRSN_CCRB_3comp_20060509_24hr
%     baseDir = '../data/';
%     inp.channelFolders = {'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
% % % %     inp.fingerprintLength = 128;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
% % % %     inp.t_value = 400;
%     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172776;
%     dt = simData(1).dt_fp;
%     thresh = 0.08;

%     %%% HRSN_21ch_20060509_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', ...
%         'HRSN_GHIB_BP1_20060509_24hr', 'HRSN_JCNB_BP1_20060509_24hr', 'HRSN_JCNB_BP2_20060509_24hr', ...
%         'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%         'HRSN_SCYB_BP1_20060509_24hr', 'HRSN_SCYB_BP2_20060509_24hr', 'HRSN_SCYB_BP3_20060509_24hr', ...
%         'HRSN_VCAB_BP1_20060509_24hr', 'HRSN_VCAB_BP2_20060509_24hr', 'HRSN_VCAB_BP3_20060509_24hr', ...
%         'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_VARB_BP3_20060509_24hr', ...
%         'HRSN_MMNB_BP3_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.2;

%     %%% HRSN_15ch_20060509_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', ...
%         'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%         'HRSN_SCYB_BP1_20060509_24hr', 'HRSN_SCYB_BP2_20060509_24hr', 'HRSN_SCYB_BP3_20060509_24hr', ...
%         'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_JCNB_BP3_20060509_24hr', ...
%         'HRSN_MMNB_BP3_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.1;

%     %%% HRSN_12ch_20060509_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', 'HRSN_SCYB_BP1_20060509_24hr', ...
%         'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%         'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_JCNB_BP3_20060509_24hr', ...
%         'HRSN_SCYB_BP3_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
% %     inp.t_value = 200;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.1;

%     %%% HRSN_27ch_20071026_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_GHIB_BP1_20071026_24hr', 'HRSN_JCSB_BP1_20071026_24hr', 'HRSN_GHIB_BP3_20071026_24hr', ...
%         'HRSN_EADB_BP1_20071026_24hr', 'HRSN_EADB_BP2_20071026_24hr', 'HRSN_EADB_BP3_20071026_24hr', ...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_FROB_BP2_20071026_24hr', 'HRSN_FROB_BP3_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', ...
%         'HRSN_VCAB_BP1_20071026_24hr', 'HRSN_VCAB_BP2_20071026_24hr', 'HRSN_VCAB_BP3_20071026_24hr', ...
%         'HRSN_LCCB_BP1_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', 'HRSN_LCCB_BP3_20071026_24hr', ...
%         'HRSN_CCRB_BP1_20071026_24hr', 'HRSN_CCRB_BP2_20071026_24hr', 'HRSN_CCRB_BP3_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.2;

%     %%% HRSN_18ch_20071026_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_JCSB_BP2_20071026_24hr', 'HRSN_FROB_BP3_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', ...
%         'HRSN_VCAB_BP1_20071026_24hr', 'HRSN_VCAB_BP2_20071026_24hr', 'HRSN_VCAB_BP3_20071026_24hr', ...
%         'HRSN_LCCB_BP1_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', 'HRSN_LCCB_BP3_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.1;

%     %%% HRSN_12ch_20071026_24hr
%     baseDir = '../data/haar_coefficients/';
%     inp.channelFolders = {...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_JCSB_BP2_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
% %     inp.t_value = 200;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     fileNameStr = strcat('detdata_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes), '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 172782;
%     dt = simData(1).dt_fp;
%     thresh = 0.1;

%     %%% Autocorrelation NCSN_CCOB_3comp_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2011.008.00.00.00.deci5.24hr.NC.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 3;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', 'CCOB.EHZ.D.SAC.bp4to10'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 1.0627;
% %     thresh = 1.025;
% %     thresh = 0.6;

%     %%% WHAR_20101101_3ch_01hr
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20101101_3ch_01hr';
%     inp.channelFolders = {'WHAR_HHE_20101101_01hr', 'WHAR_HHN_20101101_01hr', ...
%         'WHAR_HHZ_20101101_01hr'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
% %     inp.fingerprintLength = 100;
%     inp.fingerprintLength = 64;
% %     inp.fingerprintLength = 32;
%     inp.fingerprintLag = 10;
% %     inp.fingerprintLag = 5;
%     inp.t_value = 800;
% %     inp.t_value = 400;
% %     inp.t_value = 200;
%     inp.settings.nfuncs = 5;
% %     inp.settings.nfuncs = 6;
% %     inp.settings.nfuncs = 4;
%     inp.settings.ntbls = 100;
% %     inp.settings.ntbls = 500;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 11981;
% %     nfp = 23961; % inp.fingerprintLag = 5;
%     dt = simData(1).dt_fp;
%     thresh = 0.04;
% %     thresh = 0.008;

%     %%% WHAR_20101101_3ch_24hr
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20101101_3ch_24hr';
%     inp.channelFolders = {'WHAR_HHE_20101101_24hr', 'WHAR_HHN_20101101_24hr', ...
%         'WHAR_HHZ_20101101_24hr'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 287984;
%     dt = simData(1).dt_fp;
%     thresh = 0.15;

%     %%% WHAR_20100701_3ch_1wk
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20100701_3ch_1wk';
%     inp.channelFolders = {'WHAR_HHE_20100701_1wk', 'WHAR_HHN_20100701_1wk', ...
%         'WHAR_HHZ_20100701_1wk'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 6;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 2015984;
%     dt = simData(1).dt_fp;
%     thresh = 0.15;

%     %%% WHAR_20100701_3ch_2wk
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20100701_3ch_2wk';
%     inp.channelFolders = {'WHAR_HHE_20100701_2wk', 'WHAR_HHN_20100701_2wk', ...
%         'WHAR_HHZ_20100701_2wk'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 6;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 4031984;
%     dt = simData(1).dt_fp;
%     thresh = 0.15;
    
%     %%% WHAR_20100701_3ch_1month
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20100701_3ch_1month';
%     inp.channelFolders = {'WHAR_HHE_20100701_1month', 'WHAR_HHN_20100701_1month', ...
%         'WHAR_HHZ_20100701_1month'};
% %     outFolder = 'totalMatrix_WHAR_20100601_3ch_1month';
% %     inp.channelFolders = {'WHAR_HHE_20100601_1month', 'WHAR_HHN_20100601_1month', ...
% %         'WHAR_HHZ_20100601_1month'};
% %     outFolder = 'totalMatrix_WHAR_20100801_3ch_1month';
% %     inp.channelFolders = {'WHAR_HHE_20100801_1month', 'WHAR_HHN_20100801_1month', ...
% %         'WHAR_HHZ_20100801_1month'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 8;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = simData(1).nfp;
%     dt = simData(1).dt_fp;
%     thresh = 0.15;
    
    %%% WHAR_20100601_3ch_3month
    baseDir = '../data/haar_coefficients/';
    outFolder = 'totalMatrix_WHAR_20100601_3ch_3month';
    inp.channelFolders = {'WHAR_HHE_20100601_3month', 'WHAR_HHN_20100601_3month', ...
        'WHAR_HHZ_20100601_3month'};
    inp.windowDuration = 3.0;
    inp.windowLag = 0.03;
    inp.fingerprintLength = 64;
    inp.fingerprintLag = 10;
    inp.t_value = 800;
    inp.settings.nfuncs = 8;
    inp.settings.ntbls = 100;
    inp.settings.nvotes = 4;
    paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
        num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
        '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
        '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
        '_nvotes', num2str(inp.settings.nvotes));
    fileNameStr = strcat('detdata', paramStr, '.mat');
    for k=1:length(inp.channelFolders)
        currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
        simData(k) = load(currentFilePath);
    end
    nfp = simData(1).nfp;
    dt = simData(1).dt_fp;
    thresh = 0.15;
    
%     %%% WHAR_20101101_3ch_24hr
%     baseDir = '../data/haar_coefficients/';
%     outFolder = 'totalMatrix_WHAR_20101101_3ch_24hr';
%     inp.channelFolders = {'WHAR_HHE_20101101_24hr', 'WHAR_HHN_20101101_24hr', ...
%         'WHAR_HHZ_20101101_24hr'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 100;
%     inp.fingerprintLag = 10;
% %     inp.t_value = 800;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     paramStr = strcat('_wLen', num2str(inp.windowDuration), '_wLag', ...
%         num2str(inp.windowLag), '_fpLen', num2str(inp.fingerprintLength), ...
%         '_fpLag', num2str(inp.fingerprintLag), '_tvalue', num2str(inp.t_value), ...
%         '_nfuncs', num2str(inp.settings.nfuncs), '_ntbls', num2str(inp.settings.ntbls), ...
%         '_nvotes', num2str(inp.settings.nvotes));
%     fileNameStr = strcat('detdata', paramStr, '.mat');
%     for k=1:length(inp.channelFolders)
%         currentFilePath = strcat(baseDir, inp.channelFolders{k}, '/', fileNameStr);
%         simData(k) = load(currentFilePath);
%     end
%     nfp = 287981;
%     dt = simData(1).dt_fp;
% %     thresh = 0.04;
%     thresh = 0.1;
% %     thresh = 0.2;

%     %%% Autocorrelation NCSN_Calaveras_7ch_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2011.008.00.00.00.deci5.24hr.NC.';
%     baseStr = strcat(baseDir, baseFileStr);
% %     sigmaVal = 3.5;
%     sigmaVal = 3;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', ...
%         'CCOB.EHZ.D.SAC.bp4to10', 'CADB.EHZ.D.SAC.bp2to10', ...
%         'CAO.EHZ.D.SAC.bp2to10', 'CHR.EHZ.D.SAC.bp2to10', 'CML.EHZ.D.SAC.bp2to6'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 1.0627;

%     %%% Autocorrelation NCSN_Calaveras_7ch_1wk
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     outFolder = '.';
%     baseFileStr = '1week.2011.008.00.00.00.0000.deci5.NC.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 4;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'CCOB..EHE.D.SAC.bp4to10', 'CCOB..EHN.D.SAC.bp4to10', ...
%         'CCOB..EHZ.D.SAC.bp4to10', 'CADB..EHZ.D.SAC.bp2to10', ...
%         'CAO..EHZ.D.SAC.bp2to10', 'CHR..EHZ.D.SAC.bp2to10', 'CML..EHZ.D.SAC.bp2to6'};
%     paramStr = strcat('_sigma', num2str(sigmaVal));
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 1.0627;

%     %%% Autocorrelation HRSN_CCRB_3comp_20060509_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2006.129.00.00.00.0276.BP.';
%     baseStr = strcat(baseDir, baseFileStr);
% % % %     sigmaVal = 3.5;
%     sigmaVal = 4;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'CCRB..BP1.Q.SAC.bp2to8', 'CCRB..BP2.Q.SAC.bp2to8', 'CCRB..BP3.Q.SAC.bp2to8'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 0.36;

%     %%% Autocorrelation HRSN_21ch_20060509_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2006.129.00.00.00.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'0276.BP.CCRB..BP1.Q.SAC.bp2to8', '0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', ...
%         '0039.BP.GHIB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP2.Q.SAC.bp2to8', ...
%         '0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8', ...
%         '0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP2.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', ...
%         '0176.BP.MMNB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8', '0070.BP.SMNB..BP3.Q.SAC.bp2to8', ...
%         '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8', '0336.BP.VARB..BP3.Q.SAC.bp2to8', ...
%         '0090.BP.VCAB..BP1.Q.SAC.bp2to8', '0090.BP.VCAB..BP2.Q.SAC.bp2to8', '0090.BP.VCAB..BP3.Q.SAC.bp2to8'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 0.3;

%     %%% Autocorrelation HRSN_12ch_20060509_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2006.129.00.00.00.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
%     channelStr = {'0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', '0377.BP.JCNB..BP3.Q.SAC.bp2to8', ...
%         '0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8', ...
%         '0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8', ...
%         '0070.BP.SMNB..BP3.Q.SAC.bp2to8', '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 0.1;
    
    disp(['get_total_similarity_inputs took: ' num2str(toc(time))]);
end
