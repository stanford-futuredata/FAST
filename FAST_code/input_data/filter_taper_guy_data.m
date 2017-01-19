function [x] = filter_taper_guy_data(x, Fs)

% Filter data 1-20 Hz, normalize (from Yihe's scripts)
nt = length(x);
alpha = 0.1;
taper = tukeywin(nt, alpha);

Fc=1; [b1,a1]=butter(4,2*Fc/Fs,'high'); %%%!!! filter
Fc=20; [b2,a2]=butter(4,2*Fc/Fs,'low'); %%%!!! filter

x=detrend(x,'constant'); x=detrend(x); %% remove the mean and constant
x=x.*taper; %% taper
x=filter(b1,a1,x); x=filter(b2,a2,x); %% filter between 1 and 20 Hz
x=x./max(x); %% normalization

end