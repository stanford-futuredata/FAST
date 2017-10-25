close all
clear

addpath('../../Inputs/');
addpath('../../Utilities/');
addpath('../../Utilities/SAC/');

% Read in synthetic data with inserted signal

% timeSeriesFile = '../../../data/TimeSeries/NCSN/synthetic.deci5.12hr.24.36.amp0.05.NC.CCOB.EHN.D.SAC.bp4to10';
% [t, x, samplingRate] = get_channel_data(timeSeriesFile, 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05');
% titlestr = strcat('Synthetic data, scaling factor 0.05');

% timeSeriesFile = '../../../data/TimeSeries/NCSN/synthetic.deci5.12hr.24.36.amp0.03.NC.CCOB.EHN.D.SAC.bp4to10';
% [t, x, samplingRate] = get_channel_data(timeSeriesFile, 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03');
% titlestr = strcat('Synthetic data, scaling factor 0.03');

timeSeriesFile = '../../../data/TimeSeries/NCSN/synthetic.deci5.12hr.24.36.amp0.01.NC.CCOB.EHN.D.SAC.bp4to10';
[t, x, samplingRate] = get_channel_data(timeSeriesFile, 'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01');
titlestr = strcat('Synthetic data, scaling factor 0.01');

t_hr = t/3600;

% Plot synthetic data
figure
set(gca,'FontSize',16);
plot(t_hr, x);
xlabel('Time (hr)');
ylabel('Amplitude');
xlim([0 12]);
ylim([-60 60]);
title(titlestr);
% title('Noise section from CCOB.EHN 2011-01-09, 12 hours');