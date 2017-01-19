function [straight_distance] = get_source_distance(lat1,lon1,depth1,lat2,lon2,depth2)
% Compute straight-line distance (km) between 2 underground sources
% This is only an approximation. No ray tracing involved.
% Handle depth dimension using pythagorean theorem
%
% lat,lon inputs must be degrees
% depth inputs must be km

[arclen,az] = distance(lat1,lon1,lat2,lon2);
horz_dist = deg2km(arclen);
straight_distance = sqrt((depth2-depth1)^2 + horz_dist^2);

end

