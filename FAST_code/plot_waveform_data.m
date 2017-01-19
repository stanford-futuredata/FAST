function [] = plot_waveform_data(t, x, firstSample, lastSample, filterFlag)
% Plots sections of waveform data from firstSample to lastSample

if (filterFlag)
    titleString = 'bandpass 1-10 Hz';
else
    titleString = '0-10 Hz';
end

figure
set(gca,'FontSize',18)
plot(t(firstSample:lastSample), x(firstSample:lastSample));
xlabel('Time (s)'); ylabel('Amplitude');
xlim([round(t(firstSample)) round(t(lastSample))]);
% ylim([-200 200]);
% ylim([-1e-6 1e-6]);
% ylim([-1e-7 1e-7]);
% ylim([-1e-8 1e-8]);
title(['AZ KNW data, ' num2str(round(t(firstSample)/3600)) '-' ...
    num2str(round(t(lastSample)/3600)) ' hr, ' titleString]);

end