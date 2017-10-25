function [] = plot_check_haar_2d(t, f, u_img, str_windowTime, ...
    str_title, plot_max_spec_mag)
% Sanity check for 2D Haar transform. Plots the following:
% - Input spectral image
% - log10|2D Haar transform| of spectral image
% - 2D inverse Haar transform (should match original input spectral image)
% - 2D inverse Haar transform, keep top magnitude coefficients
%
% Inputs:
% t                 Time axis values (s)
% f                 Frequency axis values (Hz)
% u_img             Spectral image values
% str_windowTime    String with start time (s) of spectral image
% str_title         Descriptive title string (ex: 'signal', 'noise')
% plot_max_spec_mag Maximum spectral image value for plots

% Get image dimensions
nfreq = length(f);
ntime = length(t);

% Take 2D Haar transform of spectral image
addpath('mdwt');
addpath('mdwt/cwl_lib');
haar_img = mdwt(u_img, 'haar_2d');

% Take 2D inverse Haar transform - do we get original spectral image back?
check_img = haar_2d_inverse(haar_img);

% Plot original spectral image
figure
set(gca,'FontSize',16)
imagesc(t, f, u_img);
xlabel('Time (s)'); ylabel('Frequency (Hz)');
title(['Original spectral image at ' str_windowTime ' s, ' str_title]);
colorbar; caxis([0 plot_max_spec_mag]);

% Plot log10|2D Haar transform| of spectral image
figure
set(gca,'FontSize',16)
imagesc([1:ntime], [1:nfreq], log10(abs(haar_img)));
xlabel('Haar transform index'); ylabel('Haar transform index');
title(['log10|2D Haar transform| of spectral image at ' str_windowTime ' s, ' str_title]);
colorbar; caxis([-4 4]);

% Plot inverse Haar spectral image - does it match original spectral image?
figure
set(gca,'FontSize',16)
imagesc(t, f, check_img);
xlabel('Time (s)'); ylabel('Frequency (Hz)');
title(['Inverse 2D Haar spectral image at ' str_windowTime ' s, ' str_title]);
colorbar; caxis([0 plot_max_spec_mag]);


% Now keep only a few Haar coefficients - with the top magnitude
t_value = 200;

haar_mag = abs(haar_img);
[sorted_haar, index_haar] = sort(haar_mag(:), 'descend');
clear sorted_haar;

haar_top = zeros(nfreq*ntime, 1);
haar_top(index_haar(1:t_value)) = haar_img(index_haar(1:t_value));
haar_top_img = reshape(haar_top, nfreq, ntime);
check_top_img = haar_2d_inverse(haar_top_img);

% Plot spectral image from inverse 2D Haar transform, keep top magnitude coefficients
figure
set(gca,'FontSize',16)
imagesc(t, f, check_top_img);
xlabel('Time (s)'); ylabel('Frequency (Hz)');
title(['Inverse 2D Haar spectral image at ' str_windowTime ' s, keep top magnitude ' ...
    num2str(t_value) ' coefficients, ' str_title]);
colorbar; caxis([0 plot_max_spec_mag]);

end

