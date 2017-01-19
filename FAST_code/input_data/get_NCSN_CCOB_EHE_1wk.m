function [t, x, Fs] = get_NCSN_CCOB_EHE_1wk()

% Read in data from NCSN, station CCOB, channel EHE, 1 week, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHE.D.SAC.bp4to10');
Fs = 20;

end