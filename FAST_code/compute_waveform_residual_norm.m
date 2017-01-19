function [u_approx, u_res_norm] = compute_waveform_residual_norm(...
    min_ampl, delta_ampl, u, u_bin_ind)
% Computes approximate waveform from digitizing amplitude, and
% l2 norm of residual between original and digitized waveforms
%
% Inputs
% min_ampl:   Minimum amplitude for data (if normalized, should be -1)
% delta_ampl: Amplitude bin spacing for digitization
% u:          Normalized time series data window, original
% u_bin_ind:  Amplitude bin indices for waveform u
%
% Outputs
% u_approx:   Normalized time series data window, digitized approximation
% u_res_norm: l2 norm of residual between original and digitized waveforms

u_approx = (u_bin_ind - 1 + 0.5)*delta_ampl + min_ampl;
u_res_norm = norm(u - u_approx);

end
