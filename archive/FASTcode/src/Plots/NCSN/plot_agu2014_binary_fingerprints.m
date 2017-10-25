close all
clear

% Do not save fingerprints as eps

% inputs
load('../../../data/OutputFAST/NCSN_CCOB_EHZ_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue800.mat');

dir = '../../../figures/NCSN/';
fpind = [555 618 793 1266 1629 4000 34222 49211 74000];
% fpind = [1266 1629];

% end of inputs

dt_fp = 1;
nch = 1;
nfreq = 32;
fplen = 64;
ny = 2*nch*nfreq;
nx = fplen;

fptimes = fpind*dt_fp;
for k=1:length(fptimes)
%     figure
%     set(gca,'FontSize',16);
%     imagesc(reshape(binaryFingerprint(:,fptimes(k)), ny, nx)); colormap('gray'); axis image;
%     set(gca,'YDir','normal');
%     xlabel('fingerprint x index'); ylabel('fingerprint y index');
%     title(['Binary Fingerprint, window #' num2str(fptimes(k))]);
%     c1=colorbar; set(c1,'FontSize',16); colormap('gray'); set(c1,'YTick',[0,1]);
    
%     outfile = strcat('plot_scec_2014/binaryfp_window_', num2str(fptimes(k)));
%     print('-depsc', outfile);
%     print('-dpng', outfile);
    
%     filename = strcat(dir, 'binaryfp_cartoon_', num2str(fptimes(k)), '.eps');
    filename = strcat(dir, 'binaryfp_cartoon_', num2str(fptimes(k)), '.png');
    outimage = reshape(binaryFingerprint(:,fptimes(k)), ny, nx);
    imshow(outimage, 'Border', 'tight', 'InitialMagnification', 100);
    print(filename, '-dpng');
%     print(filename, '-deps');
%     imwrite(reshape(binaryFingerprint(:,fptimes(k)), ny, nx), filename);
end