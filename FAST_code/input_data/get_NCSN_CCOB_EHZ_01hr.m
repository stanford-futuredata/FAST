function [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr()

% Read in data from NCSN, station CCOB, channel EHZ, 1 hour, decimated 5 times
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.1hr.NC.CCOB.EHZ.D.SAC');
Fs = 20;

end