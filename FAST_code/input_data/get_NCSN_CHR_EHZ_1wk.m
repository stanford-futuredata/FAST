function [t, x, Fs] = get_NCSN_CHR_EHZ_1wk()

% Read in data from NCSN, station CHR, channel EHZ, 1 week, decimated 5 times
% Band pass filter 2-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CHR..EHZ.D.SAC.bp2to10');
Fs = 20;

end