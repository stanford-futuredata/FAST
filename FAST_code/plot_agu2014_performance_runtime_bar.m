close all
clear

% NCSN_Calaveras_7ch_24hr (haar_coefficients, keep 800 coefficients per channel)
ncsn.detections = [58 58]; % [autocorrelation fpss] number of detections
figure
bar(ncsn.detections);
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 70]);
ylabel('Number of detected events');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'Efficient Search';'                ']);
title('Detection Performance');
% text(0.7, 60, '58 earthquakes', 'FontSize', 16);
% text(1.7, 60, '58 earthquakes', 'FontSize', 16);
text(0.95, 40, '58', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.95, 40, '58', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.63, 32, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.63, 32, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');

ncsn.runtime.spectrogram = [8 8 8 8 8 8 8];
ncsn.runtime.wavelet = [44.9375 44.6077 45.4683 44.1139 43.5003 44.0073 45.4753 56.5572 45.5614 ...
    45.7758 48.1443 44.7065 44.7347 45.2605 50.7609 51.4546 44.3982 42.3639 ...
    42.5642 46.61 48.7261];
ncsn.runtime.fingerprint = [160.1626 47.5761 60.6864 85.431 36.9516 46.6987 35.4187];
ncsn.runtime.minhash = [102.88 103.28 110.18 131.14 92.29 92.71 119.45];
ncsn.runtime.database = [5.08 7.55 26.05 13.55 5.47 6.14 34.12];
ncsn.runtime.search = [59.74 58.72 65.13 45.65 40.19 40.46 46.97];
ncsn.runtime.network = [2.4826 0.88475 8.28 0.95 0.39591];
ncsn.runtime.total = sum(ncsn.runtime.spectrogram) + sum(ncsn.runtime.wavelet) + ...
    sum(ncsn.runtime.fingerprint) + sum(ncsn.runtime.minhash) + sum(ncsn.runtime.database) + ...
    sum(ncsn.runtime.search) + sum(ncsn.runtime.network);

ncsn.runtimes = [31+25/60 ncsn.runtime.total/3600]; % [autocorrelation fpss] runtime (hr)
figure
bar(ncsn.runtimes, 'r');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 36]);
ylabel('Runtime (hr)');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'Efficient Search';'                ']);
set(gca, 'YTick', [0:4:36]);
set(gca,'YTickLabel', [' 0';' 4';' 8';'12';'16';'20';'24';'28';'32';'36']);
title('Runtime Performance, 1 processor');
% text(0.6, 32.5, '31 hours 25 minutes', 'FontSize', 16);
% text(1.8, 2, '45 minutes', 'FontSize', 16);
text(0.75, 20, '31 hours', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.7, 17, '25 minutes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.7, 3, '45 minutes', 'FontSize', 22, 'FontWeight', 'bold');

% HRSN_20071026_12ch_24hr
hrsn.detections = [12 15; 10 20]; % [ac.eq ac.lfe; fpss.eq fpss.lfe] number of detections
figure
bar(hrsn.detections,'stacked');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylabel('Number of detected events');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'Efficient Search';'                ']);
title('Detection Performance');
% text(0.7, 5, '12 earthquakes', 'FontSize', 16, 'color', 'w');
% text(0.85, 20, '15 LFEs', 'FontSize', 16, 'color', 'w');
% text(1.7, 5, '10 earthquakes', 'FontSize', 16, 'color', 'w');
% text(1.85, 20, '20 LFEs', 'FontSize', 16, 'color', 'w');
text(0.95, 7, '12', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.95, 7, '10', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.63, 4, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.63, 4, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.76, 20, '15 LFEs', 'color', 'w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.76, 20, '20 LFEs', 'color', 'w', 'FontSize', 22, 'FontWeight', 'bold');

hrsn.runtime.spectrogram = [3.8631 3.4563 57.4579 3.7922 24.3682 3.5397 4.2053 4.3396 26.6527 ...
    3.6298 3.6564 3.7467 3.4866 3.6412 4.0692 6.2675 4.1815 3.8959 ...
    5.0944 3.9393 3.9527 24.7017 36.6631 26.9275 3.8181 3.747 3.8188 ...
    239.7128 111.2959 129.6036 3.4615 3.4586 3.4933 27.1881 39.7071 37.3396];
hrsn.runtime.wavelet = [89.4223 89.9816 89.265 89.9061 89.4072 90.1905 89.5522 89.9821 89.2737 ...
    89.5588 89.4206 89.4618 89.5731 89.0435 89.0887 89.6987 89.5564 90.5327 ...
    89.9835 89.2437 89.5601 89.7669 89.5984 89.5813 90.0443 89.6265 89.6411 ...
    90.0925 89.9601 89.5342 89.4693 89.4693 89.6104 89.6552 90.2843 89.0497];
hrsn.runtime.fingerprint = [63.236 63.236 63.236 63.8826 64.2856 63.9347 64.1832 63.5942 63.6837 ...
    63.7305 63.8942 63.7744];
hrsn.runtime.minhash = [62.25 62.25 62.25 62.57 60.33 60.12 59.94 59.88 61.97 63.13 61.49 61.89];
hrsn.runtime.database = [13.08 13.08 13.08 15.55 12.31 15.96 12.11 11.94 12.04 15.76 14.59 11.99];
hrsn.runtime.search = [22.09 22.09 22.09 29.31 28.71 28.14 25.59 30.32 28.42 25.94 31.08 21.43];
hrsn.runtime.network = [2.0962 0.36423 2.04 0.78 7.383];
hrsn.runtime.total = sum(hrsn.runtime.spectrogram) + sum(hrsn.runtime.wavelet) + ...
    sum(hrsn.runtime.fingerprint) + sum(hrsn.runtime.minhash) + sum(hrsn.runtime.database) + ...
    sum(hrsn.runtime.search) + sum(hrsn.runtime.network);

hrsn.ac.onechannel = 362*128; % autocorrelation runtime (1 channel), (s), times number of processors
hrsn.ac.nch = 12;
hrsn.ac.network = [59.2528 6.8961 695.61 863.31 73.1444 66.0154 6.6731 406.69 541.22 87.4471 ...
    44.7908 6.7085 406.2 531.13 105.3008 38.4908 6.4369 376.41 501.67 71.7922 ...
    2*178.318 2*8.3851 2*840.79 2*813.73 2*174.5491 411.5968 24.3234 1382.72 371.16 34.9043];
hrsn.ac.total = hrsn.ac.onechannel*hrsn.ac.nch + sum(hrsn.ac.network);

hrsn.runtimes = [hrsn.ac.total hrsn.runtime.total]/(3600*24); % [autocorrelation fpss] runtime (days)
figure
bar(hrsn.runtimes, 'r');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 8]);
ylabel('Runtime (days)');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'Efficient Search';'                ']);
set(gca, 'YTick', [0:1:8]);
title('Runtime Performance, 1 processor');
% text(0.7, 6.8, '6 days 13 hours', 'FontSize', 16);
% text(1.65, 0.3, '1 hour 42 minutes', 'FontSize', 16);
text(0.8, 5.8, '6 days', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.73, 5.1, '13 hours', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.8, 1.2, '1 hour', 'FontSize', 22, 'FontWeight', 'bold');
text(1.7, 0.5, '42 minutes', 'FontSize', 22, 'FontWeight', 'bold');