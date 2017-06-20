% output_autocorr_detections.m
%
% Output a list of detections from autocorrelation, in ascending time order:
%  Time   CC Value          Detection or not (to fill in 0's)
%  173.65 0.727051973342896 1
%  548.05 0.973016321659088 1
%  608.25 0.944417059421539 1
%  648.75 0.541521728038788 1
%  786.45 0.987143039703369 1
%  807.45 0.540603458881378 1
%  833.95 0.943332612514496 1
%  872.85 0.645919501781464 1
%  923.85 0.560258686542511 1
%  988.25 0.944223284721375 1
%
% Later read in using dlmread(), compare with fingerprint detections

close all
clear

addpath('../Utilities/');

%------------------------input section------------------------------%

acDir = '/data/cees/ceyoon/autocorr_dev/results/';

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% baseFileStr = strcat(acDir, '1week.2011.008.00.00.00.0000.deci5.NC.');
% channelStr = {'CCOB..EHN.D.SAC.bp4to10'};
% sigmaVal = 5;
% sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
% baseOutDataStr = {'NCSN_CCOB_EHN_1wk'};
% dt = 0.05;
% % out_thresh = [0.5514]; % precision-recall test
% out_thresh = [0.8179]; % final results
% time_window = 21.0;

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% baseFileStr = strcat(acDir, '2011.008.00.00.00.deci5.24hr.NC.');
% channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', 'CCOB.EHZ.D.SAC.bp4to10', ...
%      'CADB.EHZ.D.SAC.bp2to10', 'CAO.EHZ.D.SAC.bp2to10', 'CHR.EHZ.D.SAC.bp2to10', 'CML.EHZ.D.SAC.bp2to6'};
% sigmaVal = 5;
% sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
% baseOutDataStr = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%     'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%     'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
% dt = 0.05;
% out_thresh = [0.5401 0.5514 0.581 0.49 0.49 0.49 0.57];
% time_window = 21.0;

% flag_multichannel = 0;
% baseDir = '../../data/OutputFAST/';
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp1.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.5.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.1.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.05.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.04.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.03.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.02.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.24.36.amp0.01.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp1.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.5.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.1.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.05.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.04.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.03.NC.');
% % baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.02.NC.');
% baseFileStr = strcat(acDir, 'synthetic.deci5.12hr.69.81.amp0.01.NC.');
% channelStr = {'CCOB.EHN.D.SAC.bp4to10'};
% sigmaVal = 4;
% sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03'};
% % baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02'};
% baseOutDataStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'};
% dt = 0.05;
% out_thresh = [0.5];
% time_window = 21.0;

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelStr = {'autocorr_sigma3_thresh1.0627.mat'};
% baseOutDataStr = {'totalMatrix_NCSN_CCOB_3comp_24hr'};
% dt = 0.05;
% out_thresh = [1.0627];
% time_window = 21.0;

flag_multichannel = 1;
baseDir = '../../data/OutputFAST/';
channelStr = {'autocorr_sigma3_thresh1.0627.mat'};
baseOutDataStr = {'totalMatrix_NCSN_Calaveras_7ch_24hr'};
dt = 0.05;
% out_thresh = [1.48]; % precision-recall test
out_thresh = [1.75]; % final results
time_window = 21.0;

% flag_multichannel = 1;
% baseDir = '../../data/OutputFAST/';
% channelStr = {'autocorr_sigma4_thresh1.0627.mat'};
% baseOutDataStr = {'totalMatrix_NCSN_Calaveras_7ch_1wk'};
% dt = 0.05;
% % out_thresh = [1.48]; % precision-recall test
% out_thresh = [1.75]; % final results
% time_window = 21.0;

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% channelStr = {'autocorr_sigma3.5_thresh1.mat'};
% baseOutDataStr = {'totalMatrix_HRSN_12ch_20060509_24hr'};
% % baseOutDataStr = {'totalMatrix_HRSN_12ch_20071026_24hr'};
% dt = 0.05;
% out_thresh = [1.5];
% time_window = 5.0;

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% channelStr = {'autocorr_sigma3.5_thresh1.3.mat'};
% % baseOutDataStr = {'totalMatrix_HRSN_21ch_20060509_24hr'};
% baseOutDataStr = {'totalMatrix_HRSN_18ch_20071026_24hr'};
% dt = 0.05;
% out_thresh = [1.6];
% time_window = 5.0;

% flag_multichannel = 1;
% baseDir = '/data/cees/ceyoon/FASTcode/data/OutputFAST/';
% channelStr = {'autocorr_sigma3.5_thresh2.mat'};
% baseOutDataStr = {'totalMatrix_HRSN_28ch_20071026_24hr'};
% dt = 0.05;
% out_thresh = [2.0];
% time_window = 5.0;

%-----------------End of input section------------------------------%

epsilon = 1.0e-5;
for k=1:length(channelStr)
    
    actual_thresh(k) = out_thresh(k) - epsilon; % prevent roundoff error - ensure all events above threshold are output to file
    if (flag_multichannel)
       currentFilePath = strcat(baseDir, baseOutDataStr{k}, '/', channelStr);
       load(currentFilePath{1});
       totalPairs.i = uint32(totalPairs.i);
       totalPairs.j = uint32(totalPairs.j);
       totalPairs.k = single(totalPairs.k);
    else
       currentFilePath = strcat(baseFileStr, channelStr{k}, '/', sigmaFileStr);
       [data, settings(k)] = load_autocorr_data(currentFilePath);
       totalPairs.i = uint32(data.cc_i);
       totalPairs.j = uint32(data.cc_j);
       totalPairs.k = single(data.cc);
    end
    disp(['Output autocorrelation detections: Processing channel ' channelStr{k}]);
    
    % Eliminate duplicate pairs
    skip_samples = round(time_window/dt);
    tic;
%    topdata = remove_duplicates(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), skip_samples); % slow MATLAB version
    [topdata.cc_i, topdata.cc_j, topdata.cc] = mxRemoveDuplicatePairs(...
        totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), skip_samples);
    disp(['Eliminate duplicate pairs C++ took: ', num2str(toc)]);
    clear totalPairs;
    
    % Get list of detections, remove duplicate events in the process
    tic;
    [detection_out] = make_detection_list(topdata, actual_thresh(k), skip_samples)
    disp(['Make detection list without duplicate events took: ', num2str(toc)]);
    det_times = (double(detection_out{1})*dt); % times (s)
    det_sim = (detection_out{2}); % CC values

    % Output autocorrelation detections to text file
    C = [det_times det_sim ones(length(det_times),1)];
    outfilename = strcat('autocorr_timewin', num2str(time_window), '_thresh', num2str(out_thresh(k)), '.txt');
    outfilepath = strcat(baseDir, baseOutDataStr{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%7.2f %16.15f %d\n', C');
    fclose(fid);
end
