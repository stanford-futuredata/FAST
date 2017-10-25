% Fingerprint generation prototype on 1 hr data
% Calaveras Fault, NCSN, station CCOB, 2011/01/08 00:00:00 to 01:00:00
% Clara Yoon, 2013-07-12
%
% Usage (last 5 input arguments are optional, defaults are provided):
%  [binaryFingerprint, dt_fp] = data_1hr_fingerprint(specData, specSettings, x,
%     bandStartIndex, bandEndIndex, fingerprintLength, fingerprintLag, t_value);
%
% Inputs
% specData:          Spectrogram (specData.P)
%                    Time samples (specData.T)
%                    Frequency samples (specData.F)
% specSettings:      Parameters related to spectrogram formation - struct
% x:                 Time series data
%
% Inputs (optional)
% bandStartIndex:    index of lowest frequency in band
% bandEndIndex:      index of highest frequency in band
% fingerprintLength: number of time samples in spectral image
% fingerprintLag:    number of lag samples in spectral image
% t_value:           number of wavelet values to keep
%
% Outputs
% binaryFingerprint: All fingerprints from data, logical(numbits,NWindows)
%                    numbits: Number of bits in each fingerprint
%                    NWindows: Number of fingerprints (windows)
% dt_fp:             Time lag between adjacent fingerprints (s)
% 

function [binaryFingerprint, dt_fp] = data_1hr_fingerprint(specData, ...
    specSettings, x, varargin)

s = size(specData.P);

% Default values for input parameters
default_bandStartIndex = 1; % index of lowest frequency in band
% default_bandStartIndex = 21; % index of lowest frequency in band
default_bandEndIndex = s(1); % index of highest frequency in band
% default_fingerprintLength = 256; % number of time samples in spectral image
default_fingerprintLength = 100; % number of time samples in spectral image
% default_fingerprintLag = 128; % number of lag samples in spectral image
% default_fingerprintLag = 20; % number of lag samples in spectral image
default_fingerprintLag = 10; % number of lag samples in spectral image
default_t_value = 200; % number of wavelet values to keep

% Only want 5 optional inputs at most
if (nargin > 8)
    error('must not have more than 8 input parameters');
end

% Set defaults for optional inputs
optargs = {default_bandStartIndex ...
    default_bandEndIndex default_fingerprintLength, ...
    default_fingerprintLag, default_t_value};

% Overwrite defaults with optional inputs
optargs(1:nargin-3) = varargin;

% Place optional inputs in variables
[bandStartIndex, bandEndIndex, ...
    fingerprintLength, fingerprintLag, t_value] = optargs{:};

% Time lag between adjacent fingerprints (s) - output
dt_fp = fingerprintLag * specSettings.lagTime;

%%% END OF INPUT SECTION

% Need paths for wavelet transform
addpath('mdwt');
addpath('mdwt/cwl_lib');

% power spectral density of band passed 4-10 Hz spectrogram
dim_P = size(specData.P);
nfreqDS = 32;
filtspec = imresize(specData.P, [nfreqDS dim_P(2)], 'bilinear');

filtfreq = specData.F(bandStartIndex:bandEndIndex);

flag_plot_spectrogram = 0;
if (flag_plot_spectrogram)
    % Plot power spectral density of spectrogram, log10 units
    figure
    set(gca, 'FontSize', 18)
    imagesc(specData.T, specData.F, log10(specData.P))
    set(gca, 'YDir', 'normal');
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    title('log_{10}(|spectrogram|^2)')
    c1=colorbar; set(c1,'FontSize',18);
    set(gca,'xticklabel',num2str(get(gca,'xtick')'))
%     caxis([-5 5])

    % Plot magnitude of band passed 4-10 Hz spectrogram, log10 units
    figure
    set(gca, 'FontSize', 18)
    imagesc(specData.T, filtfreq, log10(filtspec))
    set(gca, 'YDir', 'normal');
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    title('log_{10}(|spectrogram|^2)')
    c1=colorbar; set(c1,'FontSize',18);
    set(gca,'xticklabel',num2str(get(gca,'xtick')'))
%     caxis([-5 5])
end

% clear up memory
clear specData.P;
clear specData.T;

% Divide up spectrogram into spectral images

% Spectral image window parameters to tune
%  - try 4x time window duration, as in Baluja/Covell
fingerprintDuration = fingerprintLength * specSettings.lagTime; % length of spectral image window (s)

dim_spec = size(filtspec); % use filtered spectrogram
nfreq_spec = dim_spec(1); % number of frequency bins in spectrogram
ntime_spec = dim_spec(2); % number of time samples in spectrogram

% Get number of spectral image windows, starting and ending indices
[NWindows, window_start_index, window_end_index] = ...
    get_window_parameters(ntime_spec, 0, fingerprintLength, fingerprintLag);

% Downsample - spectral image dimensions need to be power of 2
nfreqPow2 = get_downsample_power_2(nfreq_spec);
fpLengthPow2 = get_downsample_power_2(fingerprintLength);

% Get downsampled frequency values
dfreq_ds = (specData.F(bandEndIndex) - specData.F(bandStartIndex))/(nfreqPow2-1);
freq_ds_indices = [0:nfreqPow2-1];
freq_ds_values = dfreq_ds*freq_ds_indices + specData.F(bandStartIndex);

% Get downsampled time dimension indices in fingerprint
dt_ds = fingerprintDuration / (fpLengthPow2-1);
fp_ds_indices = [0:fpLengthPow2-1];
fp_ds_values = dt_ds*fp_ds_indices;

% Allocate arrays for spectral images
specImages = zeros(nfreqPow2, fpLengthPow2, NWindows);
haarImages = zeros(nfreqPow2, fpLengthPow2, NWindows);

flag_store_waveforms = 0;
if (flag_store_waveforms)
    imageWaveforms = zeros(specSettings.wnd_len, fingerprintLength, NWindows);
end

% Keep the sign of the top 200 values of wavelet (sorted by magnitude), set rest to 0
topWaveletImages = zeros(nfreqPow2, fpLengthPow2, NWindows, 'double');
numPointsFP = nfreqPow2*fpLengthPow2;
numbits = 2*numPointsFP; % number of elements in fingerprint bit representation
binaryFingerprint = false(numbits, NWindows); % fingerprints (sign of top wavelets) as bits

% Loop over windows
time = tic;
for k=1:NWindows
    if (flag_store_waveforms)
        % Save waveforms (time windows) that go into each spectral image for visualization
        first_ind = window_start_index(k) - 1;
        last_ind = window_start_index(k)+fingerprintLength-1 - 1;
        index_start_timewindow = [first_ind:last_ind]*(specSettings.wnd_len-specSettings.noverlap) + 1;
        index_end_timewindow = index_start_timewindow + specSettings.wnd_len - 1;
        for ifp=1:fingerprintLength
            imageWaveforms(:,ifp,k) = x(index_start_timewindow(ifp):index_end_timewindow(ifp));
        end
    end
    
    % Save spectral images as overlapping windows
    % Downsample both dimensions to be largest power of 2 <= original dimensions
    specImageOrig = filtspec(:,window_start_index(k):window_end_index(k));
    specImages(:,:,k) = imresize(specImageOrig, [nfreqPow2 fpLengthPow2], 'bilinear');
    
    % Compute Haar wavelet transform
    haarImages(:,:,k) = mdwt(specImages(:,:,k), 'haar_2d');
    
    % Sort wavelet transformed values by magnitude (highest to lowest)
    currentHaarImage = haarImages(:,:,k);
    currentHaarMagnitude = abs(currentHaarImage);
    [sortedHaar, indexHaar] = sort(currentHaarMagnitude(:), 'descend');
    clear sortedHaar;
    
    % For top t_value magnitude values of wavelet, store the sign
    % (-1 if negative, 0 if zero, 1 if positive)
    currentTopWavelet = zeros(numPointsFP, 1, 'double');
    currentTopWavelet(indexHaar(1:t_value)) = sign(currentHaarImage(indexHaar(1:t_value)));
    topWaveletImages(:,:,k) = reshape(currentTopWavelet, nfreqPow2, fpLengthPow2);

    % Store sign as 2-bit representation
    % (01 if negative, 00 if zero, 10 if positive)
    binaryFingerprint(:,k) = convert_sign_to_bits(currentTopWavelet); 
end
disp(['fingerprint generation took: ' num2str(toc(time))]);

%%% ---------- Plot section ---------- %%% 

% Fingerprint Indices to plot!!!!
% plot_ind = [1:NWindows];
% plot_ind = [1263]; % signal 1
% plot_ind = [1624]; % signal 2
% plot_ind = [786]; % signal 3
% plot_ind = [245]; % noise 1 (arbitrary)
% plot_ind = [2876]; % noise 2 (arbitrary)
% plot_ind = [1266];
% plot_ind = [1629];
% plot_ind = [618];
% plot_ind = [793];
plot_ind = [555];

flag_plot_waveforms = 0;
if (flag_store_waveforms & flag_plot_waveforms)
    % Plot waveforms that go into spectral image
    figure
    set(gca, 'FontSize', 18)
    vid = VideoWriter('plots_similarity/waveforms.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imagesc(specSettings.lagTime*[0:fingerprintLength-1], ...
            [0:specSettings.wnd_len-1]/specSettings.fs, imageWaveforms(:,:,k));
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18); colormap('gray')
        xlim([0 fingerprintDuration]); ylim([0 specSettings.wnd_len/specSettings.fs]); caxis([-50 50]);
        xlabel('time (s) in spectral image'); ylabel('time (s) within time window');
        title(['waveform, window #' num2str(k)]);
        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

flag_plot_spec_images = 0;
if (flag_plot_spec_images)
    % Plot magnitude of band passed 4-10 Hz spectral images, log10 units
    figure
    set(gca, 'FontSize', 18)
    vid = VideoWriter('plots_similarity/specImages.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imagesc(fp_ds_values, freq_ds_values, log10(specImages(:,:,k)));
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18);
        xlim([0 fingerprintDuration]); caxis([-5 5]);
        xlabel('Time (s)'); ylabel('Frequency (Hz)');
%         title(['log_{10}(|spectral image|)']);
        title(['log_{10}(|spectral image|), window #' num2str(k)]);
        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

flag_plot_haar = 0;
if (flag_plot_haar)
    % Plot Haar transform wavelet magnitudes of spectral images, log10 units
    figure
    set(gca, 'FontSize', 18)
    vid = VideoWriter('plots_similarity/haarWaveletMagnitudes.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imagesc(fp_ds_indices, freq_ds_indices, log10(abs(haarImages(:,:,k))));
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18);
        xlim([0 fpLengthPow2-1]); ylim([0 nfreqPow2-1]); caxis([-5 5]);
        xlabel('wavelet transform x index'); ylabel('wavelet transform y index');
%         title(['log_{10}(|Haar transform|)']);
        title(['log_{10}(|Haar transform|), window #' num2str(k)]);
        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

flag_plot_top_wavelets = 0;
if (flag_plot_top_wavelets)
    % Plot sign of top wavelet magnitude values from spectral images
    figure
    set(gca, 'FontSize', 18)
    vid = VideoWriter('plots_similarity/top200WaveletSigns.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imagesc(fp_ds_indices, freq_ds_indices, topWaveletImages(:,:,k));
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18); colormap('gray'); set(c1,'YTick',[-1,0,1]);
        xlim([0 fpLengthPow2-1]); ylim([0 nfreqPow2-1]);
        xlabel('wavelet transform x index'); ylabel('wavelet transform y index');
%         title(['Sign of top wavelet coefficients']);
        title(['Sign of top wavelet coefficients, window #' num2str(k)]);
        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

flag_plot_bit_fp = 0;
if (flag_plot_bit_fp)
    % Plot bit representations of fingerprints
    ny_ind = 2*nfreqPow2;
    figure
    set(gca, 'FontSize', 18)
    vid = VideoWriter('plots_similarity/bitFingerprints.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        imageBinaryFp = reshape(binaryFingerprint(:,k), ny_ind, fpLengthPow2);
        imagesc([0:fpLengthPow2], [0:ny_ind], imageBinaryFp);
        set(gca, 'YDir', 'normal');
        c1=colorbar; set(c1,'FontSize',18); colormap('gray'); set(c1,'YTick',[0,1]);
        xlabel('fingerprint x index'); ylabel('fingerprint y index');
%         title(['Binary Fingerprint']);
        set(gca,'XTick',[0 20 40 60 80 100 120]);
        title(['Binary Fingerprint, window #' num2str(k)]);
        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

% Need this to plot subplots with different colormaps on same figure
path(path,'~/Documents/MATLAB/freezeColors');
path(path,'~/Documents/MATLAB/cm_and_cb_utilities');

% Plot all 4 things
flag_all_plots = 0;
if (flag_store_waveforms & flag_all_plots)
    figure
    rect = get(gcf,'Position');
    set(gcf, 'Position', [440 378 800 700]); % [xloc yloc width height]
    vid = VideoWriter('plots_similarity/fingerprint_plots.avi');
    open(vid);
    for n = 1:length(plot_ind)
        k = plot_ind(n);
        
        h4 = subplot(221); set(gca, 'FontSize', 18);
        imagesc(specSettings.lagTime*[0:fingerprintLength-1], ...
            [0:specSettings.wnd_len-1]/specSettings.fs, imageWaveforms(:,:,k));
        ax4 = get(h4, 'Position'); set(h4, 'Position', ax4);
        axis([0 fingerprintDuration 0 specSettings.wnd_len/specSettings.fs]);
        set(gca, 'YDir', 'normal');
        colormap('gray'); c4=colorbar; set(c4,'FontSize',18); caxis([-50 50]);
        freezeColors; cbfreeze(c4); cblabel('', 'FontSize', 18);
        xlabel('time (s) in spectral image'); ylabel('time (s) within time window');
        title(['waveform, window #' num2str(k)]);

        h1 = subplot(222); set(gca, 'FontSize', 18);
        imagesc(fp_ds_values, freq_ds_values, log10(specImages(:,:,k)));
        ax1 = get(h1, 'Position'); set(h1, 'Position', ax1);
        set(gca, 'YDir', 'normal');
        colormap('default'); c1=colorbar; set(c1,'FontSize',18);
        axis([0 fingerprintDuration freq_ds_values(1) freq_ds_values(end)]); caxis([-5 5]);
        freezeColors; cbfreeze(c1); cblabel('', 'FontSize', 18);
        xlabel('time (s) in spectral image'); ylabel('Frequency (Hz)');
        title(['log10(|spectral image|^2), window #' num2str(k)]);

        h2 = subplot(223); set(gca, 'FontSize', 18);
        imagesc(fp_ds_indices, freq_ds_indices, log10(abs(haarImages(:,:,k))));
        ax2 = get(h2, 'Position'); set(h2, 'Position', ax2);
        set(gca, 'YDir', 'normal');
        c2=colorbar; set(c2,'FontSize',18);
        axis([0 fpLengthPow2-1 0 nfreqPow2-1]); caxis([-5 5]);
        freezeColors; cbfreeze(c2); cblabel('', 'FontSize', 18);
        xlabel('time index in spectral image'); ylabel('wavelet transform index');
        title(['log10(|Haar transform|), window #' num2str(k)]);

        h3 = subplot(224); set(gca, 'FontSize', 18);
        imagesc(fp_ds_indices, freq_ds_indices, topWaveletImages(:,:,k));
        ax3 = get(h3, 'Position'); set(h3, 'Position', ax3);
        set(gca, 'YDir', 'normal');
        colormap('gray'); c3=colorbar; set(c3,'FontSize',18); set(c3,'YTick',[-1,0,1]);
        axis([0 fpLengthPow2-1 0 nfreqPow2-1]);
        xlabel('time index in spectral image'); ylabel('wavelet transform index');
        title(['Sign of top wavelet magnitudes, window #' num2str(k)]);

        writeVideo(vid, getframe(gcf));
    end
    close(vid);
end

end
