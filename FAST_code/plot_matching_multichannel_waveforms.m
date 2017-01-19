function [] = plot_matching_multichannel_waveforms(t, x, samplingRate, ...
    titlestr, start_time, window_duration)

s = size(x);
nch = s(2);

first_sample = start_time*samplingRate;
last_sample = (start_time+window_duration)*samplingRate;

% Plot all seismograms
xmin = start_time;
xmax = start_time+window_duration;
% FigHandle = figure('Position',[2000 100 400 1000]);
% FigHandle = figure('Position',[2000 100 400 400]);
set(gcf,'PaperPositionMode','auto');
for k=1:nch
    subplot(nch,1,k); %set(gca,'FontSize',16);
    plot(t, x(:,k)); xlim([xmin xmax]); title(titlestr{k});
end
xlabel('Time (s)');

end