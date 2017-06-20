close all
clear

addpath('../../Utilities/');

% Plot histogram of similar pairs from autocorrelation

% Read in detection pairs (ALL)
[data settings] = load_autocorr_data('/data/cees/ceyoon/autocorr_dev/results/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10/sigma4.bin');

% Plot histogram of autocorrelation pairs
bins = [0:0.04:1];
FigHandle = figure('Position',[1500 500 800 600]);
hist(data.cc, bins);

ph=get(gca,'children');
N = length(ph);
for ii=1:N
    vn=get(ph(ii),'Vertices');
    vn(:,2) = vn(:,2)+1;
    set(ph(ii),'Vertices',vn);
end
set(gca,'yscale','log');

set(gca,'FontSize',16);
xlim([0 1]);
xlabel('Autocorrelation CC, Waveform Pairs');
ylabel('Count');
title('Histogram of similar waveforms, CCOB.EHN 1 week');

