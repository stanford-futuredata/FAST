function [t, x, Fs] = get_WHAR_HHZ_20101101_1month()

% Read in data from station WHAR, channel HHZ, 20101101, 1 month
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201011_HHZ_BP_1_30.SAC');
Fs = 100;

t = t(1:259200000);
x = x(1:259200000);

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
