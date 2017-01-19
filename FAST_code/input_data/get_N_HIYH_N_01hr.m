function [t, x, Fs] = get_N_HIYH_N_01hr()

% Read in data from BP.N.HIYH.N, 1 hour, start at 35240 s
% Bandpass 2-8 Hz
% Japan tremor data from 2006-04-16

path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/japantremor/060416pm/060416pm.N.HIYH.N.bp2to8.deci4.1hr');
Fs = 25;

% load('../data/japantremor/detection_lists/listcc_1.dat');

end