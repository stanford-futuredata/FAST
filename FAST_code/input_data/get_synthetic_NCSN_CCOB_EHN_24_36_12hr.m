function [t, x, Fs] = get_synthetic_NCSN_CCOB_EHN_24_36_12hr()

% Read in data from NCSN, station CCOB, channel EHN, 1 week, decimated 5 times
% Band pass filter 4-10 Hz

% SYNTHETIC data - repeating earthquake waveforms (scaled) + one
% non-repeating waveform, added to noisy section from 24 to 36 hours
path(path,'./MatSAC');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp1.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.5.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.1.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.05.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.04.NC.CCOB.EHN.D.SAC.bp4to10');
[t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.03.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.02.NC.CCOB.EHN.D.SAC.bp4to10');
% [t,x,SAChdr] = fget_sac('../data/ncsn/synthetic.deci5.12hr.24.36.amp0.01.NC.CCOB.EHN.D.SAC.bp4to10');
Fs = 20;

end
