% Get each single-channel similarity matrix in simData
function [simData, baseDir, outFolder, paramStr, nfp, dt, thresh, flag_autocorr] = get_total_similarity_inputs()

    time = tic;

    %%% ---> totalMatrix_NCSN_CCOB_3comp_24hr - EXAMPLE DATA SET, MULTIPLE CHANNELS ----
    flag_autocorr = 0;
    baseDir = '../../data/OutputFAST/';
    outFolder = 'totalMatrix_NCSN_CCOB_3comp_24hr';
    inp.channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr'};
    inp.windowDuration = 10.0;
    inp.windowLag = 0.1;
    inp.fingerprintLength = 100;
    inp.fingerprintLag = 10;
    inp.t_value = 800;
    inp.settings.nfuncs = 5;
    inp.settings.ntbls = 100;
    inp.settings.nvotes = 2;
    thresh = 0.05; % Network FAST similarity threshold
    
%     %%% ---> totalMatrix_NCSN_Calaveras_7ch_24hr
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr';
%     inp.channelFolders = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%         'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%         'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
%     inp.windowDuration = 10.0;
%     inp.windowLag = 0.1;
%     inp.fingerprintLength = 100;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     thresh = 0.04; % Network FAST similarity threshold

%     %%% ---> totalMatrix_NCSN_Calaveras_7ch_1wk
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
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
%     thresh = 0.04; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_CCRB_3comp_20060509_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_CCRB_3comp_20060509_24hr';
%     inp.channelFolders = {'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.04; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_36ch_20060509_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_36ch_20060509_24hr';
%     inp.channelFolders = {...
%         'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', ...
%         'HRSN_GHIB_BP1_20060509_24hr', 'HRSN_JCNB_BP1_20060509_24hr', 'HRSN_JCNB_BP2_20060509_24hr', ...
%         'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%         'HRSN_SCYB_BP1_20060509_24hr', 'HRSN_SCYB_BP2_20060509_24hr', 'HRSN_SCYB_BP3_20060509_24hr', ...
%         'HRSN_VCAB_BP1_20060509_24hr', 'HRSN_VCAB_BP2_20060509_24hr', 'HRSN_VCAB_BP3_20060509_24hr', ...
%         'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_VARB_BP3_20060509_24hr', ...
%         'HRSN_MMNB_BP3_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr', ...
%         'HRSN_JCNB_BP3_20060509_24hr', 'HRSN_MMNB_BP1_20060509_24hr', 'HRSN_MMNB_BP2_20060509_24hr', ...
%         'HRSN_SMNB_BP1_20060509_24hr', 'HRSN_GHIB_BP2_20060509_24hr', 'HRSN_GHIB_BP3_20060509_24hr', ...
%         'HRSN_FROB_BP1_20060509_24hr', 'HRSN_FROB_BP2_20060509_24hr', 'HRSN_FROB_BP3_20060509_24hr', ...
%         'HRSN_RMNB_BP1_20060509_24hr', 'HRSN_RMNB_BP2_20060509_24hr', 'HRSN_RMNB_BP3_20060509_24hr', ...
%         'HRSN_EADB_BP1_20060509_24hr', 'HRSN_EADB_BP2_20060509_24hr', 'HRSN_EADB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.3; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_21ch_20060509_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_21ch_20060509_24hr';
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
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.2; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_15ch_20060509_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_15ch_20060509_24hr';
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
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_12ch_20060509_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_12ch_20060509_24hr';
%     inp.channelFolders = {...
%         'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', 'HRSN_SCYB_BP1_20060509_24hr', ...
%         'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%         'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_JCNB_BP3_20060509_24hr', ...
%         'HRSN_SCYB_BP3_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_39ch_20071026_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_39ch_20071026_24hr';
%     inp.channelFolders = {...
%         'HRSN_GHIB_BP1_20071026_24hr', 'HRSN_JCSB_BP1_20071026_24hr', 'HRSN_GHIB_BP3_20071026_24hr', ...
%         'HRSN_EADB_BP1_20071026_24hr', 'HRSN_EADB_BP2_20071026_24hr', 'HRSN_EADB_BP3_20071026_24hr', ...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_FROB_BP2_20071026_24hr', 'HRSN_FROB_BP3_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', ...
%         'HRSN_VCAB_BP1_20071026_24hr', 'HRSN_VCAB_BP2_20071026_24hr', 'HRSN_VCAB_BP3_20071026_24hr', ...
%         'HRSN_LCCB_BP1_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', 'HRSN_LCCB_BP3_20071026_24hr', ...
%         'HRSN_CCRB_BP1_20071026_24hr', 'HRSN_CCRB_BP2_20071026_24hr', 'HRSN_CCRB_BP3_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr', ...
%         'HRSN_JCSB_BP2_20071026_24hr', 'HRSN_JCSB_BP3_20071026_24hr', 'HRSN_FROB_BP1_20071026_24hr', ...
%         'HRSN_VARB_BP1_20071026_24hr', 'HRSN_VARB_BP2_20071026_24hr', 'HRSN_VARB_BP3_20071026_24hr', ...
%         'HRSN_RMNB_BP1_20071026_24hr', 'HRSN_RMNB_BP2_20071026_24hr', 'HRSN_RMNB_BP3_20071026_24hr', ...
%         'HRSN_MMNB_BP1_20071026_24hr', 'HRSN_MMNB_BP2_20071026_24hr', 'HRSN_GHIB_BP2_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.3; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_28ch_20071026_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_28ch_20071026_24hr';
%     inp.channelFolders = {...
%         'HRSN_GHIB_BP1_20071026_24hr', 'HRSN_JCSB_BP1_20071026_24hr', 'HRSN_GHIB_BP3_20071026_24hr', ...
%         'HRSN_EADB_BP1_20071026_24hr', 'HRSN_EADB_BP2_20071026_24hr', 'HRSN_EADB_BP3_20071026_24hr', ...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_FROB_BP2_20071026_24hr', 'HRSN_FROB_BP3_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', ...
%         'HRSN_VCAB_BP1_20071026_24hr', 'HRSN_VCAB_BP2_20071026_24hr', 'HRSN_VCAB_BP3_20071026_24hr', ...
%         'HRSN_LCCB_BP1_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', 'HRSN_LCCB_BP3_20071026_24hr', ...
%         'HRSN_CCRB_BP1_20071026_24hr', 'HRSN_CCRB_BP2_20071026_24hr', 'HRSN_CCRB_BP3_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr', ...
% 	'HRSN_JCSB_BP2_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.2; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_18ch_20071026_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_18ch_20071026_24hr';
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
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_HRSN_12ch_20071026_24hr
%     flag_autocorr = 0;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_12ch_20071026_24hr';
%     inp.channelFolders = {...
%         'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%         'HRSN_JCSB_BP2_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', ...
%         'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%         'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.05;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 400;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20101101_3ch_01hr
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_WHAR_20101101_3ch_01hr';
%     inp.channelFolders = {'WHAR_HHE_20101101_01hr', 'WHAR_HHN_20101101_01hr', ...
%         'WHAR_HHZ_20101101_01hr'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
% %     inp.fingerprintLength = 100;
% %     inp.fingerprintLength = 32;
%     inp.fingerprintLength = 64;
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
%     thresh = 0.04; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20101101_3ch_24hr
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
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
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20100701_3ch_1wk
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
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
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20100701_3ch_2wk
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
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
%     thresh = 0.15; % Network FAST similarity threshold
   
%     %%% ---> totalMatrix_WHAR_20100701_3ch_1month
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_WHAR_20100701_3ch_1month';
%     inp.channelFolders = {'WHAR_HHE_20100701_1month', 'WHAR_HHN_20100701_1month', ...
%         'WHAR_HHZ_20100701_1month'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 8;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold
 
%     %%% ---> totalMatrix_WHAR_20100801_3ch_1month
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_WHAR_20100801_3ch_1month';
%     inp.channelFolders = {'WHAR_HHE_20100801_1month', 'WHAR_HHN_20100801_1month', ...
%         'WHAR_HHZ_20100801_1month'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 8;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20100601_3ch_1month
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_WHAR_20100601_3ch_1month';
%     inp.channelFolders = {'WHAR_HHE_20100601_1month', 'WHAR_HHN_20100601_1month', ...
%         'WHAR_HHZ_20100601_1month'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 8;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.15; % Network FAST similarity threshold

%     %%% ---> totalMatrix_WHAR_20100601_3ch_3month
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_WHAR_20100601_3ch_3month';
%     inp.channelFolders = {'WHAR_HHE_20100601_3month', 'WHAR_HHN_20100601_3month', ...
%        'WHAR_HHZ_20100601_3month'};
%     inp.windowDuration = 3.0;
%     inp.windowLag = 0.03;
%     inp.fingerprintLength = 64;
%     inp.fingerprintLag = 10;
%     inp.t_value = 800;
%     inp.settings.nfuncs = 8;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 4;
%     thresh = 0.25; % Network FAST similarity threshold
   
%    %%% ---> totalMatrix_CI_HectorMine_9ch_20hr
%     flag_autocorr = 0;
%     baseDir = '/data/beroza/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_CI_HectorMine_9ch_20hr';
%     inp.channelFolders = {'CI_CDY_EHZ_20hr', 'CI_CPM_EHZ_20hr', 'CI_GTM_EHZ_20hr', 'CI_HEC_BHE_20hr', ...
%         'CI_HEC_BHN_20hr', 'CI_HEC_BHZ_20hr', 'CI_RMM_EHZ_20hr', 'CI_RMR_EHZ_20hr', 'CI_TPC_EHZ_20hr'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.2;
%     inp.fingerprintLength = 32;
%     inp.fingerprintLag = 5;
%     inp.t_value = 400;
% %     inp.windowLag = 0.1;
% %     inp.fingerprintLength = 64;
% %     inp.fingerprintLag = 10;
% %     inp.t_value = 800;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     thresh = 0.1; % Network FAST similarity threshold

%    %%% ---> totalMatrix_IG_PNIG_10to11day_3ch_24hr_Filter3to20
%     flag_autocorr = 0;
%     baseDir = '../../data/OutputFAST/';
% %     outFolder = 'totalMatrix_IG_PNIG_10to11day_3ch_24hr_Filter3to20';
% %     inp.channelFolders = {'IG_PNIG_HHE_10to11day_24hr_Filter3to20', 'IG_PNIG_HHN_10to11day_24hr_Filter3to20', ...
% %        'IG_PNIG_HHZ_10to11day_24hr_Filter3to20'};
% %     outFolder = 'totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to20';
% %     inp.channelFolders = {'IG_PNIG_HHE_2to3day_24hr_Filter3to20', 'IG_PNIG_HHN_2to3day_24hr_Filter3to20', ...
% %        'IG_PNIG_HHZ_2to3day_24hr_Filter3to20'};
% %     outFolder = 'totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to20';
% %     inp.channelFolders = {'IG_PNIG_HHE_8to9day_24hr_Filter3to20', 'IG_PNIG_HHN_8to9day_24hr_Filter3to20', ...
% %        'IG_PNIG_HHZ_8to9day_24hr_Filter3to20'};
% %     outFolder = 'totalMatrix_IG_PNIG_2to3day_3ch_24hr_Filter3to30';
% %     inp.channelFolders = {'IG_PNIG_HHE_2to3day_24hr_Filter3to30', 'IG_PNIG_HHN_2to3day_24hr_Filter3to30', ...
% %        'IG_PNIG_HHZ_2to3day_24hr_Filter3to30'};
% %     outFolder = 'totalMatrix_IG_PNIG_8to9day_3ch_24hr_Filter3to30';
% %     inp.channelFolders = {'IG_PNIG_HHE_8to9day_24hr_Filter3to30', 'IG_PNIG_HHN_8to9day_24hr_Filter3to30', ...
% %        'IG_PNIG_HHZ_8to9day_24hr_Filter3to30'};
%     outFolder = 'totalMatrix_IG_PNIG_15days_3ch_Filter3to20';
%     inp.channelFolders = {'IG_PNIG_HHE_15days_Filter3to20', 'IG_PNIG_HHN_15days_Filter3to20', ...
%        'IG_PNIG_HHZ_15days_Filter3to20'};
%     inp.windowDuration = 6.0;
%     inp.windowLag = 0.2;
%     inp.fingerprintLength = 128;
%     inp.fingerprintLag = 10;
%     inp.t_value = 1600;
%     inp.settings.nfuncs = 5;
%     inp.settings.ntbls = 100;
%     inp.settings.nvotes = 2;
%     thresh = 0.06; % Network FAST similarity threshold

%     %%% ---> Autocorrelation totalMatrix_NCSN_CCOB_3comp_24hr
%     flag_autocorr = 1;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_NCSN_CCOB_3comp_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2011.008.00.00.00.deci5.24hr.NC.');
%     sigmaVal = 3;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', 'CCOB.EHZ.D.SAC.bp4to10'};
%     dt_ac = 0.05;
%     thresh = 1.0627;

%     %%% ---> Autocorrelation totalMatrix_NCSN_Calaveras_7ch_24hr
%     flag_autocorr = 1;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_NCSN_Calaveras_7ch_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2011.008.00.00.00.deci5.24hr.NC.');
%     sigmaVal = 3;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', ...
%         'CCOB.EHZ.D.SAC.bp4to10', 'CADB.EHZ.D.SAC.bp2to10', ...
%         'CAO.EHZ.D.SAC.bp2to10', 'CHR.EHZ.D.SAC.bp2to10', 'CML.EHZ.D.SAC.bp2to6'};
%     dt_ac = 0.05;
%     thresh = 1.0627;

%     %%% ---> Autocorrelation totalMatrix_NCSN_Calaveras_7ch_1wk
%     flag_autocorr = 1;
%     baseDir = '../../data/OutputFAST/';
%     outFolder = 'totalMatrix_NCSN_Calaveras_7ch_1wk';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '1week.2011.008.00.00.00.0000.deci5.NC.');
%     sigmaVal = 4;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'CCOB..EHE.D.SAC.bp4to10', 'CCOB..EHN.D.SAC.bp4to10', ...
%         'CCOB..EHZ.D.SAC.bp4to10', 'CADB..EHZ.D.SAC.bp2to10', ...
%         'CAO..EHZ.D.SAC.bp2to10', 'CHR..EHZ.D.SAC.bp2to10', 'CML..EHZ.D.SAC.bp2to6'};
%     dt_ac = 0.05;
%     thresh = 1.0627;

%     %%% ---> Autocorrelation totalMatrix_HRSN_CCRB_3comp_20060509_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_CCRB_3comp_20060509_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2006.129.00.00.00.0276.BP.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'CCRB..BP1.Q.SAC.bp2to8', 'CCRB..BP2.Q.SAC.bp2to8', 'CCRB..BP3.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 0.2;

%     %%% ---> Autocorrelation totalMatrix_HRSN_21ch_20060509_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_21ch_20060509_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2006.129.00.00.00.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'0276.BP.CCRB..BP1.Q.SAC.bp2to8', '0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', ...
%         '0039.BP.GHIB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP2.Q.SAC.bp2to8', ...
%         '0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8', ...
%         '0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP2.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', ...
%         '0176.BP.MMNB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8', '0070.BP.SMNB..BP3.Q.SAC.bp2to8', ...
%         '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8', '0336.BP.VARB..BP3.Q.SAC.bp2to8', ...
%         '0090.BP.VCAB..BP1.Q.SAC.bp2to8', '0090.BP.VCAB..BP2.Q.SAC.bp2to8', '0090.BP.VCAB..BP3.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 1.3;

%     %%% ---> Autocorrelation totalMatrix_HRSN_12ch_20060509_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_12ch_20060509_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2006.129.00.00.00.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', '0377.BP.JCNB..BP3.Q.SAC.bp2to8', ...
%         '0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8', ...
%         '0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8', ...
%         '0070.BP.SMNB..BP3.Q.SAC.bp2to8', '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 1.0;
    
%     %%% ---> Autocorrelation totalMatrix_HRSN_12ch_20071026_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_12ch_20071026_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2007.299.00.00.00.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'0389.BP.SMNB..BP1.Q.SAC.bp2to8', '0389.BP.SMNB..BP2.Q.SAC.bp2to8', '0389.BP.SMNB..BP3.Q.SAC.bp2to8', ...
%        '0478.BP.SCYB..BP1.Q.SAC.bp2to8', '0478.BP.SCYB..BP2.Q.SAC.bp2to8', '0478.BP.SCYB..BP3.Q.SAC.bp2to8', ...
%        '0278.BP.JCNB..BP1.Q.SAC.bp2to8', '0278.BP.JCNB..BP2.Q.SAC.bp2to8', '0278.BP.JCNB..BP3.Q.SAC.bp2to8', ...
%        '0058.BP.LCCB..BP2.Q.SAC.bp2to8', '0374.BP.MMNB..BP3.Q.SAC.bp2to8', '0078.BP.JCSB..BP2.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 1.0;

%     %%% ---> Autocorrelation totalMatrix_HRSN_18ch_20071026_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_18ch_20071026_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2007.299.00.00.00.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'0389.BP.SMNB..BP1.Q.SAC.bp2to8', '0389.BP.SMNB..BP2.Q.SAC.bp2to8', '0389.BP.SMNB..BP3.Q.SAC.bp2to8', ...
%        '0478.BP.SCYB..BP1.Q.SAC.bp2to8', '0478.BP.SCYB..BP2.Q.SAC.bp2to8', '0478.BP.SCYB..BP3.Q.SAC.bp2to8', ...
%        '0278.BP.JCNB..BP1.Q.SAC.bp2to8', '0278.BP.JCNB..BP2.Q.SAC.bp2to8', '0278.BP.JCNB..BP3.Q.SAC.bp2to8', ...
%        '0058.BP.LCCB..BP2.Q.SAC.bp2to8', '0374.BP.MMNB..BP3.Q.SAC.bp2to8', '0078.BP.JCSB..BP2.Q.SAC.bp2to8', ...
%        '0213.BP.VCAB..BP1.Q.SAC.bp2to8', '0213.BP.VCAB..BP2.Q.SAC.bp2to8', '0213.BP.VCAB..BP3.Q.SAC.bp2to8', ...
%        '0058.BP.LCCB..BP1.Q.SAC.bp2to8', '0058.BP.LCCB..BP3.Q.SAC.bp2to8', '0445.BP.FROB..BP3.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 1.3;

%     %%% ---> Autocorrelation totalMatrix_HRSN_28ch_20071026_24hr
%     flag_autocorr = 1;
%     baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
%     outFolder = 'totalMatrix_HRSN_28ch_20071026_24hr';
%     acDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = strcat(acDir, '2007.299.00.00.00.');
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal));
%     channelStr = {'0389.BP.SMNB..BP1.Q.SAC.bp2to8', '0389.BP.SMNB..BP2.Q.SAC.bp2to8', '0389.BP.SMNB..BP3.Q.SAC.bp2to8', ...
%        '0478.BP.SCYB..BP1.Q.SAC.bp2to8', '0478.BP.SCYB..BP2.Q.SAC.bp2to8', '0478.BP.SCYB..BP3.Q.SAC.bp2to8', ...
%        '0278.BP.JCNB..BP1.Q.SAC.bp2to8', '0278.BP.JCNB..BP2.Q.SAC.bp2to8', '0278.BP.JCNB..BP3.Q.SAC.bp2to8', ...
%        '0058.BP.LCCB..BP2.Q.SAC.bp2to8', '0374.BP.MMNB..BP3.Q.SAC.bp2to8', '0078.BP.JCSB..BP2.Q.SAC.bp2to8', ...
%        '0213.BP.VCAB..BP1.Q.SAC.bp2to8', '0213.BP.VCAB..BP2.Q.SAC.bp2to8', '0213.BP.VCAB..BP3.Q.SAC.bp2to8', ...
%        '0058.BP.LCCB..BP1.Q.SAC.bp2to8', '0058.BP.LCCB..BP3.Q.SAC.bp2to8', '0445.BP.FROB..BP3.Q.SAC.bp2to8', ...
%        '0296.BP.EADB..BP1.Q.SAC.bp2to8', '0296.BP.EADB..BP2.Q.SAC.bp2to8', '0296.BP.EADB..BP3.Q.SAC.bp2to8', ...
%        '0318.BP.CCRB..BP1.Q.SAC.bp2to8', '0318.BP.CCRB..BP2.Q.SAC.bp2to8', '0318.BP.CCRB..BP3.Q.SAC.bp2to8', ...
%        '0300.BP.GHIB..BP1.Q.SAC.bp2to8', '0300.BP.GHIB..BP3.Q.SAC.bp2to8', '0445.BP.FROB..BP2.Q.SAC.bp2to8', ...
%        '0078.BP.JCSB..BP1.Q.SAC.bp2to8'};
%     dt_ac = 0.05;
%     thresh = 2.0;


    %%%%%%%%%%%%%%%%%%%%%%%%% Common to all data sets %%%%%%%%%%%%%%%%%%%%%%%


    if (flag_autocorr)
       paramStr = strcat('_', sigmaFileStr);
       for k=1:length(channelStr)
	   currentFilePath = strcat(baseFileStr, channelStr{k}, '/', sigmaFileStr, '.bin');
	   [ccData, settings(k)] = load_autocorr_data(currentFilePath);
	   simData(k).detdata.pair_i = uint32(ccData.cc_i);
	   simData(k).detdata.pair_j = uint32(ccData.cc_j);
	   simData(k).detdata.pair_k = single(ccData.cc);
       end
       nfp = settings(1).end_time; % number of fingerprints (time windows)
       dt = dt_ac; % time lag (s) between adjacent time windows

    else % Network FAST
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
       nfp = simData(1).nfp; % number of fingerprints
       dt = simData(1).dt_fp; % time lag (s) between adjacent fingerprints
    end

    disp(['get_total_similarity_inputs took: ' num2str(toc(time))]);
end
