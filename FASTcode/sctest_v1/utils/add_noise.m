% Generate noise with buried signal to the ts_data object
% The signal is scaled to first match the energy of the noise, and then
% the signal is scaled again by the snr factor. 
function ts_data = add_noise(ts_data,test)
    
    range = test.settings.noise_range;

    ts_data.noise_t = ts_data.t(range(1):range(2));
    ts_data.noise = ts_data.x(range(1):range(2));

    ts_data.injections = zeros(test.num_signals,1);
    ts_data.glb_injections = ts_data.injections + range(1) - 1;   
    

    %Compute injection positions
    rng(test.settings.noise_seed);
    l = test.settings.len;
    len = range(2) - range(1) - l;

    if(test.settings.inject_uniformly)
        s = 1;
        stride = (test.settings.inject_stride + l - 1);
        e = stride*test.num_signals;
        assert(e <= length(ts_data.noise),'Too many injections');
        ts_data.injections = s:stride:e;
    else
        ts_data.injections = floor(rand(test.num_signals,1)*len);
    end
    

    % Only add signal to the noise if injection is enabled
    if(~test.inject)
        return
    end 

    snr_var = 1 + test.snr_var*rand(test.num_signals,1);
    w = ts_data.signal/norm(ts_data.signal); 
    for i=1:test.num_signals
        j = (ts_data.injections(i):(ts_data.injections(i)+l-1)) + test.shift;
        % Energy in the noise
        En = norm(ts_data.noise(j));
        % Inject signal
        ts_data.noise(j)= ts_data.noise(j) +  ...
        snr_var(i)*test.snr*w*En;
    end

end              
