close all
clear

% NCSN_CCOB_EHN_1wk (haar_coefficients, keep 800 coefficients per channel)

% FAST runtimes
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
ncsn.runtimes = [ncsn.ac.total ncsn.runtime.total]/(3600*24); % [autocorrelation fast] runtime (days)
speedup = ncsn.runtimes(1)/ncsn.runtimes(2) % speedup factor

%ncsn.runtimes = [31+25/60 ncsn.runtime.total/3600]; % [autocorrelation fast] runtime (hr)
figure
bar(ncsn.runtimes, 'r');
set(gca, 'FontSize', 22, 'FontWeight', 'bold');
xlim([0.5 2.5]);
% ylim([0 36]);
ylabel('Runtime (days)');
set(gca, 'XTick', [0:3]);
set(gca,'XTickLabel', ['                ';'Autocorrelation ';'Efficient Search';'                ']);
% set(gca, 'YTick', [0:4:36]);
% set(gca,'YTickLabel', [' 0';' 4';' 8';'12';'16';'20';'24';'28';'32';'36']);
title('Runtime Performance, 1 processor');
% text(0.6, 32.5, '31 hours 25 minutes', 'FontSize', 16);
% text(1.8, 2, '45 minutes', 'FontSize', 16);
% text(0.75, 20, '31 hours', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
% text(0.7, 17, '25 minutes', 'color','w', 'FontSize', 22, 'FontWeight', 'bold');
% text(1.7, 3, '45 minutes', 'FontSize', 22, 'FontWeight', 'bold');


% NCSN_CCOB_EHN_1wk (haar_coefficients, keep 800 coefficients per channel)
% Make pie chart for runtime breakdown

run_times = [sum(ncsn.runtime.spectrogram) + sum(ncsn.runtime.wavelet) + ...
    sum(ncsn.runtime.fingerprint), sum(ncsn.runtime.minhash) + sum(ncsn.runtime.database), ...
    sum(ncsn.runtime.search)]; % (s)
labels = {'Feature Extraction: ', 'Database Generation: ', ...
    'Similarity Search: '}';
explode = [1,1,1];

figure
set(gca,'FontSize',16);
h = pie(run_times, explode);
hText = findobj(h, 'Type', 'text');
percentValues = get(hText, 'String');
combined_labels = strcat(labels, percentValues);
oldExtents_cell = get(hText, 'Extent'); % cell array
oldExtents = cell2mat(oldExtents_cell); % numeric array
set(hText,{'String'},combined_labels);

hp = findobj(h, 'Type', 'patch');
set(hp(1), 'FaceColor', 'g');
set(hp(2), 'FaceColor', 'b');
set(hp(3), 'FaceColor', 'r');

set(h(2:2:6), 'FontSize', 16);

title(['CCOB.EHN 1 week, total runtime = ', num2str(ncsn.runtime.total/3600) ' hours']);
