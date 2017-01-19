function [t, x, Fs] = get_NCSN_CCOB_3comp_24hr()

% Read in data from NCSN, station CCOB, channels EHE EHN EHZ, decimated 5 times
% Band pass 4-10 Hz
path(path,'./MatSAC');
[t, x(:,1), SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHE.D.SAC.bp4to10');
[t, x(:,2), SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHN.D.SAC.bp4to10');
[t, x(:,3), SAChdr] = fget_sac('../data/ncsn/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC.bp4to10');
Fs = 20; % sampling rate

end
