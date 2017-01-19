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

% -------- INPUTS ----------
baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
% baseFileStr = '2011.008.00.00.00.deci5.24hr.NC.';
% channelStr = {'CCOB.EHE.D.SAC.bp4to10', 'CCOB.EHN.D.SAC.bp4to10', 'CCOB.EHZ.D.SAC.bp4to10', ...
%     'CADB.EHZ.D.SAC.bp2to10', 'CAO.EHZ.D.SAC.bp2to10', 'CHR.EHZ.D.SAC.bp2to10', 'CML.EHZ.D.SAC.bp2to6'};
% thresh = [0.5401 0.5514 0.581 0.49 0.49 0.49 0.57];
baseFileStr = '1week.2011.008.00.00.00.0000.deci5.NC.';
channelStr = {'CCOB..EHN.D.SAC.bp4to10'};
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp1.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.5.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.1.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.05.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.04.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.03.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.02.NC.';
% baseFileStr = 'synthetic.deci5.12hr.24.36.amp0.01.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp1.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.5.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.1.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.05.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.04.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.03.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.02.NC.';
% baseFileStr = 'synthetic.deci5.12hr.69.81.amp0.01.NC.';
% channelStr = {'CCOB.EHN.D.SAC.bp4to10'};
% thresh = [0.56];
% thresh = [0.57];
% thresh = [0.7];
% thresh = [0.8165];
thresh = [0.8179];
% thresh = [0.5]; % synthetic

sigmaVal = 5;
% sigmaVal = 4; % synthetic
sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');

dt = 0.05;
% time_window = 20.0;
time_window = 21.0;

% -------- OUTPUTS ----------
% baseOutDir = '../data/';
% baseOutChannelStr = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', ...
%     'NCSN_CCOB_EHZ_24hr', 'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', ...
%     'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
baseOutDir = '../data/haar_coefficients/';
baseOutChannelStr = {'NCSN_CCOB_EHN_1wk'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02'};
% baseOutChannelStr = {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'};

baseStr = strcat(baseDir, baseFileStr);
for k=1:length(channelStr)
    disp(['Output autocorrelation detections: Processing channel ' channelStr{k}]);
    
    currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
    [data, settings(k)] = load_data(currentFilePath);
    
    % Eliminate duplicate pairs
    topdata = get_autocorr_detections(data.cc_i(:), data.cc_j(:), data.cc(:), dt, time_window);
    
    % Get list of detections
    [detection_out] = make_detection_list(topdata, thresh(k), dt, time_window);
    det_times = (double(detection_out{1})*dt); % times (s)
    det_sim = (detection_out{2}); % CC values

    C = [det_times det_sim ones(length(det_times),1)];

    outfilename = strcat('autocorr_', channelStr{k}, '_timewin', num2str(time_window), '_thresh', num2str(thresh(k)), '.txt');
    outfilepath = strcat(baseOutDir, baseOutChannelStr{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%7.2f %16.15f %d\n', C');
    fclose(fid);

end
