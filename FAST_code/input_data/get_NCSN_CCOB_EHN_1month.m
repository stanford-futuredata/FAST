function [t, x, Fs] = get_NCSN_CCOB_EHN_1month()

% Read in data from NCSN, station CCOB, channel EHN, 1 month, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
Fs = 20;

end
