% output_multichannel_autocorr_detections.m
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
% Call this after calling combine_similarity_results.m

close all
clear

% -------- INPUTS ----------
% inDataStr = {'autocorr_sigma3_total_matrix_NCSN_Calaveras_7ch_24hr.mat'};
% thresh = [1.0627];
% inDataStr = {'autocorr_sigma3_total_matrix_NCSN_CCOB_3comp_24hr.mat'};
% thresh = [1.0627];
% time_window = 21.0;

dt = 0.05;

% thresh = [0.5];
% time_window = 5.0;
% thresh = [1.48];
thresh = [1.75];
time_window = 21;

paramStr = strcat('_thresh', num2str(thresh(1)), '_timewin', num2str(time_window));
% inDataStr = {strcat('autocorr_sigma3.5', paramStr, '_12ch.mat')};
inDataStr = {'autocorr_sigma3_new_total_matrix_NCSN_Calaveras_7ch_24hr.mat'};

% -------- OUTPUTS ----------
baseOutDir = '../data/haar_coefficients/';
baseOutDataStr = {'totalMatrix_NCSN_Calaveras_7ch_24hr'};
% baseOutDataStr = {'totalMatrix_NCSN_CCOB_3comp_24hr'};
% baseOutDataStr = {'totalMatrix_HRSN_12ch_20071026_24hr'};
% baseOutDataStr = {'new_totalMatrix_NCSN_Calaveras_7ch_24hr'};

for k=1:length(inDataStr)
    
    currentFilePath = strcat(baseOutDir, baseOutDataStr{k}, '/', inDataStr);
    load(currentFilePath{1});

    % Eliminate duplicate pairs
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt, time_window);
%     view_detection_indices(1:40, topdata.cc_i, topdata.cc_j, topdata.cc, dt);

    % Get list of detections
    [detection_out] = make_detection_list(topdata, thresh(k), dt, time_window);   
    ix = find(detection_out{2} >= thresh(k));
    det_times = (double(detection_out{1}(ix))*dt);
    det_sim = (detection_out{2}(ix));

    C = [det_times det_sim ones(length(det_times),1)];

    outfilename = strcat('autocorr_timewin', num2str(time_window), '_thresh', num2str(thresh(k)), '.txt');
    outfilepath = strcat(baseOutDir, baseOutDataStr{k}, '/', outfilename);
    fid = fopen(outfilepath, 'w');
    fprintf(fid, '%7.2f %16.15f %d\n', C');
    fclose(fid);

end