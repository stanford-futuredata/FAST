function [haar_u, haar_u_top] = get_top_magnitude_1d_haar_coeff(t_value, u)
% Computes the 1D Haar wavelet transform of input data with only the top
% t_value magnitude coefficients
%
% Inputs
% t_value:    Number of top magnitude coefficients to keep
% u:          Normalized data to compute Haar transform on
%
% Outputs
% haar_u:     1D Haar wavelet transform of u (all coefficients)
% haar_u_top: 1D Haar wavelet transform of u (top t_value coefficients)
%

% Haar transform of data
haar_u = mdwt(u, 'haar_1d');

% Now keep only a few Haar coefficients - with the top magnitude
haar_u_mag = abs(haar_u);
[sorted_haar_u, index_haar_u] = sort(haar_u_mag, 'descend');
clear sorted_haar_u;

% Copy only the top t_value magnitude Haar coefficients
haar_u_top = zeros(length(u), 1);
haar_u_top(index_haar_u(1:t_value)) = haar_u(index_haar_u(1:t_value));

end

