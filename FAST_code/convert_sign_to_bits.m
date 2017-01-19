% Converts signs to 2-bit representation (needed for fingerprinting)
%
% Inputs
% signValues: vector with sign values
%            (-1 if negative, 0 if zero, 1 if positive)
%
% Outputs
% bitValues: vector with bit values
%            (01 if negative, 00 if zero, 10 if positive)
%
% Example:
% signValues = [-1 0 1 0 1 -1];
% bitValues = [0 1 0 0 1 0 0 0 1 0 0 1]
% 
function [bitValues] = convert_sign_to_bits(signValues)
    bitValues = false(1, 2*length(signValues));
    
    ind_pos = find(signValues > 0);
    ind_neg = find(signValues < 0);
    
    bitValues(ind_pos*2 - 1) = 1;
    bitValues(ind_neg*2) = 1;
end
