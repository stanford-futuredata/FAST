function [t, x, Fs] = get_NCSN_CML_EHZ_1wk()

% Read in data from NCSN, station CML, channel EHZ, 1 week, decimated 5 times
% Band pass filter 2-6 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CML..EHZ.D.SAC.bp2to6');
Fs = 20;

end