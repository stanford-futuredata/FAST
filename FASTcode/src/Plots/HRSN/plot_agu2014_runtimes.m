close all
clear

% Make computational scaling plot
x = logspace(0,10,1000); % number of data points, 10^0 to 10^10
% x_scaled = x/226;
% ind_day = find(abs(x-86400) == min(abs(x-86400))) % 86400 s = 1 day
% ind_day = 494

oneDaySec = 24*60*60;
oneWeekSec = oneDaySec*7;
oneMonthSec = oneDaySec*30;
oneYearSec = oneDaySec*365;
tenYearSec = oneYearSec*10;

% runtime_networksim_7ch_24hr = 3189; % runtime network similarity, 7 channels, 1 day (s) - top 200 magnitude coeff
% runtime_networksim_7ch_24hr = 2718; % runtime network similarity, 7 channels, 1 day (s) - top 800 deviation coeff
% scale_factor = oneDaySec / runtime_networksim_7ch_24hr;
runtime_networksim_12ch_24hr = 6095; % runtime network similarity, 12 channels, 1 day HRSN (s) - top 200 deviation coeff
scale_factor = oneDaySec / runtime_networksim_12ch_24hr;
x_scaled = x / scale_factor;
runtimeFingerprint = x_scaled; % O(n)

ind_day = find(abs(x-oneDaySec) == min(abs(x-oneDaySec)))
% runtime_autocorr_7ch_24hr = 113393; % runtime autocorr, 7 channels, 1 day NCSN (s)
% scale_autocorr = x_scaled(ind_day)^2 / runtime_autocorr_7ch_24hr;
runtime_autocorr_12ch_24hr = 567183; % runtime autocorr, 12 channels, 1 day HRSN (s)
scale_autocorr = x_scaled(ind_day)^2 / runtime_autocorr_12ch_24hr;

runtimeAutocorr = (x_scaled.*x_scaled) / scale_autocorr; % O(n^2)
% runtimeParallelAutocorr = runtimeAutocorr/1000; % assume 1000 processors

% Check:
runtimeFingerprint(ind_day)
runtimeAutocorr(ind_day)
speedup_1day = runtimeAutocorr(ind_day)/runtimeFingerprint(ind_day);
disp(['1 day duration runtime speedup = ', num2str(speedup_1day)]);

ind_1week = find(abs(x-oneWeekSec) == min(abs(x-oneWeekSec)));
speedup_1week = runtimeAutocorr(ind_1week)/runtimeFingerprint(ind_1week);
disp(['expected 1 week duration runtime speedup = ', num2str(speedup_1week)]);

ind_1month = find(abs(x-oneMonthSec) == min(abs(x-oneMonthSec)));
speedup_1month = runtimeAutocorr(ind_1month)/runtimeFingerprint(ind_1month);
disp(['expected 1 month duration runtime speedup = ', num2str(speedup_1month)]);

ind_1yr = find(abs(x-oneYearSec) == min(abs(x-oneYearSec)));
% runtimeFingerprint(ind_1yr)
% runtimeAutocorr(ind_1yr)
speedup_1yr = runtimeAutocorr(ind_1yr)/runtimeFingerprint(ind_1yr);
disp(['expected 1 year duration runtime speedup = ', num2str(speedup_1yr)]);

ind_tenyr = find(abs(x-tenYearSec) == min(abs(x-tenYearSec)));
speedup_tenyr = runtimeAutocorr(ind_tenyr)/runtimeFingerprint(ind_tenyr);
disp(['expected 10 year duration runtime speedup = ', num2str(speedup_tenyr)]);

FigHandle = figure('Position',[1500 100 1000 1000]);
% loglog(x,runtimeAutocorr,'k', x,runtimeParallelAutocorr,'b', ...
%     x,runtimeFingerprint,'r','LineWidth',2);
loglog(x,runtimeAutocorr,'k', x,runtimeFingerprint,'r','LineWidth',4);
set(gca,'FontSize',24,'FontWeight','bold');
box on
xlabel('Data duration (s)');
ylabel('Runtime (s)');
xlim([1e3 1e9])
set(gca, 'XTick', [10^3 10^4 10^5 10^6 10^7 10^8 10^9]);
title('Extrapolated runtimes based on scaling');
% legend('Autocorrelation, 1 processor','Autocorrelation, 1000 processors', ...
%     'Fingerprint, 1 processor');
legend('Autocorrelation, 1 processor','Efficient Search, 1 processor', 'Location', 'NorthWest');

% make all text in figure size 24, bold
set(findall(FigHandle,'type','text'), 'FontSize', 24, 'FontWeight', 'bold');