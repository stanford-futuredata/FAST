function [t, x, Fs] = get_NCSN_CCOB_EHN_3days()

% Read in data from NCSN, station CCOB, channel EHN, 3 days, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
Fs = 20;

% Return only first 3 days
end_sample = 86400*3*Fs;
t = t(1:end_sample);
x = x(1:end_sample);

end