close all
clear

% Make plots of all components from NCSN CCOB.EHN
% Save manually

%%%%%%%%%%%%%%%%%%% SEISMOGRAMS %%%%%%%%%%%%%%%%%%%

% Get data from each station
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_EHN_24hr'); % read in only first hour!
s = size(x);
nch = s(2);
% titlestr = {'CCOB.EHN'};

% Plot all seismograms
font_size = 16;
% font_size = 22;
xmin = 0;
xmax = 3600; % 1 hr
ymin = -400;
ymax = 400;
FigHandle = figure('Position',[150 150 1536 256]);
for k=1:nch
    subplot(nch,1,k); set(gca,'FontSize',font_size);
    plot(t, x(:,k)); xlim([xmin xmax]); ylim([ymin ymax]); % title(titlestr{k});
%     set(gca,'xtick',[]);
%     set(gca,'ytick',[]);
end
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous Seismic Time Series');
% outfile = 'visual_plots/time_series_1hr.eps';
% print('-depsc', outfile);

%%%%%%%%%%%%%%%%%%% SPECTROGRAMS %%%%%%%%%%%%%%%%%%%

% Spectrogram parameters - set
windowDuration = 10.0; % window length (s)
lagTime = 0.1; % lag time between windows (s)

% Spectrogram parameters - calculated
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
cmin = -5;
cmax = 5;
FigHandle = figure('Position',[300 300 1536 256]);
for k=1:nch
    subplot(nch,1,k); set(gca,'FontSize',font_size);
    imagesc(T(:,k), F(:,k), log10(P(:,:,k))); % title(titlestr{k});
    set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
    colorbar; caxis([cmin cmax]); set(gca,'FontSize',font_size);
%     set(gca, 'xtick', [], 'ytick', []);
end
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('log_{10}(|Spectrogram|)');
% outfile = 'visual_plots/spectrogram_1hr.eps';
% print('-depsc', outfile);
% saveas(gcf, outfile, 'png');
% print('-dpng', outfile);