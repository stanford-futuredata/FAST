close all
clear

% Make plots of all components from NCSN CCOB
% 2014-02-18 Clara Yoon

%%%%%%%%%%%%%%%%%%% SEISMOGRAMS %%%%%%%%%%%%%%%%%%%

% Get data for all 3 components
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_3comp_03hr');
s = size(x);
nch = s(2);
titlestr = {'CCOB.EHE', 'CCOB.EHN', 'CCOB.EHZ'};

% Plot all seismograms
xmin = 0;
% % xmax = 3600; % 1 hr
xmax = 10800; % 3 hr
ymin = -400;
ymax = 400;
FigHandle = figure('Position',[150 150 1024 1536]);
for k=1:nch
    subplot(nch,1,k); set(gca,'FontSize',16);
    plot(t, x(:,k)); xlim([xmin xmax]); ylim([ymin ymax]); title(titlestr{k});
end
xlabel('Time (s)');

%%%%%%%%%%%%%%%%%%% SPECTROGRAMS %%%%%%%%%%%%%%%%%%%

% Spectrogram parameters - set - same for all 3 components
windowDuration = 10.0; % window length (s)
lagTime = 0.1; % lag time between windows (s)

% Spectrogram parameters - calculated - same for all 3 components
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples
windowOverlap = windowLength - lagLength; % number of overlap samples

% Compute spectrogram for each channel
for k=1:nch
    [S, F(:,k), T(:,k), P(:,:,k)] = spectrogram(x(:,k), windowLength, ...
        windowOverlap, windowLength, samplingRate);
end
clear S;

% Plot all spectrograms
cmin = -6;
cmax = 6;
FigHandle = figure('Position',[300 300 1024 1024]);
for k=1:nch
    subplot(nch,1,k); set(gca,'FontSize',16);
    imagesc(T(:,k), F(:,k), log10(P(:,:,k))); title(titlestr{k});
    set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
    colorbar; caxis([cmin cmax]);
end
xlabel('Time (s)');
