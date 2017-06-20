function [] = plot_compare_window_pair_haar_1d(t_ind, t, u, v, str_u, str_v, str_title)
% For a time window pair, displays on same plot:
% - Time windows
% - 1D Haar transforms
% - Time windows from 1D inverse Haar transform
% - Time windows from 1D inverse Haar transform, keep coarsest coefficients
% - Time windows from 1D inverse Haar transform, keep top magnitude coefficients
%
% Inputs:
% t_ind     Time axis indices
% t         Time axis values (s)
% u         First time window values, normalized
% v         Second time window values, normalized
% str_u     String with start time (s) of time window u
% str_v     String with start time (s) of time window v
% str_title Descriptive title string (ex: 'signal', 'noise')

% keep only a few Haar coefficients - t_value coefficients with highest
% magnitude
t_value = 32;

% For both time windows in pair, plot inverse Haar time window comparisons
[haar_u, haar_u_top, check_u, check_u_coarse, check_u_top, index_haar_u, fp_haar_u_top] = ...
    plot_check_haar_1d(t_ind, t, u, str_u, t_value);
[haar_v, haar_v_top, check_v, check_v_coarse, check_v_top, index_haar_v, fp_haar_v_top] = ...
    plot_check_haar_1d(t_ind, t, v, str_v, t_value);

'Time window similarity (CC, Jaccard) = ', correlation_coefficient(u, v), overlap_jaccard(u, v)
'Time window top Haar coefficient similarity (CC, Jaccard) = ', ...
    correlation_coefficient(check_u_top, check_v_top), overlap_jaccard(check_u_top, check_v_top)
'Haar coefficient similarity (CC, Jaccard) = ', ...
    correlation_coefficient(haar_u, haar_v), overlap_jaccard(haar_u, haar_v)
'Top Haar coefficient similarity (CC, Jaccard) = ', ...
    correlation_coefficient(haar_u_top, haar_v_top), overlap_jaccard(haar_u_top, haar_v_top)
'Jaccard similarity between top Haar coefficient binary fingerprints = ', ...
    jaccard(fp_haar_u_top, fp_haar_v_top)

% fp_intersection = and(fp_haar_u_top, fp_haar_v_top);
% s = size(fp_intersection);
% numBins = s(2);
% amplitudeBins = [1:numBins];
% 
% figure
% set(gca,'FontSize',16)
% imagesc(t_ind, amplitudeBins, fp_intersection');
% set(gca, 'YDir', 'normal');
% xlabel('Haar transform index'); ylabel('Wavelet coefficient bin index');
% title(['Intersection of fingerprints']);
% caxis(0:1); colormap('gray');

% Plot original time window pair
figure
set(gca,'FontSize',16)
plot(t, u, 'b', t, v, 'r')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Original time window pair, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthWest');

% Plot 1D Haar transforms of window pair
num_coef = length(haar_u);
power_coef = log2(num_coef);
figure
set(gca,'FontSize',16)
stem(t_ind, haar_u, 'bo')
hold on
stem(t_ind, haar_v, 'ro')
hold off
xlabel('Haar transform index'); ylabel('Haar coefficient value');
xlim([1 num_coef]); ylim([-0.5 0.5]);
title(['1D Haar transform of time window pair, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthWest');
% Plot vertical lines at scale boundaries
pow_of_2 = 1;
hold on
for k=1:power_coef
    plot([pow_of_2, pow_of_2], [-0.5 0.5], 'k--')
    pow_of_2 = pow_of_2*2;
end
hold off

% Plot truncated 1D Haar transforms of window pair (only top magnitude
% coefficients)
figure
set(gca,'FontSize',16)
stem(t_ind(index_haar_u(1:t_value)), haar_u_top(index_haar_u(1:t_value)), 'bo')
hold on
stem(t_ind(index_haar_v(1:t_value)), haar_v_top(index_haar_v(1:t_value)), 'ro')
hold off
xlabel('Haar transform index'); ylabel('Haar coefficient value');
xlim([1 num_coef]); ylim([-0.5 0.5]);
title(['Top magnitude, 1D Haar transform, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthWest');
% Plot vertical lines at scale boundaries
pow_of_2 = 1;
hold on
for k=1:power_coef
    plot([pow_of_2, pow_of_2], [-0.5 0.5], 'k--')
    pow_of_2 = pow_of_2*2;
end
hold off

% Plot window pair from inverse 1D Haar transform (do they match original pair?)
figure
set(gca,'FontSize',16)
plot(t, check_u, 'b', t, check_v, 'r')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Time window pair after 1D inverse Haar transform, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthWest');

% Plot window pair from inverse 1D Haar transform, keep coarsest coefficients
% figure
% set(gca,'FontSize',16)
% plot(t, check_u_coarse, 'b', t, check_v_coarse, 'r')
% xlabel('Time (s)'); ylabel('Amplitude');
% title(['Time window pair, keep coarsest Haar coefficients, ' str_title]);
% legend(['start at ' str_u ' s'], ['start at ' str_v ' s']);

% Plot window pair from inverse 1D Haar transform, keep top magnitude coefficients
figure
set(gca,'FontSize',16)
plot(t, check_u_top, 'b', t, check_v_top, 'r')
xlabel('Time (s)'); ylabel('Amplitude');
title(['Time window pair, keep top magnitude Haar coefficients, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s'], 'Location', 'NorthWest');

end

