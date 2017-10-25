function [u] = extract_window(x, index, length)
% Extracts normalized time series data window, starting at index,
% with given length
%
% Inputs
% x:      time series data
% index:  starting index of data window to extract
% length: number of samples in data window to extract
%
% Outputs
% u:      Normalized time series data window
%

u = x(index:index+length-1);
u = u / norm(u);

end