function [] = plot_waveform_fingerprint(t, u, v, str_u, str_v, str_title, varargin)
% For a time window pair, displays on same plot:
% - Original time windows
% - For different numbers of amplitude bins (for digitization):
%   - Digitized time window approximations
%   - Binary waveform fingerprint for both time windows
%   - Original vs digitized waveform for both time windows
% - L2 norm of residual between original and digitized waveform, for
%   both time windows
%
% Inputs:
% t         Time axis values (s)
% u         First time window values, normalized
% v         Second time window values, normalized
% str_u     String with start time (s) of time window u
% str_v     String with start time (s) of time window v
% str_title Descriptive title string (ex: 'signal', 'noise')
%
% Optional inputs:
% ymin      Minimum normalized waveform amplitude for plotting
% ymax      Maximum normalized waveform amplitude for plotting

% Check number of optional inputs
numvarargs = length(varargin);
if (numvarargs > 2)
    error('must not have more than 2 input variable arguments');
end

% Set defaults for optional inputs
optargs = {-1 1};

% Overwrite defaults with optional inputs
optargs(1:numvarargs) = varargin;

% Place optional inputs in variables
[ymin ymax] = optargs{:};

% Plot original window pair
figure
set(gca,'FontSize',16)
plot(t, u, 'b', t, v, 'r')
xlabel('Time (s)'); ylabel('Normalized Amplitude');
title(['Original window pair, ' str_title]);
legend(['start at ' str_u ' s'], ['start at ' str_v ' s']);
ylim([ymin ymax]);

% Minimum and maximum amplitudes
% Always the same for normalized time windows
min_ampl = -1.0;
max_ampl = 1.0;

num_ampl = [8 16 32 64 128 256 512]-1; % Number of amplitude bins - ODD
delta_ampl = (max_ampl - min_ampl) ./ num_ampl; % Amplitude bin spacing
num_iter = length(num_ampl);

% Allocate arrays for residual L2 norm
u_res_norm_arr = zeros(num_iter, 1);
v_res_norm_arr = zeros(num_iter, 1);

% Run with different number of amplitude bins each time
for k = 1:num_iter
    str_num_ampl = num2str(num_ampl(k));
    
    % For both time windows, compute waveform fingerprint image
    [u_bin_ind, uwaveformImage] = waveform_fingerprint(num_ampl(k), ...
        min_ampl, delta_ampl(k), u);
    [v_bin_ind, vwaveformImage] = waveform_fingerprint(num_ampl(k), ...
        min_ampl, delta_ampl(k), v);

    s = size(uwaveformImage);
    numBins = s(1);
    amplitudeBins = [1:numBins];

    % Plot amplitude bins for digitized window pair
    figure
    set(gca,'FontSize',16)
    plot(t, u_bin_ind, 'b', t, v_bin_ind, 'r')
    xlabel('Time (s)'); ylabel('Normalized Amplitude bin index');
    title(['Digitized window pair, ' str_num_ampl ' amplitude bins, ' str_title]);
    legend(['start at ' str_u ' s'], ['start at ' str_v ' s']);

    % Plot binary waveform fingerprint image for first window
    figure
    set(gca,'FontSize',16)
    imagesc(t, amplitudeBins, uwaveformImage);
    set(gca, 'YDir', 'normal');
    xlabel('Time (s)'); ylabel('Normalized Amplitude bin index');
    title(['Binary waveform image at ' str_u ' s, ' str_num_ampl ...
        ' amplitude bins, ' str_title]);
    c1=colorbar; set(c1,'FontSize',16); colormap('gray'); set(c1,'YTick',[0,1]);

    % Plot binary waveform fingerprint image for second window
    figure
    set(gca,'FontSize',16)
    imagesc(t, amplitudeBins, vwaveformImage);
    set(gca, 'YDir', 'normal');
    xlabel('Time (s)'); ylabel('Normalized Amplitude bin index');
    title(['Binary waveform image at ' str_v ' s, ' str_num_ampl ...
        ' amplitude bins, ' str_title]);
    c1=colorbar; set(c1,'FontSize',16); colormap('gray'); set(c1,'YTick',[0,1]);

    % For both time windows, get approximate digitized waveforms and residuals
    [u_approx, u_res_norm_arr(k)] = compute_waveform_residual_norm(...
        min_ampl, delta_ampl(k), u, u_bin_ind);
    [v_approx, v_res_norm_arr(k)] = compute_waveform_residual_norm(...
        min_ampl, delta_ampl(k), v, v_bin_ind);

    % Plot original and digitized waveforms for first window
    figure
    set(gca,'FontSize',16)
    plot(t, u, 'b', t, u_approx, 'm')
    xlabel('Time (s)'); ylabel('Amplitude');
    title(['Original and digitized waveforms at ' str_u ' s, ' ...
        str_num_ampl ' amplitude bins, ' str_title]);
    legend(['original'], ['digitized']);
    ylim([ymin ymax]);

    % Plot original and digitized waveforms for second window
    figure
    set(gca,'FontSize',16)
    plot(t, v, 'b', t, v_approx, 'm')
    xlabel('Time (s)'); ylabel('Amplitude');
    title(['Original and digitized waveforms at ' str_v ' s, ' ...
        str_num_ampl ' amplitude bins, ' str_title]);
    legend(['original'], ['digitized']);
    ylim([ymin ymax]);
end

% Plot residual L2 norm vs amplitude bin spacing for first window
figure
set(gca,'FontSize',16)
loglog(delta_ampl, u_res_norm_arr, 'o');
xlabel('Normalized amplitude bin spacing');
ylabel('residual l2 norm, digitized and original waveforms');
title(['Waveform residual l2 norm at ' str_u ' s, ' str_title]);

% Plot residual L2 norm vs amplitude bin spacing for second window
figure
set(gca,'FontSize',16)
loglog(delta_ampl, v_res_norm_arr, 'o');
xlabel('Normalized amplitude bin spacing');
ylabel('residual l2 norm, digitized and original waveforms');
title(['Waveform residual l2 norm at ' str_v ' s, ' str_title]);

end

