function cc_out = correlation_coefficient(x,y)
% Computes the correlation coefficient (cosine similarity) between
% two NORMALIZED vectors, x and y.
%
% (Inputs do not have to be binary, as for cosine_similarity.m.)
%
% Inputs:
% x      First time window values, normalized
% y      Second time window values, normalized
%
% Outputs:
% cc_out Correlation coefficient
%
cc_out = sum(x .* y);
