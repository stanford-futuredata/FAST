function [inp] = get_FAST_input_parameters()
% Input parameters for fingerprint and similarity thresholding
% Use as config file for now
%
% Parameters to change:
%
% fileNameStr            % string for input data
% specFolderStr          % cell array for spectrogram input folder strings
% numPartitions          % number of spectrogram partitions
% windowDuration         % window length (s)
% windowLag              % lag time between windows (s)
% fingerprintLength      % number of time samples in spectral image
% fingerprintLag         % number of time samples between spectral images
% t_value                % number of top magnitude wavelet coefficients to keep
% settings.nfuncs        % number of hash functions
% settings.ntbls         % number of hash tables
% settings.nvotes        % number of votes (pair must be in at least nvotes hash tables)
% settings.near_repeats  % near repeat exclusion parameter
% settings.limit         % maximum number of windows per hash bucket
% saveVersion            % string with version for save() function intermediate outputs

% % NCSN Calaveras 7-channel, 5-station, 24 hour data
% % CCOB.EHE, CCOB.EHN, CCOB.EHZ, CADB.EHZ, CAO.EHZ, CHR.EHZ, CML.EHZ
% inp.fileNameStr = {'NCSN_Calaveras_7ch_24hr'};
% inp.specFolderStr = {{'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%     'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%     'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'}};
% inp.numPartitions = 3;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 1400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 1e3;
% inp.saveVersion = '-v7.3';

% % NCSN Calaveras 7-channel, 5-station, 3 hour data
% % CCOB.EHE, CCOB.EHN, CCOB.EHZ, CADB.EHZ, CAO.EHZ, CHR.EHZ, CML.EHZ
% inp.fileNameStr = {'NCSN_Calaveras_7ch_03hr'};
% inp.specFolderStr = {{'NCSN_CCOB_EHE_03hr', 'NCSN_CCOB_EHN_03hr', ...
%     'NCSN_CCOB_EHZ_03hr', 'NCSN_CADB_EHZ_03hr', 'NCSN_CAO_EHZ_03hr', ...
%     'NCSN_CHR_EHZ_03hr', 'NCSN_CML_EHZ_03hr'}};
% inp.numPartitions = 1;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 1400;
% inp.settings.nfuncs = 4;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 1e3;
% inp.saveVersion = '-v7.3';

% % NCSN CCOB 3-component, 1-station, 24 hour data: CCOB.EHE, CCOB.EHN, CCOB.EHZ
% inp.fileNameStr = {'NCSN_CCOB_3comp_24hr'};
% inp.specFolderStr = {{'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr'}};
% inp.numPartitions = 3;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 600;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 1e3;
% inp.saveVersion = '-v7';

% % NCSN CCOB 3-component, 1-station, 3 hour data: CCOB.EHE, CCOB.EHN, CCOB.EHZ
% inp.fileNameStr = {'NCSN_CCOB_3comp_03hr'};
% inp.specFolderStr = {{'NCSN_CCOB_EHE_03hr', 'NCSN_CCOB_EHN_03hr', 'NCSN_CCOB_EHZ_03hr'}};
% inp.numPartitions = 1;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 600;
% inp.settings.nfuncs = 4;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 1e3;
% inp.saveVersion = '-v7';

% ---> NCSN CCOB 1-component, 1-station, 24 hour data - EXAMPLE DATA SET, SINGLE CHANNEL -----
inp.timeSeriesFolder = '/data/beroza/ceyoon/FASTcode/data/TimeSeries/NCSN/';
inp.fileNameStr = {'NCSN_CCOB_EHN_24hr'};
inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10')};
inp.specFolderStr = num2cell(inp.fileNameStr);
inp.numPartitions = 3;
inp.windowDuration = 10.0;
inp.windowLag = 0.1;
inp.fingerprintLength = 100;
inp.fingerprintLag = 10;
inp.t_value = 800;
inp.settings.nfuncs = 5;
inp.settings.ntbls = 100;
inp.settings.nvotes = 4;
inp.settings.near_repeats = 5;
inp.settings.limit = 4e9;
inp.saveVersion = '-v7';

% % ---> NCSN CCOB 1-component, 1-station, 24 hour data - EXAMPLE DATA SET, MULTIPLE CHANNELS ----
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHE.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10')};
% % inp.fileNameStr = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr', ...
% %     'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', 'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHE.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CADB.EHZ.D.SAC.bp2to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CAO.EHZ.D.SAC.bp2to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CHR.EHZ.D.SAC.bp2to10'), ...
% %     strcat(inp.timeSeriesFolder, '2011.008.00.00.00.deci5.24hr.NC.CML.EHZ.D.SAC.bp2to6')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 3;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7';

% % ---> NCSN CCOB 1-component, 1-station, 3 days data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHN_3days'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 9;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 7;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

% % ---> NCSN CCOB 1-component, 1-station, 168 hour (1 week) data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% % inp.fileNameStr = {'NCSN_CCOB_EHN_1wk'}; % NCSN CCOB EHN 1 week, bandpass 4-10 Hz
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.fileNameStr = {'NCSN_CCOB_EHE_1wk', 'NCSN_CCOB_EHN_1wk', 'NCSN_CCOB_EHZ_1wk', ...
%     'NCSN_CADB_EHZ_1wk', 'NCSN_CAO_EHZ_1wk', 'NCSN_CHR_EHZ_1wk', 'NCSN_CML_EHZ_1wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHE.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHZ.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CADB..EHZ.D.SAC.bp2to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CAO..EHZ.D.SAC.bp2to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CHR..EHZ.D.SAC.bp2to10'), ...
%     strcat(inp.timeSeriesFolder, '1week.2011.008.00.00.00.0000.deci5.NC.CML..EHZ.D.SAC.bp2to6')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 21;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2; % all channels
% % inp.settings.nvotes = 4; % single channel NCSN_CCOB_EHN_1wk
% inp.settings.near_repeats = 5;
% % inp.settings.limit = 1e3;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> NCSN CCOB 1-component, 1-station, 2 weeks (14 days) data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHN_2wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '1month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 42;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 7;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

% % ---> NCSN CCOB 1-component, 1-station, 744 hour (1 month = 31 days) data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHN_1month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '1month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 93;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

% % ---> NCSN CCOB 1-component, 1-station, 3 month = 90 days data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHN_3month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '3month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 270;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 7;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> NCSN CCOB 1-component, 1-station, 6 month = 181 days data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% inp.fileNameStr = {'NCSN_CCOB_EHN_6month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '3month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 543;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 7;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';


% % ---> NCSN CCOB 1-component, 1-station, 12 hour SYNTHETIC data
% inp.timeSeriesFolder = '../data/TimeSeries/NCSN/';
% % inp.fileNameStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02', ...
% %     'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp1.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.5.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.1.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.05.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.04.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.03.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.02.NC.CCOB.EHN.D.SAC.bp4to10'), ...
% %     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.24.36.amp0.01.NC.CCOB.EHN.D.SAC.bp4to10')};
% inp.fileNameStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02', ...
%     'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp1.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.5.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.1.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.05.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.04.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.03.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.02.NC.CCOB.EHN.D.SAC.bp4to10'), ...
%     strcat(inp.timeSeriesFolder, 'synthetic.deci5.12hr.69.81.amp0.01.NC.CCOB.EHN.D.SAC.bp4to10')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 1;
% inp.windowDuration = 10.0;
% inp.windowLag = 0.1;
% inp.fingerprintLength = 100;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 1e9;
% inp.saveVersion = '-v7';

% % ---> HRSN 1-component, 1-station, 24 hour data, bandpass 2-8 Hz
% inp.timeSeriesFolder = '../data/TimeSeries/HRSN/';
% inp.fileNameStr = {...
%     'HRSN_GHIB_BP1_20060509_24hr', 'HRSN_GHIB_BP2_20060509_24hr', 'HRSN_GHIB_BP3_20060509_24hr', ...
%     'HRSN_CCRB_BP1_20060509_24hr', 'HRSN_CCRB_BP2_20060509_24hr', 'HRSN_CCRB_BP3_20060509_24hr', ...
%     'HRSN_LCCB_BP1_20060509_24hr', 'HRSN_LCCB_BP2_20060509_24hr', 'HRSN_LCCB_BP3_20060509_24hr', ...
%     'HRSN_VCAB_BP1_20060509_24hr', 'HRSN_VCAB_BP2_20060509_24hr', 'HRSN_VCAB_BP3_20060509_24hr', ...
%     'HRSN_SCYB_BP1_20060509_24hr', 'HRSN_SCYB_BP2_20060509_24hr', 'HRSN_SCYB_BP3_20060509_24hr', ...
%     'HRSN_SMNB_BP1_20060509_24hr', 'HRSN_SMNB_BP2_20060509_24hr', 'HRSN_SMNB_BP3_20060509_24hr', ...
%     'HRSN_JCNB_BP1_20060509_24hr', 'HRSN_JCNB_BP2_20060509_24hr', 'HRSN_JCNB_BP3_20060509_24hr', ...
%     'HRSN_MMNB_BP1_20060509_24hr', 'HRSN_MMNB_BP2_20060509_24hr', 'HRSN_MMNB_BP3_20060509_24hr', ...
%     'HRSN_FROB_BP1_20060509_24hr', 'HRSN_FROB_BP2_20060509_24hr', 'HRSN_FROB_BP3_20060509_24hr', ...
%     'HRSN_EADB_BP1_20060509_24hr', 'HRSN_EADB_BP2_20060509_24hr', 'HRSN_EADB_BP3_20060509_24hr', ...
%     'HRSN_RMNB_BP1_20060509_24hr', 'HRSN_RMNB_BP2_20060509_24hr', 'HRSN_RMNB_BP3_20060509_24hr', ...
%     'HRSN_VARB_BP1_20060509_24hr', 'HRSN_VARB_BP2_20060509_24hr', 'HRSN_VARB_BP3_20060509_24hr', ...
%     'HRSN_GHIB_BP1_20071026_24hr', 'HRSN_GHIB_BP2_20071026_24hr', 'HRSN_GHIB_BP3_20071026_24hr', ...
%     'HRSN_EADB_BP1_20071026_24hr', 'HRSN_EADB_BP2_20071026_24hr', 'HRSN_EADB_BP3_20071026_24hr', ...
%     'HRSN_JCNB_BP1_20071026_24hr', 'HRSN_JCNB_BP2_20071026_24hr', 'HRSN_JCNB_BP3_20071026_24hr', ...
%     'HRSN_FROB_BP1_20071026_24hr', 'HRSN_FROB_BP2_20071026_24hr', 'HRSN_FROB_BP3_20071026_24hr', ...
%     'HRSN_VCAB_BP1_20071026_24hr', 'HRSN_VCAB_BP2_20071026_24hr', 'HRSN_VCAB_BP3_20071026_24hr', ...
%     'HRSN_MMNB_BP1_20071026_24hr', 'HRSN_MMNB_BP2_20071026_24hr', 'HRSN_MMNB_BP3_20071026_24hr', ...
%     'HRSN_LCCB_BP1_20071026_24hr', 'HRSN_LCCB_BP2_20071026_24hr', 'HRSN_LCCB_BP3_20071026_24hr', ...
%     'HRSN_RMNB_BP1_20071026_24hr', 'HRSN_RMNB_BP2_20071026_24hr', 'HRSN_RMNB_BP3_20071026_24hr', ...
%     'HRSN_CCRB_BP1_20071026_24hr', 'HRSN_CCRB_BP2_20071026_24hr', 'HRSN_CCRB_BP3_20071026_24hr', ...
%     'HRSN_SMNB_BP1_20071026_24hr', 'HRSN_SMNB_BP2_20071026_24hr', 'HRSN_SMNB_BP3_20071026_24hr', ...
%     'HRSN_SCYB_BP1_20071026_24hr', 'HRSN_SCYB_BP2_20071026_24hr', 'HRSN_SCYB_BP3_20071026_24hr', ...
%     'HRSN_JCSB_BP1_20071026_24hr', 'HRSN_JCSB_BP2_20071026_24hr', 'HRSN_JCSB_BP3_20071026_24hr', ...
%     'HRSN_VARB_BP1_20071026_24hr', 'HRSN_VARB_BP2_20071026_24hr', 'HRSN_VARB_BP3_20071026_24hr'};
% inp.timeSeriesFile = {...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0039.BP.GHIB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0039.BP.GHIB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0039.BP.GHIB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0276.BP.CCRB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0276.BP.CCRB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0276.BP.CCRB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0358.BP.LCCB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0358.BP.LCCB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0358.BP.LCCB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0090.BP.VCAB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0090.BP.VCAB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0090.BP.VCAB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0398.BP.SCYB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0398.BP.SCYB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0398.BP.SCYB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0070.BP.SMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0070.BP.SMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0070.BP.SMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0377.BP.JCNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0377.BP.JCNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0377.BP.JCNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0176.BP.MMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0176.BP.MMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0176.BP.MMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0143.BP.FROB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0143.BP.FROB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0143.BP.FROB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0000.BP.EADB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0000.BP.EADB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0000.BP.EADB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0102.BP.RMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0102.BP.RMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0102.BP.RMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0336.BP.VARB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0336.BP.VARB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2006.129.00.00.00.0336.BP.VARB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0300.BP.GHIB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0300.BP.GHIB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0300.BP.GHIB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0296.BP.EADB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0296.BP.EADB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0296.BP.EADB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0278.BP.JCNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0278.BP.JCNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0278.BP.JCNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0445.BP.FROB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0445.BP.FROB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0445.BP.FROB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0213.BP.VCAB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0213.BP.VCAB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0213.BP.VCAB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0374.BP.MMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0374.BP.MMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0374.BP.MMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0058.BP.LCCB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0058.BP.LCCB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0058.BP.LCCB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0235.BP.RMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0235.BP.RMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0235.BP.RMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0318.BP.CCRB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0318.BP.CCRB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0318.BP.CCRB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0389.BP.SMNB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0389.BP.SMNB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0389.BP.SMNB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0478.BP.SCYB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0478.BP.SCYB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0478.BP.SCYB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0078.BP.JCSB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0078.BP.JCSB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0078.BP.JCSB..BP3.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0076.BP.VARB..BP1.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0076.BP.VARB..BP2.Q.SAC.bp2to8'), ...
%    strcat(inp.timeSeriesFolder, '2007.299.00.00.00.0076.BP.VARB..BP3.Q.SAC.bp2to8')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 3;
% inp.windowDuration = 6.0;
% inp.windowLag = 0.05;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 400;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 1 hour data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20101101_01hr', 'WHAR_HHN_20101101_01hr', 'WHAR_HHZ_20101101_01hr'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201011_HHE_BP_1_1_01.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201011_HHN_BP_1_1_01.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201011_HHZ_BP_1_1_01.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 6;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% % inp.fingerprintLength = 100;
% inp.fingerprintLength = 64;
% % inp.fingerprintLength = 32;
% inp.fingerprintLag = 10;
% % inp.fingerprintLag = 5;
% % inp.t_value = 200;
% % inp.t_value = 400;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% % inp.settings.nfuncs = 6;
% % inp.settings.nfuncs = 4;
% inp.settings.ntbls = 100;
% % inp.settings.ntbls = 500;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % % ---> WHAR 1-component, 1-station, 24 hour data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20101101_24hr', 'WHAR_HHN_20101101_24hr', 'WHAR_HHZ_20101101_24hr'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201011_HHE_BP_1_1.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201011_HHN_BP_1_1.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201011_HHZ_BP_1_1.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 6;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 1 week data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20100701_1wk', 'WHAR_HHN_20100701_1wk', 'WHAR_HHZ_20100701_1wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201007_HHE_BP_1_7.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201007_HHN_BP_1_7.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201007_HHZ_BP_1_7.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 42;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 2 week data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20100701_2wk', 'WHAR_HHN_20100701_2wk', 'WHAR_HHZ_20100701_2wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201007_HHE_BP_1_14.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201007_HHN_BP_1_14.SAC'), ...
%     strcat(inp.timeSeriesFolder, '201007_HHZ_BP_1_14.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 84;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 2 week data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20100501_2wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201005_HHE_BP_1_30.SAC')};
% inp.fileNameStr = {'WHAR_HHN_20100501_2wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201005_HHN_BP_1_30.SAC')};
% inp.fileNameStr = {'WHAR_HHZ_20100501_2wk'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201005_HHZ_BP_1_30.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 109;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 1 month data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20100801_1month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201008_HHE_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHN_20100801_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201008_HHN_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHZ_20100801_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201008_HHZ_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHE_20100701_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201007_HHE_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHN_20100701_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201007_HHN_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHZ_20100701_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201007_HHZ_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHE_20100601_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201006_HHE_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHN_20100601_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201006_HHN_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHZ_20100601_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201006_HHZ_BP_1_30.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 186; % 31 days (20100701, 20100801)
% % inp.numPartitions = 180; % 30 days (20100601)
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 3 month data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20100601_3month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '20100601_20100831_HHE_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHN_20100601_3month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '20100601_20100831_HHN_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHZ_20100601_3month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '20100601_20100831_HHZ_BP_1_30.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 540; % 92 days
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> WHAR 1-component, 1-station, 1 month data
% inp.timeSeriesFolder = '../data/TimeSeries/WHAR/';
% inp.fileNameStr = {'WHAR_HHE_20101101_1month'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201011_HHE_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHN_20101101_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201011_HHN_BP_1_30.SAC')};
% % inp.fileNameStr = {'WHAR_HHZ_20101101_1month'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '201011_HHZ_BP_1_30.SAC')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 180;
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> Hector Mine: 20-hour data
% inp.timeSeriesFolder = '/data/beroza/ceyoon/FASTcode/data/TimeSeries/HectorMine/';
% inp.fileNameStr = {'CI_HEC_BHZ_20hr', 'CI_HEC_BHN_20hr', 'CI_HEC_BHE_20hr', ...
%    'CI_CPM_EHZ_20hr', 'CI_TPC_EHZ_20hr', 'CI_CDY_EHZ_20hr', ...
%    'CI_GTM_EHZ_20hr', 'CI_RMM_EHZ_20hr', 'CI_RMR_EHZ_20hr'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.HEC.BHZ.SAC.hp2'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.HEC.BHN.SAC.hp2'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.HEC.BHE.SAC.hp2'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.CPM.EHZ.SAC.hp1'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.TPC.EHZ.SAC.bp1to5'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.CDY.EHZ.SAC'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.GTM.EHZ.SAC.bp1to6'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.RMM.EHZ.SAC'), ...
%      strcat(inp.timeSeriesFolder, 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.RMR.EHZ.SAC.bp1to6')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 1;
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
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

% % ---> Ometepec IG PNIG 3-component, 1-station, 24 hour data - Parameter Testing
% inp.timeSeriesFolder = '../data/TimeSeries/Ometepec/';
% % inp.fileNameStr = {'IG_PNIG_HHE_2to3day_24hr_Filter3to30', 'IG_PNIG_HHN_2to3day_24hr_Filter3to30', 'IG_PNIG_HHZ_2to3day_24hr_Filter3to30', ...
% %     'IG_PNIG_HHE_2to3day_24hr_Filter1to8', 'IG_PNIG_HHN_2to3day_24hr_Filter1to8', 'IG_PNIG_HHZ_2to3day_24hr_Filter1to8', ...
% %     'IG_PNIG_HHE_2to3day_24hr_Unfilt', 'IG_PNIG_HHN_2to3day_24hr_Unfilt', 'IG_PNIG_HHZ_2to3day_24hr_Unfilt', ...
%     inp.fileNameStr = {'IG_PNIG_HHE_8to9day_24hr_Filter3to30', 'IG_PNIG_HHN_8to9day_24hr_Filter3to30', 'IG_PNIG_HHZ_8to9day_24hr_Filter3to30', ...
%     'IG_PNIG_HHE_8to9day_24hr_Filter1to8', 'IG_PNIG_HHN_8to9day_24hr_Filter1to8', 'IG_PNIG_HHZ_8to9day_24hr_Filter1to8', ...
%     'IG_PNIG_HHE_8to9day_24hr_Unfilt', 'IG_PNIG_HHN_8to9day_24hr_Unfilt', 'IG_PNIG_HHZ_8to9day_24hr_Unfilt'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHE.bp3to30'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHN.bp3to30'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHZ.bp3to30'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHE.bp1to8'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHN.bp1to8'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHZ.bp1to8'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHE.unfilt'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHN.unfilt'), ...
% %     strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHZ.unfilt'), ...
%     inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHE.bp3to30'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHN.bp3to30'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHZ.bp3to30'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHE.bp1to8'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHN.bp1to8'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHZ.bp1to8'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHE.unfilt'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHN.unfilt'), ...
%     strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHZ.unfilt')};
% % inp.fileNameStr = {'IG_PNIG_HHE_10to11day_24hr_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '10to11day.201203.PNIG.HHE.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHZ_2to3day_24hr_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2to3day.201203.PNIG.HHZ.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHZ_8to9day_24hr_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '8to9day.201203.PNIG.HHZ.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHE_8day_4hr_Part1_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '8day4hr_Part1.201203.PNIG.HHE.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHE_2day_1hr_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '2day1hr.201203.PNIG.HHE.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHE_8day_1hr_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, '8day1hr.201203.PNIG.HHE.bp3to20')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 3;
% % inp.windowDuration = 25.0;
% inp.windowDuration = 6.0;
% % inp.windowLag = 0.25;
% inp.windowLag = 0.2;
% % inp.fingerprintLength = 64;
% inp.fingerprintLength = 128;
% inp.fingerprintLag = 10;
% % inp.t_value = 800;
% inp.t_value = 1600;
% % inp.settings.nfuncs = 4;
% inp.settings.nfuncs = 5;
% % inp.settings.nfuncs = 6;
% % inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% % inp.settings.nvotes = 4;
% % inp.settings.nvotes = 10;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

% % ---> Ometepec IG PNIG 3-component, 1-station, 15 days data
% inp.timeSeriesFolder = '../data/TimeSeries/Ometepec/';
% % inp.fileNameStr = {'IG_PNIG_HHE_15days_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'Fill.15days.201203.PNIG.HHE.sac.bp3to20')};
% % inp.fileNameStr = {'IG_PNIG_HHN_15days_Filter3to20'};
% % inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'Fill.15days.201203.PNIG.HHN.sac.bp3to20')};
% inp.fileNameStr = {'IG_PNIG_HHZ_15days_Filter3to20'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'Fill.15days.201203.PNIG.HHZ.sac.bp3to20')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 45;
% inp.windowDuration = 6.0;
% inp.windowLag = 0.2;
% inp.fingerprintLength = 128;
% inp.fingerprintLag = 10;
% inp.t_value = 1600;
% inp.settings.nfuncs = 5;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

% % ---> New Zealand Test Data Set with MiniSEED
% inp.timeSeriesFolder = '/data/beroza/ceyoon/FASTcode/data/TimeSeries/TestNewZealand/';
% inp.fileNameStr = {'NZ_LTZ_HHE_20161115_24hr'};
% inp.timeSeriesFile = {strcat(inp.timeSeriesFolder, 'NZ.LTZ.10.HHE__20161115T000000Z__20161116T000000Z.mseed')};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 3;
% inp.windowDuration = 6.0;
% inp.windowLag = 0.2;
% inp.fingerprintLength = 128;
% inp.fingerprintLag = 10;
% inp.t_value = 1600;
% inp.settings.nfuncs = 6;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9;
% inp.saveVersion = '-v7.3';

end

