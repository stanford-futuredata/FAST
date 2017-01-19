function [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr_bp1to10()

% Read in data from NCSN, station CCOB, channel EHZ, 1 hour
% Bandpass filtered 1-10 Hz, decimated 5 times
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.1hr.NC.CCOB.EHZ.D.SAC.bp1to10');
Fs = 20;

end