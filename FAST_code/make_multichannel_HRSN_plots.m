close all
clear

% Make plots of all components from HRSN, one station at a time
% 2014-11-07 Clara Yoon

addpath('input_data');

%%%%%%%%%%%%%%%%%%% SEISMOGRAMS %%%%%%%%%%%%%%%%%%%

% time_dir = '../outputs/HRSN_time_20060509_24hr/';
% spec_dir = '../outputs/HRSN_spectrogram_20060509_24hr/';

% Get data from each station
% [t, x(:,1), samplingRate] = get_channel_data('HRSN_GHIB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_GHIB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20060509_24hr');
% titlestr = {'GHIB.BP1', 'GHIB.BP2', 'GHIB.BP3'};
% station_str = 'GHIB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_EADB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_EADB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_EADB_BP3_20060509_24hr');
% titlestr = {'EADB.BP1', 'EADB.BP2', 'EADB.BP3'};
% station_str = 'EADB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_JCNB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_JCNB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20060509_24hr');
% titlestr = {'JCNB.BP1', 'JCNB.BP2', 'JCNB.BP3'};
% station_str = 'JCNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_FROB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_FROB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_FROB_BP3_20060509_24hr');
% titlestr = {'FROB.BP1', 'FROB.BP2', 'FROB.BP3'};
% station_str = 'FROB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_VCAB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_VCAB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20060509_24hr');
% titlestr = {'VCAB.BP1', 'VCAB.BP2', 'VCAB.BP3'};
% station_str = 'VCAB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_MMNB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_MMNB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20060509_24hr');
% titlestr = {'MMNB.BP1', 'MMNB.BP2', 'MMNB.BP3'};
% station_str = 'MMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_LCCB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_LCCB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20060509_24hr');
% titlestr = {'LCCB.BP1', 'LCCB.BP2', 'LCCB.BP3'};
% station_str = 'LCCB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_RMNB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_RMNB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20060509_24hr');
% titlestr = {'RMNB.BP1', 'RMNB.BP2', 'RMNB.BP3'};
% station_str = 'RMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_CCRB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_CCRB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20060509_24hr');
% titlestr = {'CCRB.BP1', 'CCRB.BP2', 'CCRB.BP3'};
% station_str = 'CCRB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_SMNB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_SMNB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20060509_24hr');
% titlestr = {'SMNB.BP1', 'SMNB.BP2', 'SMNB.BP3'};
% station_str = 'SMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_SCYB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_SCYB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20060509_24hr');
% titlestr = {'SCYB.BP1', 'SCYB.BP2', 'SCYB.BP3'};
% station_str = 'SCYB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_VARB_BP1_20060509_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_VARB_BP2_20060509_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_VARB_BP3_20060509_24hr');
% titlestr = {'VARB.BP1', 'VARB.BP2', 'VARB.BP3'};
% station_str = 'VARB';

%---------------------------------------%

time_dir = '../outputs/HRSN_time_20071026_24hr/';
spec_dir = '../outputs/HRSN_spectrogram_20071026_24hr/';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_GHIB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_GHIB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_GHIB_BP3_20071026_24hr');
% titlestr = {'GHIB.BP1', 'GHIB.BP2', 'GHIB.BP3'};
% station_str = 'GHIB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_EADB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_EADB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_EADB_BP3_20071026_24hr');
% titlestr = {'EADB.BP1', 'EADB.BP2', 'EADB.BP3'};
% station_str = 'EADB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_JCNB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_JCNB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_JCNB_BP3_20071026_24hr');
% titlestr = {'JCNB.BP1', 'JCNB.BP2', 'JCNB.BP3'};
% station_str = 'JCNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_JCSB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_JCSB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_JCSB_BP3_20071026_24hr');
% titlestr = {'JCSB.BP1', 'JCSB.BP2', 'JCSB.BP3'};
% station_str = 'JCSB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_FROB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_FROB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_FROB_BP3_20071026_24hr');
% titlestr = {'FROB.BP1', 'FROB.BP2', 'FROB.BP3'};
% station_str = 'FROB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_VCAB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_VCAB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_VCAB_BP3_20071026_24hr');
% titlestr = {'VCAB.BP1', 'VCAB.BP2', 'VCAB.BP3'};
% station_str = 'VCAB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_MMNB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_MMNB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_MMNB_BP3_20071026_24hr');
% titlestr = {'MMNB.BP1', 'MMNB.BP2', 'MMNB.BP3'};
% station_str = 'MMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_LCCB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_LCCB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_LCCB_BP3_20071026_24hr');
% titlestr = {'LCCB.BP1', 'LCCB.BP2', 'LCCB.BP3'};
% station_str = 'LCCB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_RMNB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_RMNB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_RMNB_BP3_20071026_24hr');
% titlestr = {'RMNB.BP1', 'RMNB.BP2', 'RMNB.BP3'};
% station_str = 'RMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_CCRB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_CCRB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_CCRB_BP3_20071026_24hr');
% titlestr = {'CCRB.BP1', 'CCRB.BP2', 'CCRB.BP3'};
% station_str = 'CCRB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_SMNB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_SMNB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_SMNB_BP3_20071026_24hr');
% titlestr = {'SMNB.BP1', 'SMNB.BP2', 'SMNB.BP3'};
% station_str = 'SMNB';

% [t, x(:,1), samplingRate] = get_channel_data('HRSN_SCYB_BP1_20071026_24hr');
% [t, x(:,2), samplingRate] = get_channel_data('HRSN_SCYB_BP2_20071026_24hr');
% [t, x(:,3), samplingRate] = get_channel_data('HRSN_SCYB_BP3_20071026_24hr');
% titlestr = {'SCYB.BP1', 'SCYB.BP2', 'SCYB.BP3'};
% station_str = 'SCYB';

[t, x(:,1), samplingRate] = get_channel_data('HRSN_VARB_BP1_20071026_24hr');
[t, x(:,2), samplingRate] = get_channel_data('HRSN_VARB_BP2_20071026_24hr');
[t, x(:,3), samplingRate] = get_channel_data('HRSN_VARB_BP3_20071026_24hr');
titlestr = {'VARB.BP1', 'VARB.BP2', 'VARB.BP3'};
station_str = 'VARB';

s = size(x);
nch = s(2);

step_hour = 3; % number of hours to plot every step
total_hours = 24; % number of hours total
first_hour = [0:step_hour:total_hours-1];
last_hour = first_hour + 3;
nsteps = length(first_hour);

for ss=1:nsteps
    
    close all

    first_index = samplingRate*3600*first_hour(ss) + 1;
    last_index = min(samplingRate*3600*last_hour(ss), length(x));

    t_step = t(first_index:last_index);
    x_step = x(first_index:last_index,:);

    % Plot all seismograms
    % xmin = 0;
    % % % xmax = 3600; % 1 hr
    % xmax = 10800; % 3 hr
    xmin = t_step(1);
    xmax = t_step(end);
%     ymin = -400;
%     ymax = 400;
    FigHandle = figure('Position',[1500 150 1024 1536]);
    for k=1:nch
        subplot(nch,1,k); % set(gca,'FontSize',16);
        plot(t_step, x_step(:,k)); xlim([xmin xmax]);
%         ylim([ymin ymax]); 
        title(titlestr{k});
    end
    xlabel('Time (s)');
    
    % Output seismogram to file
    set(gcf, 'PaperPositionMode', 'auto'); % save figure to specific size
    timefile = [time_dir station_str '_time_' sprintf('%03d',first_hour(ss)) ...
        'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    print('-dpng', timefile);

    %%%%%%%%%%%%%%%%%%% SPECTROGRAMS %%%%%%%%%%%%%%%%%%%

    % Spectrogram parameters - set - same for all 7 channels
    windowDuration = 6.0; % window length (s)
    lagTime = 0.05; % lag time between windows (s)

    % Spectrogram parameters - calculated - same for all 7 channels
    windowLength = samplingRate * windowDuration; % number of samples in window
    lagLength = samplingRate * lagTime; % number of lag samples
    windowOverlap = windowLength - lagLength; % number of overlap samples

    % Plot all spectrograms
    cmin = 0;
    cmax = 5;
    FigHandle = figure('Position',[1600 300 1024 1536]);
    for k=1:nch
        % Compute spectrogram for each channel
        [S, F, T, P] = spectrogram(x_step(:,k), windowLength, ...
            windowOverlap, windowLength, samplingRate);
        
        subplot(nch,1,k); % set(gca,'FontSize',16);
        imagesc(t_step(1)+T, F, log10(P)); title(titlestr{k});
        set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
        colorbar; 
        caxis([cmin cmax]);
    end
    xlabel('Time (s)');
    clear S;
    
    % Output spectrogram to file
    set(gcf, 'PaperPositionMode', 'auto'); % save figure to specific size
    specfile = [spec_dir station_str '_spectrogram_' sprintf('%03d',first_hour(ss)) ...
        'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    print('-dpng', specfile);

end
