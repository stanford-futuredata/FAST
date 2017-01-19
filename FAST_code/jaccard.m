function sim = jaccard(x,y)
% Computes the Jaccard similarity between two bit represented vectors, x and y.
% The Jaccard similarity is Sim(x,y) = |intersection(x,y)|/|union(x,y)| 
% sim = jaccard(x,y)
% x: vector of 1-bits and 0-bits
% y: vector of 1-bits and 0-bits
% sim: The jaccard similarity of x and y
% 
% Example:
% x = [1 1 0 1]; y = [1 1 1 0];
% sim = jaccard(x,y)
%
% sim = 0.5
denom = sum(or(x,y));
if (abs(denom) < 1.e-6)
    sim = 0.0;
else
    sim = sum(and(x,y))/denom; 
end
