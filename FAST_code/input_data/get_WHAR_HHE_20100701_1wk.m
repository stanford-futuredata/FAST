function [t, x, Fs] = get_WHAR_HHE_20100701_1wk()

% Read in data from station WHAR, channel HHE, 20100701, 1 week
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201007_HHE_BP_1_7.SAC');
Fs = 100;

t = t(1:end-1);
x = x(1:end-1);

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
