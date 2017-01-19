function hd = newSacHeader(n,dt,b)
% form a new sac header
hd = -12345*ones(158,1);
hd(80) = n;
hd(1) = dt;
hd(6) = b;
hd(8) = 0.;		% o
hd(7) = b+(n-1)*dt;	% e
hd(88) = 11;	% iztype
hd(86) = 1;	% iftype
hd(106) = 1;	% leven
hd(77) = 6;	% version number
