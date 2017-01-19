function ind = noise_signals(range)
%Return the index (sample position) of noise signals


%The factor 20 is used to convert
%time into samples
ind = 20*([1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000] ); 

assert(length(range) <= length(ind),' Too many earthquake indices requested. ');
ind = ind(range);

end
