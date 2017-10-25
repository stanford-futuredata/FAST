% Script to call after data has been read in - plot all 3 components,
% observe existence of time shift (sac merge) or no time shift (combine_sac_time_series.m)

addpath('../../Utilities/SAC/');

% No time shift:
% [t, x.e, hdr.e] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHE_CustBP_1_30_bp1to20.SAC');
% [t, x.n, hdr.n] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHN_CustBP_1_30_bp1to20.SAC');
% [t, x.z, hdr.z] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHZ_CustBP_1_30_bp1to20.SAC');

% Time shift:
% [t, x.e, hdr.e] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHE_BP_1_30_bp1to20.SAC');
% [t, x.n, hdr.n] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHN_BP_1_30_bp1to20.SAC');
% [t, x.z, hdr.z] = fread_sac('../../../data/TimeSeries/WHAR/20100601_20100831_HHZ_BP_1_30_bp1to20.SAC');

% t = [0:0.01:7948801];
% t = t(1:end-1);

Fs = 100; % sampling rate

% % Plot entire waveform
% event_times = [3080970, 7763443.54, 7832974.97, 7852414.24, 7911505.18, 7926345.27]; % event times (s)
% ns = 400; % number of samples in window
% savestr = 'notimeshift_waveform_';
% % savestr = 'timeshift_waveform_';

% Plot P-wave arrival
% event_times = [3080971.8, 7763443.74, 7832975.17, 7852414.44, 7911505.38, 7926345.47]; % event times (s)
% ns = 50; % number of samples in window
savestr = '../../../figures/WHAR/notimeshift_pwave_';
% savestr = '../../../figures/WHAR/timeshift_pwave_';

event_times = [250764.48, 504365.96, 3101083, 3926294.22, 4341748.2, 5101461.07, 5734578.36, 6032303.95, 7667516.53]
% ns = 150; % pick P arrival time and index
ns = 500; % pick S arrival time and index

% figure
for k=1:numel(event_times)
    s = event_times(k)*Fs + 1;
    figure
    set(gca,'FontSize',14);
%     plot(t(s:s+ns), x.e(s:s+ns), 'r', t(s:s+ns), x.n(s:s+ns), 'b', ...
%         t(s:s+ns), x.z(s:s+ns), 'k'); % plot entire waveform
    plot(t(s:s+ns), x.e(s:s+ns), 'ro-', t(s:s+ns), x.n(s:s+ns), 'bo-', ...
        t(s:s+ns), x.z(s:s+ns), 'ko-'); % plot p-wave arrival
    legend('HHE', 'HHN', 'HHZ', 'Location', 'Southwest');
    xlabel('Time since 2010-06-01 00:00:00 (s)');
    ylabel('Amplitude');
    title(['Start time = ', num2str(event_times(k)), ' s']);
    xlim([t(s) t(s+ns)]);
    
    tval = t(s:s+ns);
    east = x.e(s:s+ns);
    north = x.n(s:s+ns);
    up = x.z(s:s+ns);
%     print(strcat(savestr, num2str(event_times(k)), '.eps'), '-depsc');
end
