function [means, stdevs] = mean_stdev_haar_dataset(numPartitions, baseDir, specStr, sum_p, N_p)
% Compute mean and standard deviation of Haar coefficients over entire data set

means = sum_p / N_p; % mean Haar coefficient over entire data set

sumsq_p = zeros(size(means));
for p=1:numPartitions
   load([baseDir 'normHaarImages' specStr '_part' num2str(p) '.mat']);

   % Update demeaned squared sum of Haar coefficients
   [sumsq_p] = update_sumsq_haar(normHaarImages, means, sumsq_p);
end
stdevs = sqrt(sumsq_p / (N_p-1)); % standard deviation of Haar coefficient over entire data set

end

