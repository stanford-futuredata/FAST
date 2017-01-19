function ind = eq_signals(range)
%Return the index (sample position) of earthquake signals


%We subtract 4 to center the signal better. The factor 20 is used to convert
%time into samples
ind = 20*([552, 616,792,867,996,1169,1264,1343,1628,1740,1789,3525] ); 

assert(length(range) <= length(ind),' Too many earthquake indices requested. ');
ind = ind(range);

end
