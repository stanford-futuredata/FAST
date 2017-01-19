clear
close all

load('../data/haar_coefficients/NCSN_CCOB_EHN_1wk/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');
% load('../data/haar_coefficients/NCSN_CADB_EHZ_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');
% load('../data/haar_coefficients/NCSN_CAO_EHZ_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');
% load('../data/haar_coefficients/NCSN_CHR_EHZ_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');
% load('../data/haar_coefficients/NCSN_CML_EHZ_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');

nch = 1;
nfreq = 32;
fplen = 64;
ny = 2*nch*nfreq;
nx = fplen;

fp1267.imageBinaryFp = reshape(binaryFingerprint(:,1267), ny, nx);
fp1629.imageBinaryFp = reshape(binaryFingerprint(:,1629), ny, nx);
font_size = 16;
% font_size = 22;

% % Plot one binary fingerprint
% figure
% set(gca, 'FontSize', font_size)
% imagesc(fp1267.imageBinaryFp);
% set(gca, 'YDir', 'normal');
% c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[0,1]);
% title('binary fingerprint 1266');
% 
% figure
% set(gca, 'FontSize', font_size)
% imagesc(fp1629.imageBinaryFp);
% set(gca, 'YDir', 'normal');
% c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[0,1]);
% title('binary fingerprint 1629');

% Points that are 1 in both fingerprints
and_image = and(fp1267.imageBinaryFp, fp1629.imageBinaryFp);
figure
set(gca, 'FontSize', font_size)
imagesc(and_image);
set(gca, 'YDir', 'normal');
c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[0,1]);
title('and image');

% Points that are (0 and 1), or (1 and 0).
xor_image = xor(fp1267.imageBinaryFp, fp1629.imageBinaryFp);
figure
set(gca, 'FontSize', font_size)
imagesc(xor_image);
set(gca, 'YDir', 'normal');
c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); set(c1,'YTick',[0,1]);
title('xor image');

% Convert to double. Multiply the 'and' overlap image by 3 for scaling.
double_and_3x = 3*double(and_image);
double_xor = double(xor_image);

figure
set(gca, 'FontSize', font_size)
imagesc(double_and_3x);
set(gca, 'YDir', 'normal');
c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); % set(c1,'YTick',[0,1]);
title('double and image');

figure
set(gca, 'FontSize', font_size)
imagesc(double_xor);
set(gca, 'YDir', 'normal');
c1=colorbar; set(c1,'FontSize',font_size); colormap('gray'); % set(c1,'YTick',[0,1]);
title('double xor image');

% Add the double images
sum_images = double_and_3x + double_xor;
s = size(sum_images);
nfreqPow2 = s(1);
nx_ind = s(2);

% figure
% set(gca, 'FontSize', font_size)
FigHandle = figure('Position',[1500 100 700 640]);
imagesc([0:nx_ind], [0:nfreqPow2], sum_images);
% set(gca,'FontSize',22,'FontWeight','bold');
set(gca, 'FontSize', font_size);
set(gca, 'YDir', 'normal');
set(gcf, 'ColorMap', [0,0,0; 1,0,0; 1,1,1]) % custom colormap
labels = {'both 0', 'one 1', 'both 1'};
c1=lcolorbar(labels, 'fontweight', 'bold');
% set(c1,'FontSize',22);
set(c1,'FontSize',font_size);
pos = get(c1, 'position');
pos(1) = pos(1) - 0.02;
set(c1, 'position', pos);
xlabel('fingerprint x index'); ylabel('fingerprint y index');
title(['Similar fingerprint pair']);
% set(gca, 'XTick', [0:8:64]);
% set(gca,'XTickLabel', [' 0';' 8';'16';'24';'32';'40';'48';'56';'64']);
% set(gca, 'YTick', [0:8:64]);
% set(gca,'YTickLabel', [' 0';' 8';'16';'24';'32';'40';'48';'56';'64']);
set(gca, 'XTick', [0:16:64]);
set(gca,'XTickLabel', [' 0';'16';'32';'48';'64']);
set(gca, 'YTick', [0:16:64]);
set(gca,'YTickLabel', [' 0';'16';'32';'48';'64']);

% outfile = 'plot_scec_2014/binaryfp_overlap_1266_1629.eps';
% print('-depsc', outfile);

% jaccard
or_image = or(fp1267.imageBinaryFp, fp1629.imageBinaryFp);
'Jaccard similarity = ', jaccard(and_image(:), or_image(:))
