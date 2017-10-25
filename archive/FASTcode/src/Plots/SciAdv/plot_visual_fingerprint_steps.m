clear
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Load list of detections from autocorrelation
% folder = '../data/haar_coefficients/NCSN_CCOB_EHN_1wk/';
% filename = 'autocorr_detections_NCSN_CCOB_EHN_1wk.mat';
% filepath = strcat(folder, filename);
% load(filepath);
% dt = 0.05;
% thresh = 0.8179; % Autocorrelation threshold
% 
% % Detections missed by FAST, found in autocorrelation
% % Catalog events: indices 5, 12, 14
% ind_miss = [20 21 39 42 43 45 46 47 48 49 ...
%     50 51 52 53 67 75 76 80 84 85];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Load list of detections from fingerprint/similarity search
% folder = '../data/haar_coefficients/NCSN_CCOB_EHN_1wk/';
% filename = 'fast_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800_nfuncs5_ntbls100_nvotes4_timewin21_thresh0.11.mat';
% filepath = strcat(folder, filename);
% load(filepath);
% dt = 1.0;
% thresh = 0.33; % FAST threshold
% 
% ind_false = [13 25 26 27 28 30 45 52 54 55 ...
%     59 73 77]; % false detection indices
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Load list of detections, get detection times and samples
% ind_det = find(detection_out{2} >= thresh);
% detection_times = double(detection_out{1}(ind_det))*dt;

% plot_ind = int64(detection_times(ind_miss));
% out_dir = 'visual_plots/missed/';

% plot_ind = int64(detection_times(ind_false));
% out_dir = 'visual_plots/false/';

plot_ind = [1267 1629 2876];
out_dir = '../../../figures/SciAdv/';

% Load first partition for now, will load other partitions as needed
dir = '../../../data/OutputFAST/NCSN_CCOB_EHN_1wk/';
specfile = 'specImages_wLen10_wLag0.1_fpLen100_fpLag10_part1.mat';
haarfile = 'haarImages_wLen10_wLag0.1_fpLen100_fpLag10_part1.mat';
load(strcat(dir,specfile));
load(strcat(dir,haarfile));

coefffile = 'topWaveletImages_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat';
load(strcat(dir,coefffile));

bfpfile = 'binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat';
load(strcat(dir,bfpfile));



% plot_ind = [1266 1629 51800 298127];

nch = 1;
nfreq = 32;
fplen = 64;
fp_ds_indices = [0:fplen-1];
freq_ds_indices = [0:nfreq-1];
t_value = 800;
% font_size = 16;
font_size = 22;

fingerprintDuration = 10.0; % seconds
dt_ds = fingerprintDuration / (fplen-1);
fp_ds_values = dt_ds*fp_ds_indices;
dfreq_ds = (10.0)/(nfreq-1);
freq_ds_values = dfreq_ds*freq_ds_indices;

num_partitions = 21;
total_time = 604800; % total duration (s) - for 1 week
partition_size = total_time/num_partitions;

prev_partition = 1;

for n = 1:length(plot_ind)
    k = plot_ind(n);
    
    ind_partition = int64(k/partition_size) + 1;
    if (ind_partition ~= prev_partition)
        disp(['Loading partition ... ', num2str(ind_partition)]);
        clear specImages haarImages;
        specfile = strcat('specImages_wLen10_wLag0.1_fpLen100_fpLag10_part', num2str(ind_partition), '.mat');
        haarfile = strcat('haarImages_wLen10_wLag0.1_fpLen100_fpLag10_part', num2str(ind_partition), '.mat');
        load(strcat(dir,specfile));
        load(strcat(dir,haarfile));
    end
    k_local = mod(k, partition_size);
    
    %%%%%%%%% Plot spectral image %%%%%%%%%%%
%     figure
    set(gca, 'FontSize', font_size);
    imagesc(fp_ds_values, freq_ds_values, log10(specImages(:,:,k_local)));
    set(gca, 'YDir', 'normal');
    c1=colorbar; set(c1,'FontSize',font_size); colormap('default');
    xlim([0 fingerprintDuration]); caxis([-5 5]);
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    title(['log_{10}(|spectral image|), window #' num2str(k)]);
    outfile = strcat(out_dir, 'specimage_window_', num2str(k));
    print('-depsc', outfile);
%     print('-dpng', outfile);

    %%%%%%%%% Plot Haar wavelet transform %%%%%%%%%%%
%     figure
    set(gca, 'FontSize', font_size);
    imagesc(fp_ds_indices, freq_ds_indices, log10(abs(haarImages(:,:,k_local))));
    set(gca, 'YDir', 'normal');
    c1=colorbar; set(c1,'FontSize',font_size); colormap('default');
    xlim([0 fplen-1]); ylim([0 nfreq-1]); caxis([-5 5]);
    xlabel('wavelet transform x index'); ylabel('wavelet transform y index');
    title(['log_{10}(|Haar transform|), window #' num2str(k)]);
    outfile = strcat(out_dir, 'haartransform_window_', num2str(k));
    print('-depsc', outfile);
%     print('-dpng', outfile);    

    %%%%%%%%% Plot top deviation Haar coefficients %%%%%%%%%%% 
%     figure
    set(gca, 'FontSize', font_size);
    imagesc(fp_ds_indices, freq_ds_indices, topWaveletImages(:,:,k));
    set(gca, 'YDir', 'normal');
    c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[-1,0,1]);
    xlim([0 fplen-1]); ylim([0 nfreq-1]);
    xlabel('wavelet transform x index'); ylabel('wavelet transform y index');
    title(['Sign of top wavelet coefficients, window #' num2str(k)]);
    outfile = strcat(out_dir, 'topcoef_window_', num2str(k));
    print('-depsc', outfile);

    %%%%%%%%% Plot binary fingerprint %%%%%%%%%%%
    imageBinaryFp = reshape(binaryFingerprint(:,k), 2*nfreq, fplen);
%     figure
    set(gca, 'FontSize', font_size);
    imagesc(fp_ds_indices, fp_ds_indices, imageBinaryFp);
    set(gca, 'YDir', 'normal');
    c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[0,1]);
    xlim([0 fplen-1]); ylim([0 2*nfreq-1]);
    xlabel('fingerprint x index'); ylabel('fingerprint y index');
    title(['Binary fingerprints, window #' num2str(k)]);
    outfile = strcat(out_dir, 'binaryfp_window_', num2str(k));
    print('-depsc', outfile);

    prev_partition = ind_partition;
end
