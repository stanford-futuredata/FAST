function [t, x, Fs] = get_AZ_KNW_24hr()

% Read in data from AZ, station KNW, 24 hours
% Last 12 hours from Event 053 2003-02-22
% First 12 hours from Event 054 2003-02-23

% [az1] = rsac('../data/bigbear/seismograms/Event_2003_053_00_00_00/AZ.KNW.__.BHZ.sac.byteswap.bp1to10.deci2.12hr');
% [az2] = rsac('../data/bigbear/seismograms/Event_2003_054_00_00_00/AZ.KNW.__.BHZ.sac.byteswap.bp1to10.deci2.12hr');
% t = [az2(1:end,1); az1(2:end,1)];
% x = [az1(1:end,2); az2(2:end,2)];

path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/bigbear/AZ_KNW_24hr_startEvent053_12h.sac');
Fs = 20.0; % decimated to 20 samples/s

end