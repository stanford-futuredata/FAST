close all
clear

% NCSN_Calaveras_7ch_24hr (haar_coefficients, keep 800 coefficients per channel)
ncsn.detections = [37 39]; % [autocorrelation fpss] number of detections
figure
bar(ncsn.detections);
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 40]);
ylabel('Number of detected events');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'       FAST     ';'                ']);
title('Detection Performance');
% text(0.7, 60, '58 earthquakes', 'FontSize', 16);
% text(1.7, 60, '58 earthquakes', 'FontSize', 16);
text(0.95, 20, '37', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.95, 20, '39', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.63, 15, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.63, 15, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');

ncsn.runtime.spectrogram = [8 8 8 8 8 8 8];
ncsn.runtime.wavelet = [44.9375 44.6077 45.4683 44.1139 43.5003 44.0073 45.4753 56.5572 45.5614 ...
    45.7758 48.1443 44.7065 44.7347 45.2605 50.7609 51.4546 44.3982 42.3639 ...
    42.5642 46.61 48.7261];
ncsn.runtime.fingerprint = [160.1626 47.5761 60.6864 85.431 36.9516 46.6987 35.4187];
% ncsn.runtime.minhash = [102.88 103.28 110.18 131.14 92.29 92.71 119.45]; % old_votesbug
% ncsn.runtime.database = [5.08 7.55 26.05 13.55 5.47 6.14 34.12]; % old_votesbug
% ncsn.runtime.search = [59.74 58.72 65.13 45.65 40.19 40.46 46.97]; % old_votesbug
% ncsn.runtime.network = [2.4826 0.88475 8.28 0.95 0.39591]; % old_votesbug
ncsn.runtime.minhash = [121.07 119.78 112.11 123.43 116.79 119.97 121.09];
ncsn.runtime.database = [5.74 5.7 6.05 6.18 5.9 6.24 6.07];
ncsn.runtime.search = [63.46 59 67.07 47.2 42.22 40.87 48.74];
ncsn.runtime.network = [5.5503 2.496 17.65 1.42];
ncsn.runtime.total = sum(ncsn.runtime.spectrogram) + sum(ncsn.runtime.wavelet) + ...
    sum(ncsn.runtime.fingerprint) + sum(ncsn.runtime.minhash) + sum(ncsn.runtime.database) + ...
    sum(ncsn.runtime.search) + sum(ncsn.runtime.network);

ncsn.runtimes = [31+25/60 ncsn.runtime.total/3600]; % [autocorrelation fpss] runtime (hr)
speedup = ncsn.runtimes(1)/ncsn.runtimes(2) % speedup factor

figure
bar(ncsn.runtimes, 'r');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 36]);
ylabel('Runtime (hr)');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'       FAST     ';'                ']);
set(gca, 'YTick', [0:4:36]);
set(gca,'YTickLabel', [' 0';' 4';' 8';'12';'16';'20';'24';'28';'32';'36']);
title('Runtime Performance, 1 processor');
% text(0.6, 32.5, '31 hours 25 minutes', 'FontSize', 16);
% text(1.8, 2, '45 minutes', 'FontSize', 16);
text(0.75, 20, '31 hours', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.7, 17, '25 minutes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.7, 3, '46 minutes', 'FontSize', 22, 'FontWeight', 'bold');

% NCSN_CCOB_EHN_1wk
ncsn.detections = [86 89]; % [ac.eq ac.lfe; fpss.eq fpss.lfe] number of detections
figure
bar(ncsn.detections,'stacked');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylabel('Number of detected events');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'       FAST     ';'                ']);
title('Detection Performance');
% text(0.7, 5, '12 earthquakes', 'FontSize', 16, 'color', 'w');
% text(0.85, 20, '15 LFEs', 'FontSize', 16, 'color', 'w');
% text(1.7, 5, '10 earthquakes', 'FontSize', 16, 'color', 'w');
% text(1.85, 20, '20 LFEs', 'FontSize', 16, 'color', 'w');
text(0.95, 45, '86', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.95, 45, '89', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.63, 35, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(1.63, 35, 'earthquakes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');

% FPSS runtimes
ncsn.runtime.spectrogram = [3.3935 2.9526 2.9289 2.9241 2.9238 2.9336 2.9446 2.9441 2.9367 2.9852 ...
    2.9362 2.854 2.9184 2.9477 2.9371 2.9508 2.9365 2.9303 2.9456 2.8725 2.8356];
ncsn.runtime.wavelet = [55.8768 55.9507 56.1847 55.9518 55.9249 56.1811 56.5656 56.6883 56.5017 55.8517 ...
     55.442 55.3529 55.3936 55.4441 55.4778 55.4377 55.4341 55.3814 55.1606 55.4019 55.3372];
ncsn.runtime.fingerprint = [949.2784];
% ncsn.runtime.minhash = [609.03]; % old_votesbug
% ncsn.runtime.database = [26.61]; % old_votesbug
% ncsn.runtime.search = [2353.9]; % old_votesbug
ncsn.runtime.minhash = [616.05];
ncsn.runtime.database = [26.97];
ncsn.runtime.search = [2959.0];
ncsn.runtime.total = sum(ncsn.runtime.spectrogram) + sum(ncsn.runtime.wavelet) + ...
    sum(ncsn.runtime.fingerprint) + sum(ncsn.runtime.minhash) + sum(ncsn.runtime.database) + ...
    sum(ncsn.runtime.search);

% Autocorrelation runtimes
ncsn.ac.onechannel = 51674.1246991158*16; % autocorrelation runtime (1 channel), (s), times number of processors
ncsn.ac.total = ncsn.ac.onechannel;

% Total runtimes (days)
ncsn.runtimes = [ncsn.ac.total ncsn.runtime.total]/(3600*24); % [autocorrelation fpss] runtime (days)
speedup = ncsn.runtimes(1)/ncsn.runtimes(2) % speedup factor

figure
bar(ncsn.runtimes, 'r');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
ylim([0 10]);
ylabel('Runtime (days)');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'       FAST     ';'                ']);
% set(gca, 'YTick', [0:1:8]);
title('Runtime Performance, 1 processor');
% text(0.7, 6.8, '6 days 13 hours', 'FontSize', 16);
% text(1.65, 0.3, '1 hour 42 minutes', 'FontSize', 16);
text(0.8, 5.8, '9 days', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
text(0.73, 5.0, '13 hours', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
% text(1.8, 1.2, '1 hour', 'FontSize', 22, 'FontWeight', 'bold'); % old_votesbug
% text(1.7, 0.4, '26 minutes', 'FontSize', 22, 'FontWeight', 'bold'); % old_votesbug
text(1.8, 1.4, '1 hour', 'FontSize', 22, 'FontWeight', 'bold');
text(1.7, 0.6, '36 minutes', 'FontSize', 22, 'FontWeight', 'bold');