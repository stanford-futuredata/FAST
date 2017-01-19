function [t, x, Fs] = get_HRSN_EADB_3comp_24hr()

% Read in data from HRSN, station EADB, channels BP1 BP2 BP3
% Band pass 2-8 Hz
path(path,'./MatSAC');
[t, x(:,1), SAChdr] = fget_sac('../data/hrsn/2007.184.00.00.00.0417.BP.EADB..BP1.Q.SAC.bp2to8');
[t, x(:,2), SAChdr] = fget_sac('../data/hrsn/2007.184.00.00.00.0417.BP.EADB..BP2.Q.SAC.bp2to8');
[t, x(:,3), SAChdr] = fget_sac('../data/hrsn/2007.184.00.00.00.0417.BP.EADB..BP3.Q.SAC.bp2to8');
Fs = round(1.0 / SAChdr.times.delta); % sampling rate

end
