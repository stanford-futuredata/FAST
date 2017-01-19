function [t, x, Fs] = get_WHAR_HHZ_20100601_1month()

% Read in data from station WHAR, channel HHZ, 20100601, 1 month
path(path,'./MatSAC');
[t,x,SAChdr] = fget_sac('../data/GuyArkansas/201006_HHZ_BP_1_30.SAC');
Fs = 100;

t = [t; t(end)+SAChdr.times.delta*[1:15]'];
x = [x; zeros(15,1)];

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
[x] = filter_taper_guy_data(x, Fs);

end
