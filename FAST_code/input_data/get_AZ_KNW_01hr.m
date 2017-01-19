function [t, x, Fs] = get_AZ_KNW_01hr()

% Read in data from AZ, station KNW, 1 hour

% [az] = rsac('../data/bigbear/seismograms/Event_2003_053_00_00_00/AZ.KNW.__.BHZ.sac');
% [az] = rsac('../data/bigbear/seismograms/Event_2003_053_00_00_00/AZ.KNW.__.BHZ.sac.byteswap.bp1to10');
[az] = rsac('../data/bigbear/seismograms/Event_2003_053_00_00_00/AZ.KNW.__.BHZ.sac.byteswap.bp1to10.deci2');
% [az] = rsac('../data/bigbear/seismograms/Event_2003_054_00_00_00/AZ.KNW.__.BHZ.sac');

% continuousdata2.xml
% beginOffset: -200 seconds
% endOffset: 86800 seconds

% 24 hr, start 0 hours after the start of the day
% t = az(8001:3464000,1);
% x = az(8001:3464000,2);

% 12 hr, start 12 hours after the start of the day
% t = az(1736001:3464000,1);
% x = az(1736001:3464000,2);

% 4 hr, start 12 hours after the start of the day
% t = az(1736001:2312000,1);
% x = az(1736001:2312000,2);

% 1 hr, start 12 hours after the start of the day
% t = az(1736001:1880000,1);
% x = az(1736001:1880000,2);
t = az(868001:940000,1); % decimated to 20 samples/s
x = az(868001:940000,2); % decimated to 20 samples/s

% [y] = rsac('../data/bigbear/PWaves/Event_2003_02_22_12_19_10/AZ.KNW.__.BHZ.sac');
Fs = 20.0; % decimated to 20 samples/s

end