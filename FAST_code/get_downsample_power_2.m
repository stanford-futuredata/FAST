function [pow_val] = get_downsample_power_2(val)
% Returns the largest power of 2 that is less than or equal to val
%
% Inputs
% val     Integer >= 1, in general not a power of 2
%
% Outputs
% pow_val Largest power of 2 that is <= val

% Must have val >= 1
if (val < 1)
    error('get_downsample_power_2:argcheck', 'input value must be >= 1');
end

% Check if we have a power of 2
log2_val = log2(val);

% If we have a power of 2, return it
if (floor(log2_val) == log2_val)
    pow_val = val;
% Otherwise, return the largest power of 2 that is less than val
else
    pow_val = 2^(nextpow2(val)-1);
end

end