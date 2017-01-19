function [t,syntheticNoisyData,insertTimes] = synthetic_waveform_data()
% Generates synthetic earthquake waveform data
% (which can subsequently be used in autocorrelation, fingerprint, etc)
%
% Contains repeating earthquake signal, non-repeating earthquake signal,
% and additive white Gaussian noise (can vary SNR)
%
% Outputs
% t:                  time at each sample in synthetic data (s)
% syntheticNoisyData: synthetic earthquake time series data
% insertTimes:        start times where repeating signal was inserted (s)
%

% Read in real earthquake data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_01hr');
dataDuration = 3600; % time series length (s)

% Extract earthquake signal
startTime = 1625; % start time of signal to extract (s)
endTime = 1645; % end time of signal to extract (s)
startSample = startTime*samplingRate;
endSample = endTime*samplingRate;
timeSignal = t(startSample:endSample); % earthquake signal window times (s)
quakeSignal = x(startSample:endSample); % extracted earthquake signal window
signalLength = endSample - startSample + 1; % number of samples in extracted signal

% initialize synthetic data time series (same length as original data)
numSamples = length(x);
syntheticData = zeros(numSamples,1); % initialize to all 0's
% syntheticData = eps*ones(numSamples,1); % initialize to small epsilon

% scaleFactors = [0.25 0.5 1.0 1.5 2.0]; % amplitude scale factors for earthquake signal
scaleFactors = ones(1,5); % amplitude scale factors are all 1
numRepeats = length(scaleFactors); % number of times to insert repeating earthquake signal
rng(200); % set random number seed so that we always insert repeating signal at same locations
insertTimes = randi([1, dataDuration], numRepeats, 1) % times (s) at which to insert earthquake signal
insertIndices = samplingRate * insertTimes; % indices at which to insert earthquake signal

% insert earthquake signal into synthetic data
for k=1:numRepeats
    startIndex = insertIndices(k);
    endIndex = startIndex + signalLength - 1;
    syntheticData(startIndex:endIndex) = scaleFactors(k)*quakeSignal(:);
end

% Extract non-repeating (non-similar) earthquake signal
nonRepeatStartTime = 3520; % start time of non-repeat signal to extract (s)
nonRepeatEndTime = 3540; % end time of non-repeat signal to extract (s)
nonRepeatStartSample = nonRepeatStartTime*samplingRate;
nonRepeatEndSample = nonRepeatEndTime*samplingRate;
nonRepeatLength = nonRepeatEndSample - nonRepeatStartSample + 1;
nonRepeatTimes = t(nonRepeatStartSample:nonRepeatEndSample);
nonRepeatSignal = x(nonRepeatStartSample:nonRepeatEndSample);

% insert non-repeating (non-similar) earthquake signal
% in same location in synthetic data
syntheticData(nonRepeatStartSample:nonRepeatEndSample) = nonRepeatSignal;

% Add white Gaussian noise to synthetic data, vary noise level using
% different SNR values (dB)
% noiseSNRdB = 10;
% noiseSNRdB = 0;
noiseSNRdB = -10;
% noiseSNRdB = -12; % all detections
% noiseSNRdB = -13; % all detections (reduced prob)
% noiseSNRdB = -14; % only 2 detections
% noiseSNRdB = -16; % only 2 detections (reduced prob)
% noiseSNRdB = -17; % no detections
% noiseSNRdB = -20; % no detections
syntheticNoisyData = awgn(syntheticData, noiseSNRdB, 'measured');
% syntheticNoisyData = syntheticData;

% Plot synthetic data
flag_plot_synthetic = 0;
if (flag_plot_synthetic)
    figure
    set(gca,'FontSize',18);
    plot(timeSignal, quakeSignal)
    xlabel('time (s)');
    title('earthquake signal - repeating (1625 s to 1645 s)');
    xlim([startTime-5 endTime+5]); ylim([-80 80]);

    figure
    set(gca,'FontSize',18);
    plot(nonRepeatTimes, nonRepeatSignal)
    xlabel('time (s)');
    title('earthquake signal - non-repeating (3520 s to 3540 s)');
    xlim([nonRepeatStartTime-5 nonRepeatEndTime+5]); ylim([-80 80]);

    figure
    set(gca,'FontSize',18);
    plot(t,syntheticData)
    xlabel('time (s)');
    title('raw repeated signal');
    ylim([-80 80]);

    figure
    set(gca,'FontSize',18);
    plot(t,syntheticNoisyData)
    xlabel('time (s)');
    title(['repeated signal with white noise, SNR ' num2str(noiseSNRdB) ' dB']);
    ylim([-80 80]);
end

end

