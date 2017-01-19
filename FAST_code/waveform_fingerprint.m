function [u_bin_ind, uwaveformImage] = waveform_fingerprint(...
    num_ampl, min_ampl, delta_ampl, u)
% Computes 'waveform fingerprint' 2D image, by digitizing amplitude of an
% input time window waveform.
%
% Amplitude of each time series data point is digitized by putting it into
% one of num_ampl bins. The fingerprint is a binary 2D image with
% dimensions [num_ampl, length(u)].  It is 1 in every bin containing the
% amplitude of the normalized waveform data point, and value 0 everywhere
% else.  There are length(u) nonzero values in the fingerprint, so it
% should be sparse.
%
% Inputs
% num_ampl:       Number of amplitude bins for digitization, must be ODD
% min_ampl:       Minimum amplitude for data (if normalized, should be -1)
% delta_ampl:     Amplitude bin spacing for digitization
% u:              Normalized time series data window, original
%
% Outputs
% u_bin_ind:      Amplitude bin indices for waveform u
% uwaveformImage: Waveform fingerprint (2D image)

% Get amplitude bin indices for digitization
% Add 1 for matlab 1-index
u_bin_ind = floor((u-min_ampl)/delta_ampl) + 1;

% Check that bin index is between 1 and num_ampl
u_bin_ind(find(u_bin_ind < 1)) = 1;
u_bin_ind(find(u_bin_ind > num_ampl)) = num_ampl;

% Compute binary waveform image from digitized amplitudes
numSamplesInWindow = length(u);
uwaveformImage = false(num_ampl, numSamplesInWindow);
for k=1:numSamplesInWindow
    uwaveformImage(u_bin_ind(k),k) = true;
end

end

