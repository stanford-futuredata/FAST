function ts_data = get_signal(test)
    [t,x,SAChdr] = fget_sac(test.settings.data); 
    ts_data.t = t;
    ts_data.x = x(1:test.settings.duration);
    ts_data.signal = x(test.sig_id:(test.sig_id+test.settings.len-1));
end 
