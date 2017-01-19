function [t, x, Fs] = get_NCSN_CHR_EHZ_24hr()

% Read in data from NCSN, station CHR.EHZ, 24 hours, decimated 5 times
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.24hr.NC.CHR.EHZ.D.SAC.bp2to10');
Fs = 20;

% last_index = 72001; % 1 hour
% last_index = 144000; % 2 hours
% last_index = 216000; % 3 hours
% last_index = 288000; % 4 hours
% last_index = 360000; % 5 hours
% last_index = 432000; % 6 hours
% last_index = 504000; % 7 hours % 40 s
% last_index = 576000; % 8 hours % 43 s
% last_index = 864000; % 12 hours
% last_index = 1296000; % 18 hours
% last_index = 1728000; % 24 hours

% t = t(1:last_index);
% x = x(1:last_index);

end