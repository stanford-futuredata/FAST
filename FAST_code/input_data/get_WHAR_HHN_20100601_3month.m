function [t, x, Fs] = get_WHAR_HHN_20100601_3month()

% Read in data from station WHAR, channel HHN, 20100601, 3 month
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/20100601_20100831_HHN_BP_1_30.SAC');
Fs = 100;

t = t(1:794880000);
x = x(1:794880000);

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
