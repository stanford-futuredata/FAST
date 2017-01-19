close all
clear

% Plot original data used to create synthetic data

% % Read in data from NCSN, station CCOB, channel EHN, 1 week, decimated 5 times
% % Band pass filter 4-10 Hz
path(path,'./MatSAC');
% [t_all,x_all,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
% Fs = 20;
% 
% % "noise" section: between hours 24 and 36 (low noise level)
% noise_hr_start = 24;
% noise_hr_end = 36;
% 
% % Get "noise" section from data
% inoise_start = noise_hr_start*3600*Fs;
% inoise_end = noise_hr_end*3600*Fs;
% x = x_all(inoise_start:inoise_end);
% t = [0:0.05:43200]';
% titlestr = 'Noise section from CCOB.EHN 2011-01-09, 12 hours';


% Read in synthetic data with inserted signal
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.05.NC.CCOB.EHN.D.SAC.bp4to10');
% titlestr = strcat('Synthetic data, scaling factor 0.05');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.03.NC.CCOB.EHN.D.SAC.bp4to10');
% titlestr = strcat('Synthetic data, scaling factor 0.03');
[t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.01.NC.CCOB.EHN.D.SAC.bp4to10');
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