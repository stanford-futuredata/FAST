close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/SAC/');

% Make plots of all components from NCSN 5 stations
% CCOB, CADB, CAO, CHR, CML
% 2014-04-22 Clara Yoon

% Get data from each station
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10';
[t, CCOB.x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CCOB_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CADB.EHZ.D.SAC.bp2to10';
[t, CADB.x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CADB_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CAO.EHZ.D.SAC.bp2to10';
[t, CAO.x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CAO_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CHR.EHZ.D.SAC.bp2to10';
[t, CHR.x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CHR_EHZ_24hr');
timeSeriesFile = '../../../data/TimeSeries/NCSN/2011.008.00.00.00.deci5.24hr.NC.CML.EHZ.D.SAC.bp2to6';
[t, CML.x, samplingRate] = get_channel_data(timeSeriesFile, 'NCSN_CML_EHZ_24hr');

% Spectrogram parameters - set - same for all 5 stations
windowDuration = 10.0; % window length (s)
lagTime = 0.1; % lag time between windows (s)

% Spectrogram parameters - calculated - same for all 5 stations
windowLength = samplingRate * windowDuration; % number of samples in window
lagLength = samplingRate * lagTime; % number of lag samples
windowOverlap = windowLength - lagLength; % number of overlap samples

% Compute spectrogram for each station
[S,CCOB.F,CCOB.T,CCOB.P] = spectrogram(CCOB.x, windowLength, windowOverlap, windowLength, samplingRate);
[S,CADB.F,CADB.T,CADB.P] = spectrogram(CADB.x, windowLength, windowOverlap, windowLength, samplingRate);
[S,CAO.F,CAO.T,CAO.P] = spectrogram(CAO.x, windowLength, windowOverlap, windowLength, samplingRate);
[S,CHR.F,CHR.T,CHR.P] = spectrogram(CHR.x, windowLength, windowOverlap, windowLength, samplingRate);
[S,CML.F,CML.T,CML.P] = spectrogram(CML.x, windowLength, windowOverlap, windowLength, samplingRate);
clear S;

% Plot all seismograms
xmin = 0;
% xmax = 3600; % 1 hr
xmax = 10800; % 3 hr
ymin = -400;
ymax = 400;
FigHandle = figure('Position',[150 150 1024 1536]);
subplot(5,1,1); set(gca,'FontSize',16);
plot(t, CCOB.x); xlim([xmin xmax]); ylim([ymin ymax]); title('CCOB.EHZ');
subplot(5,1,2); set(gca,'FontSize',16);
plot(t, CADB.x); xlim([xmin xmax]); ylim([ymin ymax]); title('CADB.EHZ');
subplot(5,1,3); set(gca,'FontSize',16);
plot(t, CAO.x); xlim([xmin xmax]); ylim([ymin ymax]); title('CAO.EHZ');
subplot(5,1,4); set(gca,'FontSize',16);
plot(t, CHR.x); xlim([xmin xmax]); ylim([ymin ymax]); title('CHR.EHZ');
subplot(5,1,5); set(gca,'FontSize',16);
plot(t, CML.x); xlim([xmin xmax]); ylim([ymin ymax]); title('CML.EHZ');
xlabel('Time (s)');

% Plot all spectrograms
cmin = -6;
cmax = 6;
FigHandle = figure('Position',[300 300 1024 1536]);
subplot(5,1,1); set(gca,'FontSize',16);
imagesc(CCOB.T, CCOB.F, log10(CCOB.P)); title('CCOB.EHZ');
set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
colorbar; caxis([cmin cmax]);
subplot(5,1,2); set(gca,'FontSize',16);
imagesc(CADB.T, CADB.F, log10(CADB.P)); title('CADB.EHZ');
set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
colorbar; caxis([cmin cmax]);
subplot(5,1,3); set(gca,'FontSize',16);
imagesc(CAO.T, CAO.F, log10(CAO.P)); title('CAO.EHZ');
set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
colorbar; caxis([cmin cmax]);
subplot(5,1,4); set(gca,'FontSize',16);
imagesc(CHR.T, CHR.F, log10(CHR.P)); title('CHR.EHZ');
set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
colorbar; caxis([cmin cmax]);
subplot(5,1,5); set(gca,'FontSize',16);
imagesc(CML.T, CML.F, log10(CML.P)); title('CML.EHZ');
set(gca, 'YDir', 'normal'); ylabel('Frequency (Hz)');
colorbar; caxis([cmin cmax]);
xlabel('Time (s)');