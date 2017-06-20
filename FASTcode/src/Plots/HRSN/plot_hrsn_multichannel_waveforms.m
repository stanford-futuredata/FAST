close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

% blue: used for detection, black: not used for detection (correlated noise)

% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0039.BP.GHIB..BP3.Q.SAC.bp2to8';
% [t, x(:,1,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0000.BP.EADB..BP3.Q.SAC.bp2to8';
% [t, x(:,2,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0377.BP.JCNB..BP3.Q.SAC.bp2to8';
% [t, x(:,3,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0143.BP.FROB..BP3.Q.SAC.bp2to8';
% [t, x(:,4,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0090.BP.VCAB..BP3.Q.SAC.bp2to8';
% [t, x(:,5,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0176.BP.MMNB..BP3.Q.SAC.bp2to8';
% [t, x(:,6,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0358.BP.LCCB..BP3.Q.SAC.bp2to8';
% [t, x(:,7,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0102.BP.RMNB..BP3.Q.SAC.bp2to8';
% [t, x(:,8,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0276.BP.CCRB..BP3.Q.SAC.bp2to8';
% [t, x(:,9,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0070.BP.SMNB..BP3.Q.SAC.bp2to8';
% [t, x(:,10,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0398.BP.SCYB..BP3.Q.SAC.bp2to8';
% [t, x(:,11,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP3_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0336.BP.VARB..BP3.Q.SAC.bp2to8';
% [t, x(:,12,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP3_20060509_24hr');

% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0039.BP.GHIB..BP2.Q.SAC.bp2to8';
% [t, x(:,1,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0000.BP.EADB..BP2.Q.SAC.bp2to8';
% [t, x(:,2,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0377.BP.JCNB..BP2.Q.SAC.bp2to8';
% [t, x(:,3,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0143.BP.FROB..BP2.Q.SAC.bp2to8';
% [t, x(:,4,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0090.BP.VCAB..BP2.Q.SAC.bp2to8';
% [t, x(:,5,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0176.BP.MMNB..BP2.Q.SAC.bp2to8';
% [t, x(:,6,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0358.BP.LCCB..BP2.Q.SAC.bp2to8';
% [t, x(:,7,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0102.BP.RMNB..BP2.Q.SAC.bp2to8';
% [t, x(:,8,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0276.BP.CCRB..BP2.Q.SAC.bp2to8';
% [t, x(:,9,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0070.BP.SMNB..BP2.Q.SAC.bp2to8';
% [t, x(:,10,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0398.BP.SCYB..BP2.Q.SAC.bp2to8';
% [t, x(:,11,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP2_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0336.BP.VARB..BP2.Q.SAC.bp2to8';
% [t, x(:,12,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP2_20060509_24hr');

% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0039.BP.GHIB..BP1.Q.SAC.bp2to8';
% [t, x(:,1,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0000.BP.EADB..BP1.Q.SAC.bp2to8';
% [t, x(:,2,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0377.BP.JCNB..BP1.Q.SAC.bp2to8';
% [t, x(:,3,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0143.BP.FROB..BP1.Q.SAC.bp2to8';
% [t, x(:,4,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0090.BP.VCAB..BP1.Q.SAC.bp2to8';
% [t, x(:,5,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0176.BP.MMNB..BP1.Q.SAC.bp2to8';
% [t, x(:,6,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0358.BP.LCCB..BP1.Q.SAC.bp2to8';
% [t, x(:,7,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0102.BP.RMNB..BP1.Q.SAC.bp2to8';
% [t, x(:,8,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0276.BP.CCRB..BP1.Q.SAC.bp2to8';
% [t, x(:,9,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0070.BP.SMNB..BP1.Q.SAC.bp2to8';
% [t, x(:,10,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0398.BP.SCYB..BP1.Q.SAC.bp2to8';
% [t, x(:,11,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP1_20060509_24hr');
% timeSeriesFile = '../../../data/TimeSeries/HRSN/2006.129.00.00.00.0336.BP.VARB..BP1.Q.SAC.bp2to8';
% [t, x(:,12,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP1_20060509_24hr');

% det_color = { {'b', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b'}, ...
%     {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'b'}, ...
%     {'k', 'k', 'k', 'k', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'b'} };
% outdir = '../../../figures/HRSN/outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_21ch_20060509_24hr/';
% filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_21ch_20060509_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.5.txt';
% 
% % det_color = { {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'k', 'b', 'b'}, ...
% %     {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'b', 'b'}, ...
% %     {'k', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b', 'b', 'b', 'k'} };
% % outdir = '../../../figures/HRSN/outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_15ch_20060509_24hr/';
% % filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_15ch_20060509_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.3.txt';
% 
% % det_color = { {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'k', 'k', 'b', 'b'}, ...
% %     {'k', 'k', 'k', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'k', 'b'}, ...
% %     {'k', 'k', 'b', 'k', 'k', 'k', 'b', 'k', 'b', 'b', 'b', 'k'} };
% % outdir = '../../../figures/HRSN/outputs/HRSN_detections_20060509_24hr/totalMatrix_HRSN_12ch_20060509_24hr/';
% % filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_12ch_20060509_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.2.txt';
% 
% date_comp_str = {'2006-05-09, BP1', '2006-05-09, BP2', '2006-05-09, BP3'};
% titlestr = {'GHIB', 'EADB', 'JCNB', 'FROB', 'VCAB', 'MMNB', 'LCCB', 'RMNB', ...
%     'CCRB', 'SMNB', 'SCYB', 'VARB'};

%----------------------------------------------------------------------------

% Old method, plot 1 component at a time
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0300.BP.GHIB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0296.BP.EADB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0278.BP.JCNB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0445.BP.FROB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,4), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0213.BP.VCAB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,5), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0374.BP.MMNB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,6), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0058.BP.LCCB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,7), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0235.BP.RMNB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,8), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0318.BP.CCRB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,9), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0389.BP.SMNB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,10), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0478.BP.SCYB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,11), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0076.BP.VARB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,12), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP3_20071026_24hr');
% % % timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0078.BP.JCSB..BP3.Q.SAC.bp2to8';
% % % [t, x(:,13), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCSB_BP3_20071026_24hr');
% % % det_color = {'b', 'b', 'b', 'b', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'k', 'k'};
% % % date_comp_str = '2007-10-26, BP3';

% New method, plot 3 components at a time
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0300.BP.GHIB..BP3.Q.SAC.bp2to8';
[t, x(:,1,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0296.BP.EADB..BP3.Q.SAC.bp2to8';
[t, x(:,2,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0278.BP.JCNB..BP3.Q.SAC.bp2to8';
[t, x(:,3,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0445.BP.FROB..BP3.Q.SAC.bp2to8';
[t, x(:,4,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0213.BP.VCAB..BP3.Q.SAC.bp2to8';
[t, x(:,5,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0374.BP.MMNB..BP3.Q.SAC.bp2to8';
[t, x(:,6,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0058.BP.LCCB..BP3.Q.SAC.bp2to8';
[t, x(:,7,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0235.BP.RMNB..BP3.Q.SAC.bp2to8';
[t, x(:,8,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0318.BP.CCRB..BP3.Q.SAC.bp2to8';
[t, x(:,9,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0389.BP.SMNB..BP3.Q.SAC.bp2to8';
[t, x(:,10,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0478.BP.SCYB..BP3.Q.SAC.bp2to8';
[t, x(:,11,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0076.BP.VARB..BP3.Q.SAC.bp2to8';
[t, x(:,12,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP3_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0078.BP.JCSB..BP3.Q.SAC.bp2to8';
[t, x(:,13,3), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCSB_BP3_20071026_24hr');

timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0300.BP.GHIB..BP2.Q.SAC.bp2to8';
[t, x(:,1,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0296.BP.EADB..BP2.Q.SAC.bp2to8';
[t, x(:,2,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0278.BP.JCNB..BP2.Q.SAC.bp2to8';
[t, x(:,3,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0445.BP.FROB..BP2.Q.SAC.bp2to8';
[t, x(:,4,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0213.BP.VCAB..BP2.Q.SAC.bp2to8';
[t, x(:,5,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0374.BP.MMNB..BP2.Q.SAC.bp2to8';
[t, x(:,6,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0058.BP.LCCB..BP2.Q.SAC.bp2to8';
[t, x(:,7,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0235.BP.RMNB..BP2.Q.SAC.bp2to8';
[t, x(:,8,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0318.BP.CCRB..BP2.Q.SAC.bp2to8';
[t, x(:,9,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0389.BP.SMNB..BP2.Q.SAC.bp2to8';
[t, x(:,10,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0478.BP.SCYB..BP2.Q.SAC.bp2to8';
[t, x(:,11,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0076.BP.VARB..BP2.Q.SAC.bp2to8';
[t, x(:,12,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP2_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0078.BP.JCSB..BP2.Q.SAC.bp2to8';
[t, x(:,13,2), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCSB_BP2_20071026_24hr');

timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0300.BP.GHIB..BP1.Q.SAC.bp2to8';
[t, x(:,1,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_GHIB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0296.BP.EADB..BP1.Q.SAC.bp2to8';
[t, x(:,2,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_EADB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0278.BP.JCNB..BP1.Q.SAC.bp2to8';
[t, x(:,3,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCNB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0445.BP.FROB..BP1.Q.SAC.bp2to8';
[t, x(:,4,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_FROB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0213.BP.VCAB..BP1.Q.SAC.bp2to8';
[t, x(:,5,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VCAB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0374.BP.MMNB..BP1.Q.SAC.bp2to8';
[t, x(:,6,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_MMNB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0058.BP.LCCB..BP1.Q.SAC.bp2to8';
[t, x(:,7,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_LCCB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0235.BP.RMNB..BP1.Q.SAC.bp2to8';
[t, x(:,8,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_RMNB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0318.BP.CCRB..BP1.Q.SAC.bp2to8';
[t, x(:,9,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_CCRB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0389.BP.SMNB..BP1.Q.SAC.bp2to8';
[t, x(:,10,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SMNB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0478.BP.SCYB..BP1.Q.SAC.bp2to8';
[t, x(:,11,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_SCYB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0076.BP.VARB..BP1.Q.SAC.bp2to8';
[t, x(:,12,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_VARB_BP1_20071026_24hr');
timeSeriesFile = '../../../data/TimeSeries/HRSN/2007.299.00.00.00.0078.BP.JCSB..BP1.Q.SAC.bp2to8';
[t, x(:,13,1), samplingRate] = get_channel_data(timeSeriesFile, 'HRSN_JCSB_BP1_20071026_24hr');

% det_color = { {'b', 'b', 'b', 'k', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'k', 'b'}, ...
%     {'k', 'b', 'b', 'b', 'b', 'k', 'b', 'k', 'b', 'b', 'b', 'k', 'k'}, ...
%     {'b', 'b', 'b', 'b', 'b', 'b', 'b', 'k', 'b', 'b', 'b', 'k', 'k', 'k'} }; % 28 ch
% outdir = '../../../figures/HRSN/outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_28ch_20071026_24hr/';
% filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_28ch_20071026_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.5.txt');
% detection_out = dlmread(filepath, ' ', 1, 0);

% det_color = { {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'k'}, ...
%     {'k', 'k', 'b', 'k', 'b', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b'}, ...
%     {'k', 'k', 'b', 'b', 'b', 'b', 'b', 'k', 'k', 'b', 'b', 'k', 'k'} }; % 18 ch
% outdir = '../../../figures/HRSN/outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_18ch_20071026_24hr/';
% filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_18ch_20071026_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.3.txt';
% detection_out = dlmread(filepath, ' ', 1, 0);

det_color = { {'k', 'k', 'b', 'k', 'k', 'k', 'k', 'k', 'k', 'b', 'b', 'k', 'k'}, ...
    {'k', 'k', 'b', 'k', 'k', 'k', 'b', 'k', 'k', 'b', 'b', 'k', 'b'}, ...
    {'k', 'k', 'b', 'k', 'k', 'b', 'k', 'k', 'k', 'b', 'b', 'k', 'k'} }; % 12 ch
outdir = '../../../figures/HRSN/outputs/HRSN_detections_20071026_24hr/totalMatrix_HRSN_12ch_20071026_24hr/';
filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_12ch_20071026_24hr/fast_wLen6_wLag0.05_fpLen64_fpLag10_tvalue400_nfuncs5_ntbls100_nvotes4_timewin5_thresh0.2.txt';
detection_out = dlmread(filepath, ' ', 1, 0);
% outdir = '../../../figures/HRSN/outputs/HRSN_detections_20071026_24hr/autocorr_totalMatrix_HRSN_12ch_20071026_24hr/';
% filepath = '/data/cees/ceyoon/FASTcode/data/OutputFAST/totalMatrix_HRSN_12ch_20071026_24hr/autocorr_timewin5_thresh1.5.txt';
% detection_out = dlmread(filepath);

date_comp_str = {'2007-10-26, BP1', '2007-10-26, BP2', '2007-10-26, BP3'};
titlestr = {'GHIB', 'EADB', 'JCNB', 'FROB', 'VCAB', 'MMNB', 'LCCB', 'RMNB', ...
    'CCRB', 'SMNB', 'SCYB', 'VARB', 'JCSB'};

s = size(x);
nch = s(2);

% % Figure S1, 600 s
% start_time = 37179;
% end_time = 37779;
% scale_amp = 5;
% xtext = 60;

% % Figure S1, 25 s
% start_time = 37474;
% end_time = 37499;
% scale_amp = 2;
% xtext = 2;

% Sort detection outputs
[sort_det_sim, ix_sort] = sort(detection_out(:,2), 'descend');
times_order = detection_out(:,1);
sort_det_times = times_order(ix_sort);

start_time = sort_det_times(1:10);
% start_time = sort_det_times(1:30);
% start_time = sort_det_times(31:60);
% start_time = sort_det_times(61:90);
% start_time = sort_det_times(1:300);

% start_time = [45899 45483 1941 925 22152 20030.5];
% start_time = [22152 20030.5 73698 66481 66101.5 66055 72765 59808];
% window_duration = 20; % window duration (s)
window_duration = 10; % window duration (s)
end_time = start_time + window_duration;
scale_amp = 2;
xtext = 8;

startIndex = start_time * samplingRate;
endIndex = end_time * samplingRate;
nsamples_arr = endIndex - startIndex + 1;
nsamples = nsamples_arr(1);

dt = 1.0/samplingRate;
time_values = [0:dt:nsamples/samplingRate];
time_values = time_values(1:end-1);

% Old method, plot 1 component at a time
% for q=1:length(start_time)
% 
%     waveformMatrix = zeros(nsamples, nch);
%     for k=1:nch
%         waveformMatrix(:,k) = extract_window(x(:,k), startIndex(q), nsamples);
%     end
%     
%     FigHandle = figure('Position',[1500 150 256 1536]);
%     set(gca,'FontSize',16);
%     set(gca,'YDir','reverse');
%     hold on
%     for k=1:nch
%         wvf = scale_amp*waveformMatrix(:,k) + k;
%         plot(time_values, wvf, det_color{k}, 'LineWidth', 1);
%         text(xtext, k-0.6, titlestr{k}, 'FontSize', 14, ...
%         'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
%     end
%     hold off
%     xlabel(['Time (s), start = ', num2str(start_time(q))]);
%     ylabel('Trace number');
%     title({date_comp_str; [' network similarity = ', num2str(sort_det_sim(q))]});
%     ylim([0 nch+1]);
% end

% New method, plot 3 components at a time
FigHandle = figure('Position',[1500 150 1000 1536]);
for q=1:length(start_time)
    
%     FigHandle = figure('Position',[1500 150 1000 1536]);
    
    for ic=1:3 % loop over components

        waveformMatrix = zeros(nsamples, nch);
        for k=1:nch
            waveformMatrix(:,k) = extract_window(x(:,k,ic), uint32(startIndex(q)), nsamples);
        end

        subplot(1,3,ic);
        set(gca,'FontSize',14);
        set(gca,'YDir','reverse');
        hold on
        for k=1:nch
            wvf = scale_amp*waveformMatrix(:,k) + k;
            plot(time_values, wvf, det_color{ic}{k}, 'LineWidth', 1);
            text(xtext, k-0.8, titlestr{k}, 'FontSize', 12, ...
            'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
        end
        hold off
        xlabel(['Time (s), start = ', num2str(start_time(q))]);
        ylabel('Trace number');
        title({date_comp_str{ic}; [' network similarity = ', num2str(sort_det_sim(q))]});
        ylim([0 nch+1]);
    
    end

    % Output plot
    filename = [outdir 'waveforms_rank' num2str(q,'%04d') '_sim' ...
        num2str(sort_det_sim(q)) '_time' num2str(start_time(q)) '.png'];
    print('-dpng', filename);
    clf reset;
end
