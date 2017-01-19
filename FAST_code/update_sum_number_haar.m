function [sum_p, N_p] = update_sum_number_haar(p, normHaarImages, sum_p, N_p)
% Helper function: update sum (sum_p) and number (N_p) of Haar coefficients:
% both input and output
%
% Need this to compute mean and standard deviation of Haar coefficients
% over entire data set, but over one partition at a time

sumCoeff = sum(normHaarImages,2);
if (p==1) % sum_p does not have any dimensions at first partition
    sum_p = zeros(size(sumCoeff));
end
sum_p = sum_p + sumCoeff;
N_p = N_p + size(normHaarImages, 2);

end

