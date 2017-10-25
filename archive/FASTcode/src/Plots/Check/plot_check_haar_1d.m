function [haar_u, haar_u_top, check_u, check_u_coarse, check_u_top, ...
   index_haar_u, fp_haar_top] = plot_check_haar_1d(t_ind, t, u, str_u, t_value)
% Sanity check for 1D Haar transform
% Plots comparison of input time window with:
% - 1D inverse Haar transform (should match original input time window)
% - 1D inverse Haar transform, keep coarsest coefficients
% - 1D inverse Haar transform, keep top magnitude coefficients
%
% Inputs:
% t_ind          Time axis indices
% t              Time axis values (s)
% u              Time window values, normalized
% str_u          String with start time (s) of time window u
% t_value:       Number of top magnitude coefficients to keep
%
% Outputs:
% haar_u         1D Haar transform of u
% haar_u_top     1D Haar transform of u, keep top magnitude coefficients
% check_u        1D inverse Haar transform of haar_u (should match u)
% check_u_coarse 1D inverse Haar transform of haar_u, keep coarsest coefficients
% check_u_top    1D inverse Haar transform of haar_u, keep top magnitude coefficients
% index_haar_u   1D Haar coefficient indices stored in descending order of magnitude
% fp_haar_top    Binary image fingerprint from top magnitude Haar coefficients

% Get time window dimension
numSamplesInWindow = length(u);

% Take 1D Haar transform of time window
addpath('mdwt');
addpath('mdwt/cwl_lib');
haar_u = mdwt(u, 'haar_1d');

% Take 1D inverse Haar transform - do we get original time window back?
check_u = haar_1d_inverse(numSamplesInWindow, haar_u);

% Plot original time window + inverse Haar time window
% figure
% set(gca,'FontSize',16)
% plot(t, u, 'b', t, check_u, 'm')
% xlabel('Time (s)'); ylabel('Amplitude');
% title(['Time window ' str_u ' s, check from Haar + inverse Haar']);
% legend('original', 'Haar+inverse');

% Plot 1D Haar transform of time window
power_coef = log2(numSamplesInWindow);
figure
set(gca,'FontSize',16)
stem(t_ind, haar_u, 'bo')
xlabel('Haar transform index'); ylabel('Haar coefficient value');
xlim([1 numSamplesInWindow]); ylim([-0.5 0.5]);
title(['Time window ' str_u ' s, 1D Haar transform']);
% Plot vertical lines at scale boundaries
pow_of_2 = 1;
hold on
for k=1:power_coef
    plot([pow_of_2, pow_of_2], [-0.5 0.5], 'k--')
    pow_of_2 = pow_of_2*2;
end
hold off

% Now keep only a few Haar coefficients - at the coarsest level
haar_u_coarse = zeros(numSamplesInWindow, 1);
haar_u_coarse(1:t_value) = haar_u(1:t_value);
check_u_coarse = haar_1d_inverse(numSamplesInWindow, haar_u_coarse);

% figure
% set(gca,'FontSize',16)
% plot(t, u, 'b', t, check_u_coarse, 'm')
% xlabel('Time (s)'); ylabel('Amplitude');
% title(['Time window ' str_u, ' s, Haar transform, keep coarsest ' ...
%     num2str(t_value) ' coefficients']);
% legend('original', 'Haar coarse');

% Now keep only a few Haar coefficients - with the top magnitude
haar_u_mag = abs(haar_u);
[sorted_haar_u, index_haar_u] = sort(haar_u_mag, 'descend');
clear sorted_haar_u;

haar_u_top = zeros(numSamplesInWindow, 1);
haar_u_top(index_haar_u(1:t_value)) = haar_u(index_haar_u(1:t_value));
check_u_top = haar_1d_inverse(numSamplesInWindow, haar_u_top);

figure
set(gca,'FontSize',16)
plot(t, u, 'b', t, check_u_top, 'm')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Time window ' str_u, ' s, Haar transform, keep top magnitude ' ...
    num2str(t_value) ' coefficients']);
legend('original', 'Haar top magnitude');
ylim([-0.4 0.5]);

% Plot 1D Haar transform of time window, only top magnitudes
power_coef = log2(numSamplesInWindow);
figure
set(gca,'FontSize',16)
stem(t_ind(index_haar_u(1:t_value)), haar_u_top(index_haar_u(1:t_value)), 'bo')
xlabel('Haar transform index'); ylabel('Haar coefficient value');
xlim([1 numSamplesInWindow]); ylim([-0.5 0.5]);
title(['Time window ' str_u ' s, 1D Haar transform, top magnitude coeff']);
% Plot vertical lines at scale boundaries
pow_of_2 = 1;
hold on
for k=1:power_coef
    plot([pow_of_2, pow_of_2], [-0.5 0.5], 'k--')
    pow_of_2 = pow_of_2*2;
end
hold off

% Compute binary image fingerprint from top magnitude wavelet coefficients
% Dead space quantization with fill-in
dx = 0.04; % wavelet coefficient amplitude spacing for quantization
thres = dx;
xmax = 1.0;
fp_haar_top = dsqf(haar_u_top,dx,xmax,thres);
s = size(fp_haar_top)
numBins = s(2);
amplitudeBins = [1:numBins];

% Plot binary image fingerprint
figure
set(gca,'FontSize',16)
imagesc(t_ind, amplitudeBins, fp_haar_top');
set(gca, 'YDir', 'normal');
xlabel('Haar transform index'); ylabel('Wavelet coefficient bin index');
title(['Binary coefficient image at ' str_u ' s, ' num2str(numBins) ...
    ' amplitude bins']);
caxis(0:1); colormap('gray');

end

