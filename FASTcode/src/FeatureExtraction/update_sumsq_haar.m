function [sumsq_p] = update_sumsq_haar(normHaarImages, means, sumsq_p)
% Helper function: update demeaned squared sum (sumsq_p) of Haar coefficients:
% both input and output
%
% Need this to compute standard deviation of Haar coefficients
% over entire data set, but over one partition at a time

s = size(normHaarImages);
normHaarDemean = normHaarImages - repmat(means,1,s(2));
sumsq_p = sumsq_p + sum(normHaarDemean.^2, 2);
clear normHaarDemean;

end

