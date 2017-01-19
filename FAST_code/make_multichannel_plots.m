close all
clear

% Make plots of all components from NCSN 7 channels, Calaveras Fault
% CCOB (3 components), CADB, CAO, CHR, CML
% 2014-05-29 Clara Yoon

%%%%%%%%%%%%%%%%%%% SEISMOGRAMS %%%%%%%%%%%%%%%%%%%

% Get data from each station
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_Calaveras_7ch_03hr');
s = size(x);
nch = s(2);
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ', 'CADB.EHZ', 'CAO.EHZ', ...
    'CHR.EHZ', 'CML.EHZ'};

step_hour = 3; % number of hours to plot every step
first_hour = [0:step_hour:24*7-1];
last_hour = first_hour + 3;
nsteps = length(first_hour);

for ss=1:nsteps
    
    close all

    first_index = samplingRate*3600*first_hour(ss) + 1;
    last_index = samplingRate*3600*last_hour(ss);

    t_step = t(first_index:last_index);
    x_step = x(first_index:last_index,:);

    % Plot all seismograms
    % xmin = 0;
    % % % xmax = 3600; % 1 hr
    % xmax = 10800; % 3 hr
    xmin = t_step(1);
    xmax = t_step(end);
    ymin = -400;
    ymax = 400;
    FigHandle = figure('Position',[150 150 1024 1536]);
    for k=1:nch
        subplot(nch,1,k); set(gca,'FontSize',16);
        plot(t_step, x_step(:,k)); xlim([xmin xmax]); ylim([ymin ymax]); title(titlestr{k});
        set(gca,'XTick',[]);
        set(gca,'YTick',[-400 0 400]);
    end
    set(gca,'XTickMode','auto');
    xlabel('Time (s)');
    
    set(gcf, 'PaperPositionMode', 'auto'); % save figure to specific size
%     timefile = ['./1week_time/original/NCSN_Calaveras_7ch_time_' sprintf('%03d',first_hour(ss)) ...
%         'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    timefile = ['./1week_time/bandpass/NCSN_Calaveras_7ch_time_' sprintf('%03d',first_hour(ss)) ...
        'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    print('-dpng', timefile);

    %%%%%%%%%%%%%%%%%%% SPECTROGRAMS %%%%%%%%%%%%%%%%%%%

    % Spectrogram parameters - set - same for all 7 channels
    windowDuration = 10.0; % window length (s)
    lagTime = 0.1; % lag time between windows (s)

    % Spectrogram parameters - calculated - same for all 7 channels
    windowLength = samplingRate * windowDuration; % number of samples in window
    lagLength = samplingRate * lagTime; % number of lag samples
    windowOverlap = windowLength - lagLength; % number of overlap samples

    % Compute spectrogram for each channel
    for k=1:nch
        [S, F(:,k), T(:,k), P(:,:,k)] = spectrogram(x_step(:,k), windowLength, ...
            windowOverlap, windowLength, samplingRate);
    end
    clear S;

    % Plot all spectrograms
    cmin = -6;
    cmax = 6;
    FigHandle = figure('Position',[300 300 1024 1536]);
    for k=1:nch
        subplot(nch,1,k); % set(gca,'FontSize',16);
        imagesc(T(:,k), F(:,k), log10(P(:,:,k))); title(titlestr{k});
        set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
        colorbar; caxis([cmin cmax]);
    end
    xlabel('Time (s)');
    
    set(gcf, 'PaperPositionMode', 'auto'); % save figure to specific size
%     specfile = ['./1week_spectrogram/original/NCSN_Calaveras_7ch_spectrogram_' ...
%         sprintf('%03d',first_hour(ss)) 'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    specfile = ['./1week_spectrogram/bandpass/NCSN_Calaveras_7ch_spectrogram_' ...
        sprintf('%03d',first_hour(ss)) 'hr_' sprintf('%03d',last_hour(ss)) 'hr.png'];
    print('-dpng', specfile);

end