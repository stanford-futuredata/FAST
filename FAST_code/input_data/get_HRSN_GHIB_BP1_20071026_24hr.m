function [t, x, Fs] = get_HRSN_GHIB_BP1_20071026_24hr()

% Read in data from HRSN, station GHIB, channel BP1, 20071026, 24 hr
% Band pass 2-8 Hz
path(path,'./MatSAC');
[t, x, SAChdr] = fget_sac('../data/hrsn/2007.299.00.00.00.0300.BP.GHIB..BP1.Q.SAC.bp2to8');
Fs = round(1.0 / SAChdr.times.delta); % sampling rate

end
