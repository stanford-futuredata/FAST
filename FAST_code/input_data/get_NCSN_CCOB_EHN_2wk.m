function [t, x, Fs] = get_NCSN_CCOB_EHN_2wk()

% Read in data from NCSN, station CCOB, channel EHN, 2 weeks, decimated 5 times
% Band pass filter 4-10 Hz
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/ncsn/1month.2011.008.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10');
Fs = 20;

% Return only first 2 weeks (14 days)
end_sample = 86400*14*Fs;
t = t(1:end_sample);
x = x(1:end_sample);

end
