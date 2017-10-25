% Run combine_autocorr_similarity_results
function [totalPairs, detection_out] = combine_autocorr_similarity_results()

    [simData, nfp, dt, thresh, time_window] = get_total_similarity_inputs();
    [totalPairs] = compute_total_similarity_matrix(nfp, simData, thresh);
    [detection_out] = post_process_detection_pairs(totalPairs, dt, thresh, time_window);
    
end

% Get each single-channel similarity matrix in simData
function [simData, nfp, dt, thresh, time_window] = get_total_similarity_inputs()

    time = tic;

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
%     time_window = 21.0;
    
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
%     time_window = 21.0;

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
%     time_window = 5.0;

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
%     time_window = 5.0;

%     %%% Autocorrelation HRSN_12ch_20060509_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2006.129.00.00.00.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
% %     channelStr = {'0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', '0377.BP.JCNB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8'};
% %     channelStr = {'0070.BP.SMNB..BP3.Q.SAC.bp2to8', '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8'};
% %     channelStr = {'0276.BP.CCRB..BP1.Q.SAC.bp2to8', '0176.BP.MMNB..BP3.Q.SAC.bp2to8', '0398.BP.SCYB..BP2.Q.SAC.bp2to8'};
% %     channelStr = {'0090.BP.VCAB..BP1.Q.SAC.bp2to8', '0090.BP.VCAB..BP2.Q.SAC.bp2to8', '0090.BP.VCAB..BP3.Q.SAC.bp2to8'};
%     channelStr = {'0039.BP.GHIB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP1.Q.SAC.bp2to8', '0377.BP.JCNB..BP2.Q.SAC.bp2to8', '0336.BP.VARB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0276.BP.CCRB..BP2.Q.SAC.bp2to8', '0276.BP.CCRB..BP3.Q.SAC.bp2to8', '0377.BP.JCNB..BP3.Q.SAC.bp2to8', ...
% %         '0358.BP.LCCB..BP1.Q.SAC.bp2to8', '0358.BP.LCCB..BP2.Q.SAC.bp2to8', '0358.BP.LCCB..BP3.Q.SAC.bp2to8', ...
% %         '0398.BP.SCYB..BP1.Q.SAC.bp2to8', '0398.BP.SCYB..BP3.Q.SAC.bp2to8', '0070.BP.SMNB..BP2.Q.SAC.bp2to8', ...
% %         '0070.BP.SMNB..BP3.Q.SAC.bp2to8', '0336.BP.VARB..BP1.Q.SAC.bp2to8', '0336.BP.VARB..BP2.Q.SAC.bp2to8'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 0.02;
% %     thresh = 0.1;
%     time_window = 5.0;

%     %%% Autocorrelation HRSN_12ch_20071026_24hr
%     baseDir = '/data/cees/ceyoon/autocorr_dev/results/';
%     baseFileStr = '2007.299.00.00.00.';
%     baseStr = strcat(baseDir, baseFileStr);
%     sigmaVal = 3.5;
%     sigmaFileStr = strcat('sigma', num2str(sigmaVal), '.bin');
% %     channelStr = {'0389.BP.SMNB..BP1.Q.SAC.bp2to8', '0389.BP.SMNB..BP2.Q.SAC.bp2to8', '0389.BP.SMNB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0478.BP.SCYB..BP1.Q.SAC.bp2to8', '0478.BP.SCYB..BP2.Q.SAC.bp2to8', '0478.BP.SCYB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0278.BP.JCNB..BP1.Q.SAC.bp2to8', '0278.BP.JCNB..BP2.Q.SAC.bp2to8', '0278.BP.JCNB..BP3.Q.SAC.bp2to8'};
%     channelStr = {'0058.BP.LCCB..BP2.Q.SAC.bp2to8', '0374.BP.MMNB..BP3.Q.SAC.bp2to8', '0078.BP.JCSB..BP2.Q.SAC.bp2to8'};
% %     channelStr = {'0213.BP.VCAB..BP1.Q.SAC.bp2to8', '0213.BP.VCAB..BP2.Q.SAC.bp2to8', '0213.BP.VCAB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0058.BP.LCCB..BP1.Q.SAC.bp2to8', '0058.BP.LCCB..BP3.Q.SAC.bp2to8', '0445.BP.FROB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0318.BP.CCRB..BP1.Q.SAC.bp2to8', '0318.BP.CCRB..BP2.Q.SAC.bp2to8', '0318.BP.CCRB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0296.BP.EADB..BP1.Q.SAC.bp2to8', '0296.BP.EADB..BP2.Q.SAC.bp2to8', '0296.BP.EADB..BP3.Q.SAC.bp2to8'};
% %     channelStr = {'0300.BP.GHIB..BP1.Q.SAC.bp2to8', '0300.BP.GHIB..BP3.Q.SAC.bp2to8', '0078.BP.JCSB..BP1.Q.SAC.bp2to8', '0445.BP.FROB..BP2.Q.SAC.bp2to8'};
%     for k=1:length(channelStr)
%         currentFilePath = strcat(baseStr, channelStr{k}, '/', sigmaFileStr);
%         [ccData, settings(k)] = load_data(currentFilePath);
%         simData(k).detdata.pair_i = ccData.cc_i;
%         simData(k).detdata.pair_j = ccData.cc_j;
%         simData(k).detdata.pair_k = double(ccData.cc);
%     end
%     nfp = settings(1).end_time;
%     dt = 0.05;
%     thresh = 0.02;
% %     thresh = 0.1;
%     time_window = 5.0;

    %%% Autocorrelation HRSN_12ch_20071026_24hr - Combine
    baseDir = '../data/haar_coefficients/';
    folderStr = 'totalMatrix_HRSN_12ch_20071026_24hr';
%     fileStr = 'autocorr_sigma3.5_thresh0.02_timewin5_part';
    fileStr = 'autocorr_sigma3.5_thresh0.02_timewin5_partA';
    for k=1:2
        currentFilePath = strcat(baseDir, folderStr, '/', fileStr, num2str(k), '.mat');
%     for k=1:2
%         currentFilePath = strcat(baseDir, folderStr, '/', fileStr, num2str(k+2), '.mat')
        load(currentFilePath);
        simData(k).detdata.pair_i = totalPairs.i;
        simData(k).detdata.pair_j = totalPairs.j;
        simData(k).detdata.pair_k = totalPairs.k;
    end
    nfp = 1728000;
    dt = 0.05;
    thresh = 0.5;
%     thresh = 0.1;
    time_window = 5.0;

    
    disp(['get_total_similarity_inputs took: ' num2str(toc(time))]);
end

function [totalPairs] = compute_total_similarity_matrix(nfp, simData, thresh)

    % Concatenate similarity data from each channel
    time = tic;

    nch = length(simData);
    allData.pair_i = simData(1).detdata.pair_i; % uint32
    allData.pair_j = simData(1).detdata.pair_j; % uint32
    allData.pair_k = simData(1).detdata.pair_k; % double
    for k=2:length(simData)
        allData.pair_i = cat(1, allData.pair_i, simData(k).detdata.pair_i);
        allData.pair_j = cat(1, allData.pair_j, simData(k).detdata.pair_j);
        allData.pair_k = cat(1, allData.pair_k, simData(k).detdata.pair_k);
    end
    clear simData;
    
    disp(['Similarity data concatenation took: ' num2str(toc(time))]);
    
    % Add similarity data from each channel
    [runTime, totalPairs.i, totalPairs.j, totalPairs.k] = mxAddSimilarityMatrix(...
        uint64(allData.pair_i), uint64(allData.pair_j), allData.pair_k, nfp, thresh);
    disp(['Add similarity matrix took: ' num2str(runTime(1))]);
    disp(['Threshold similarity matrix took: ' num2str(runTime(2))]);

end

% Post processing
function [detection_out] = post_process_detection_pairs(totalPairs, dt, thresh, time_window)

    time = tic;
    
    % Eliminate duplicate pairs
    topdata = get_autocorr_detections(totalPairs.i(:), totalPairs.j(:), totalPairs.k(:), dt, time_window);
    % view_detection_indices(1:40, topdata.cc_i, topdata.cc_j, topdata.cc, dt);
    [detection_out] = make_detection_list(topdata, thresh, dt, time_window);
%     disp(double(detection_out{1})*dt)  % view times
%     disp(detection_out{2}) % view cc values

    disp(['post_process_detection_pairs took: ' num2str(toc(time))]);
end
