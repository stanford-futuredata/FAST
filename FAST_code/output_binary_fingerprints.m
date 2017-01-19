close all
clear

% inputs

% load('../data/evendistNCSN_Calaveras_7ch_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400.mat');
% methodNumber = 1;

load('../data/NCSN_Calaveras_7ch_24hr/binaryFingerprint_wLen10_wLag0.1_fpLen100_fpLag10_tvalue1400.mat');
methodNumber = 2;

% Found by both method 1 and method 2
% dir = strcat('./method', num2str(methodNumber), '_yes1_yes2/');
% fpind = [548 786 833 997 1160 1267 1335 1622 1734 1782 4853 11300 22920 51800];

% Found by method 2 but not method 1
% dir = strcat('./method', num2str(methodNumber), '_no1_yes2/');
% fpind = [3534 4712 25819 25840 76925 76946 81220 85975];

% Found by method 1 but not method 2
% dir = strcat('./method', num2str(methodNumber), '_yes1_no2/');
% fpind = [611 801 4868 8206];

% Found by method 1 but not method 2, for 3 hash functions
dir = strcat('./method', num2str(methodNumber), '_yes1_nfuncs3_no2/');
fpind = [648 1809 4891 5167 25164 26460 57585 70511 10628 11152];

% end of inputs

dt_fp = 1;
nch = 7;
nfreq = 32;
fplen = 64;
ny = 2*nch*nfreq;
nx = fplen;

if (7 ~= exist(dir, 'dir'))
    mkdir(dir);
end
fptimes = fpind*dt_fp;
for k=1:length(fptimes)
%     imagesc(reshape(binaryFingerprint(:,fptimes(k)), ny, nx)); colormap('gray'); axis image;
    filename = strcat(dir, 'method', num2str(methodNumber), '_', num2str(fptimes(k)), '.png');
    imwrite(reshape(binaryFingerprint(:,fptimes(k)), ny, nx), filename);
end