function [] = plot_matching_waveforms_all_components(t, x, samplingRate, start_time, window_duration)

first_sample = start_time*samplingRate;
last_sample = (start_time+window_duration)*samplingRate;

% Plot all seismograms
xmin = start_time;
xmax = start_time+window_duration;
FigHandle = figure('Position',[150 150 400 1024]);
subplot(3,1,1); set(gca,'FontSize',16);
plot(t(first_sample:last_sample), x.e(first_sample:last_sample));
title('CCOB.EHE'); xlim([xmin xmax]);
subplot(3,1,2); set(gca,'FontSize',16);
plot(t(first_sample:last_sample), x.n(first_sample:last_sample));
title('CCOB.EHN'); xlim([xmin xmax]);
subplot(3,1,3); set(gca,'FontSize',16);
plot(t(first_sample:last_sample), x.z(first_sample:last_sample));
title('CCOB.EHZ'); xlim([xmin xmax]);
xlabel('Time (s)');

end