function [normHaarImages] = standardize_haar_coeff(normHaarImages, means, stdevs)
% Standardize normalized Haar coefficients: subtract mean, divide by standard deviation

for i=1:size(normHaarImages,2)
   normHaarImages(:,i) = (normHaarImages(:,i) - means) ./ stdevs;
end

end

