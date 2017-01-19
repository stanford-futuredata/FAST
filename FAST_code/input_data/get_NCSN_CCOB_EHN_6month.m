function [t, x, Fs] = get_NCSN_CCOB_EHN_6month()

% Read in data from NCSN, station CCOB, channel EHN, 6 month, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/6month.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
Fs = 20;

end
