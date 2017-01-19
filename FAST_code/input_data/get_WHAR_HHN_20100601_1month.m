function [t, x, Fs] = get_WHAR_HHN_20100601_1month()

% Read in data from station WHAR, channel HHN, 20100601, 1 month
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201006_HHN_BP_1_30.SAC');
Fs = 100;

t = t(1:end-1);
x = x(1:end-1);

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
