function [sim_jaccard] = overlap_jaccard(a, b)
% Computes 'overlap Jaccard similarity' between two NORMALIZED vectors,
% a and b.
%
% Overlap_Jaccard = sum((min(|A|,|B|)*Kronecker(A,B))) / sum(max(|A|,|B|))
%
% Attempt to generalize Jaccard similarity to non-binary inputs.
% min ~ and, max ~ or.
%
% Inputs:
% a              First time window values, normalized
% b              Second time window values, normalized
%
% Outputs:
% sim_jaccard    Overlap Jaccard similarity

nlength = length(a);

delta_a_b = false(nlength,1);
delta_a_b(sign(a)==sign(b)) = true;

abs_a = abs(a);
abs_b = abs(b);

min_a_b = min(abs_a, abs_b);
max_a_b = max(abs_a, abs_b);

sim_num = sum(min_a_b .* delta_a_b);
sim_den = sum(max_a_b);
sim_jaccard = sim_num / sim_den;

end

