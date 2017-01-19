function sim = cosine_similarity(x,y)
% Computes the cosine similarity between two bit represented vectors, x and y.
% The cosine similarity is Sim(x,y) = |intersection(x,y)|/(||x||*||y||) 
% sim = cosine_similarity(x,y)
% x: vector of 1-bits and 0-bits
% y: vector of 1-bits and 0-bits
% sim: The cosine similarity (normalized dot product) of x and y
% 
% Example:
% x = [1 1 0 1]; y = [1 1 1 0];
% sim = cosine_similarity(x,y)
%
% sim = 0.6667

% Note: sqrt(sum(x)) = norm(x) only if x has either 0 or 1 values
denom = sqrt(sum(x))*sqrt(sum(y));
if (abs(denom) < 1.e-6)
    sim = 0.0;
else
    sim = sum(and(x,y))/denom; 
end
