function [t, x, Fs] = get_WHAR_HHN_20100801_1month()

% Read in data from station WHAR, channel HHN, 20100801, 1 month
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201008_HHN_BP_1_30.SAC');
Fs = 100;

t = t(1:267840000);
x = x(1:267840000);

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
