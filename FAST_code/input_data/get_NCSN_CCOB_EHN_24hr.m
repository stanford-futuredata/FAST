function [t, x, Fs] = get_NCSN_CCOB_EHN_24hr()

% Read in data from NCSN, station CCOB, channel EHN, 24 hours, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
% [t,x,SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10');
[t,x,SAChdr] = fget_sac('/farmshare/user_data/ceyoon/ncsn/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10');
Fs = 20;

end
