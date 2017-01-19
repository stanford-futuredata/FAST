function data = transform(ts_data,test)
    
    data = cell(length(test.method),1);
    for i=1:length(test.method)
        switch test.method{i}
            case 'cosine'
                data{i} = null_transform(data{i},ts_data,test);   
            case 'spectral peaks'
                data{i} = spectral_peaks(data{i},ts_data,test);
            case 'spectral sign wavelet'
                test.settings.wl_signs = true;
                test.settings.peak_num_coeff = test.settings.wl_num_coeff;
                data{i} = spectral_wavelet(data{i},ts_data,test);
            case 'spectral mag wavelet'
                test.settings.wl_signs = false;
                test.settings.peak_num_coeff = test.settings.wl_num_coeff;
                data{i} = spectral_wavelet(data{i},ts_data,test);
            case 'scaleogram'
                data{i} = scaleogram(data{i},ts_data,test);
            case 'dct spectrogram'
                data{i} = dct_spectrogram(data{i},ts_data,test);
        end

    end

end

% -- Null transform
% Stride through the data, normalize it, but apply no
% other transformation
function data = null_transform(data,ts_data,test)
        data = null_transform_s(data,ts_data,test);
        data = null_transform_n(data,ts_data,test);
end

% -- Spectral peaks
% Extract top magnitude coefficients from spectrogram
function data = spectral_peaks(data,ts_data,test)
        [spec_signal spec_noise] = spectrograms(ts_data,test);
        data = peaks(spec_signal,spec_noise,data,test);
end

function  data = spectral_wavelet(data,ts_data,test)

    [spec_signal spec_noise] = spectrograms(ts_data,test);
    [wl_signal, wl_noise] = wavelets(spec_signal,spec_noise);
    if(test.settings.wl_signs)
        data = signs(wl_signal,wl_noise,data,test);
    else
        data = peaks(wl_signal,wl_noise,data,test);
    end
end

function data = scaleogram(data,ts_data,test)
    [scl_signal scl_noise] = scaleograms(ts_data,test);
    if(test.settings.wl_signs)
        data = signs(scl_signal,scl_noise,data,test);
    else
        data = peaks(scl_signal,scl_noise,data,test);
    end
end

function data = dct_spectrogram(data,ts_data,test)
        [dct_signal dct_noise] = dct_spectrograms(ts_data,test);
        data = peaks(dct_signal,dct_noise,data,test);
end

function data = peaks(signal,noise,data,test)
        %Build sparse binary data based on spectral peaks of signal
        len = size(signal.spec,1)*size(signal.spec,2);
        data.signal = false(len,1); 
        
        data.signal(get_max_peaks(signal.spec,test.settings)) = true;
        show_spec_and_top_coeff(signal.spec,data.signal,data,test.settings);

        %%Build sparse binary data based on spectral peaks of noise
        data.t_noise = false(len,test.num_signals);
        for i=1:test.num_signals
            noise_ = noise{i}.spec;
            data.t_noise(get_max_peaks(noise_,test.settings),i) = true; 
            show_spec_and_top_coeff(noise_,data.t_noise(:,i),data,test.settings);
        end 
end

function data = signs(signal,noise,data,test)

        %Build sparse binary data based on spectral peaks of signal
        len = size(signal.spec,1)*size(signal.spec,2);
        data.signal = false(2*len,1); 
        [sig_ind sig_val] = get_max_peaks(signal.spec,test.settings);
        data.signal = true;
        data.signal = set_sign(2*len,sig_val,sig_ind);
        show_spec_and_top_coeff(signal.spec,data.signal,data,test.settings);

        %%Build sparse binary data based on spectral peaks of noise
        data.t_noise = false(2*len,test.num_signals);
        for i=1:test.num_signals
            noise_ = noise{i}.spec;
            [noise_ind noise_val] = get_max_peaks(noise_,test.settings);
            noise_ = set_sign(2*len,noise_val,noise_ind);
            data.t_noise(:,i) = noise_; 
            show_spec_and_top_coeff(noise_,data.t_noise(:,i),data,test.settings);
        end 

end

function out = set_sign(n,val,ind)

    out = false(n,1);
    for i=1:length(val)

        if(sign(val(i)) == 1)
            k = 2*ind(i) - 1;
            out(k) = true;
            k = 2*ind(i);
            out(k) = false;
        end

        if(sign(val(i)) == -1)
            k = 2*ind(i) - 1;
            out(ind(i)) = false;
            k = 2*ind(i);
            out(k) = true;
        end

    end
end

function [spec_signal spec_noise] = spectrograms(ts_data,test)

        %Number of coefficients to average
        avg_x = test.settings.spec_avg_x;
        avg_y = test.settings.spec_avg_y;
        
        %Spectrogram of signal
        pos = test.sig_id;
        spec_signal = compute_spectrogram(ts_data.x,pos,ts_data,test);
        spec_signal.spec = resize(spec_signal.spec,avg_x,avg_y);
        
        % Convert to log scale
        %spec_signal.spec = log10(abs(spec_signal.spec));
        
        %Spectrogram of each signal with noise
        for i=1:test.num_signals
            pos = ts_data.injections(i);
            spec_noise{i} = compute_spectrogram(ts_data.noise,pos,ts_data,test);
            spec_noise{i}.spec = resize(spec_noise{i}.spec,avg_x,avg_y);
        end 
end
function [scl_signal scl_noise] = scaleograms(ts_data,test)

        %Number of coefficients to average
        avg_x = test.settings.scl_avg_x;
        avg_y = test.settings.scl_avg_y;
        
        %Spectrogram of signal
        pos = test.sig_id;
        scl_signal = compute_scaleogram(ts_data.x,pos,test);
        scl_signal.spec = resize(scl_signal.spec,avg_x,avg_y);
        
        %Spectrogram of each signal with noise
        for i=1:test.num_signals
            pos = ts_data.injections(i);
            scl_noise{i} = compute_scaleogram(ts_data.noise,pos,test);
            scl_noise{i}.spec = resize(scl_noise{i}.spec,avg_x,avg_y);
        end 
end

function [dct_signal dct_noise] = dct_spectrograms(ts_data,test)
        
        %Number of coefficients to average
        avg_x = test.settings.ct.avg_x;
        avg_y = test.settings.ct.avg_y;

        %Spectrogram of signal
        pos = test.sig_id;
        dct_signal = compute_dct_spectrogram(ts_data.x,pos,test);
        dct_signal.spec = resize(dct_signal.spec,avg_x,avg_y);
        
        %Spectrogram of each signal with noise
        for i=1:test.num_signals
            pos = ts_data.injections(i);
            dct_noise{i} = compute_dct_spectrogram(ts_data.noise,pos,test);
            dct_noise{i}.spec = resize(dct_noise{i}.spec,avg_x,avg_y);
        end 


end

function [wl_signal, wl_noise] = wavelets(spec_signal,spec_noise)

    wl_signal.spec = mdwt(spec_signal.spec,'haar_2d');
    for i=1:length(spec_noise)
        wl_noise{i}.spec = mdwt(spec_noise{i}.spec,'haar_2d');
    end
    
end   

function resized_img2 = resize(img,avg_x,avg_y)

    mx = size(img,2);
    my = size(img,1); 
    nx = round(size(img,2)/avg_x);
    ny = round(size(img,1)/avg_y);
    resized_img = zeros(my,nx);
    resized_img2 = zeros(ny,nx);

   

    if(avg_x > 1)
        for i=1:my
            y = average(img(i,:),avg_x);
            resized_img(i,:) = y; 
        end
    else
        resized_img = img;
    end
    
    if(avg_y > 1)
        for i=1:nx
            resized_img2(:,i) = average(resized_img(:,i),avg_y); 
        end
    else
        resized_img2 = resized_img;
    end


end

function x = cycle(x)

    % Number of scales
    n = log2(length(x));

    % For each scale, find max and cyclically shift it s.t 
    % the max becomes the first element at the scale
    i0 = 2;
    for i=1:n-1
        %Elements in scale
        i0 = 2*i0 - 1;
        in = 2*(i0 - 1);
        %Get local max
        x_loc = x(i0:in);
        loc_i0 = find(x_loc == median(abs(x_loc)));
        y = circshift(x_loc,-loc_i0+1); 
        x(i0:in) = y;
    end
end

function avg = average(x,num_elements)
    n = round(length(x)/num_elements); 
    avg = zeros(n,1);
    for i=1:n
        i0 = num_elements*(i - 1) + 1;
        in = num_elements*i;
        avg(i) = 1/num_elements*sum(x(i0:in));
    end
    
end

function show_spec_and_top_coeff(spec,bin_map,data,settings)
    if(~settings.debug)
        return
    end
    clf
    hold off
    surf(spec), shading interp, view(2) 
    hold on
    nx = size(spec,1);
    ny = size(spec,2);
    img = reshape(bin_map,nx,ny);
    coords = get_coords(img);
    plot3(coords.x,coords.y,max(max(spec)) + 0*coords.x,'ko');
    pause(); 
end

%Get the index of the top coefficients
function [coeff val] = get_max_peaks(x,settings)
    
    if(settings.spec_block_mode)
        dim = settings.spec_block_dim;
        num_coeff = settings.spec_block_num_coeff;
        block = block_max(abs(x),dim(1),dim(2),num_coeff);
        coeff = block(:) == 1;
        val   = x(block);
    else
        [coeff val] = global_peaks(x,settings);
    end
                                                                              
end

function [coeff val] = global_peaks(x,settings)
    switch settings.spectral_peak_filter_coeff
        case 'num_coeff'
            [val coeff] = sort(abs(x(:)),'descend');
            num_coeff = settings.peak_num_coeff;
            coeff = coeff(1:num_coeff);
            val = x(coeff);
        case 'threshold'
            top = max(abs(x(:)));
            range = 1:length(x(:));
            threshold = settings.peak_threshold;
            coeff = abs(x(:))/top > threshold;
            coeff = range(coeff);
            val = x(coeff);
    end

end

% Get the coordinates of values that are "true" in a binary image 
function coords = get_coords(img)
    nx = size(img,1);
    ny = size(img,2);   

    [i j k] = find(img == true);

    coords.y = i;
    coords.x = j;

end

function data = null_transform_n(data,ts_data,test)

    stride = test.settings.stride;
    len = test.settings.len;
    m = length(ts_data.noise)-len;
    n = ceil(m/stride);

    data.method = 'null';
    data.t_noise = zeros(len,test.num_signals);
    for i=1:test.num_signals
        j = ts_data.injections(i);
        k = j:(j+len-1); 
        data.t_noise(:,i) = ts_data.noise(k)/norm(ts_data.noise(k));
        data.ind = j + test.settings.noise_range(1) - 1;
    end
end

function data = null_transform_s(data,ts_data,test)
    data.signal = ts_data.signal/norm(ts_data.signal);
end

% -- Spectrogram
function data = compute_spectrogram(x,pos,ts_data,test)
    data.len = test.settings.spec_wnd_len;
    data.overlap = data.len - test.settings.spec_wnd_lag;
    data.srate = test.settings.srate;
    data.nfft = test.settings.spec_nfft;
    data.x0 = pos;
    data.xn = data.x0 + test.settings.spec_img_len + ...
              test.settings.spec_wnd_len/test.settings.spec_wnd_lag - 2; 

    % Spectral image 
    [spec, freq, times, P] = spectrogram(x(data.x0:data.xn),data.len, data.overlap, ...
                                      data.nfft, data.srate);
   

    % Band-pass spectrogram
    data.low_f = test.settings.spec_low_f;
    data.high_f = test.settings.spec_high_f;
    % Decide what part of the spectrogram to process, i.e. spectral density, 
    % real-part, absolute magnitude
    switch test.settings.spec_kind
        case 'cosine'
            data.spec = abs(real(spec(data.low_f:data.high_f,:)));
        case 'abs-mag'
            data.spec = abs(spec(data.low_f:data.high_f,:));
        case 'PSD'
            data.spec = P(data.low_f:data.high_f,:);
    end

    % Spectral image dimensions
    dim_spec = size(data.spec); % use filtered spectrogram
    data.nfreq = dim_spec(1); % number of frequency bins in spectrogram
    data.ntime = dim_spec(2); % number of time samples in spectrogram 
    
end

function data = compute_scaleogram(x,pos,test)
    data = spectrogram_(@mdwt_,x,pos,test.settings.scl);
end

function data = compute_dct_spectrogram(x,pos,test)
    data = spectrogram_(@dct_,x,pos,test.settings.ct);
end

function data = spectrogram_(f,x,pos,settings)
    %Compute start and end positions for each window
    lag = settings.wnd_lag;
    wnd_len = settings.wnd_len;
    data.x0 = pos;
    data.xn = data.x0 + settings.img_len + ...
              settings.wnd_len/settings.wnd_lag-1;
    len = data.xn - data.x0 + 1;
    num_wnds = floor( (len-wnd_len)/lag);
    i0 = pos + (0:lag:(num_wnds*lag));
    in = i0 + wnd_len - 1;
    data.spec = zeros(wnd_len,num_wnds);
    
    for i=1:num_wnds
        x_ = x(i0(i):in(i));
        data.spec(:,i) = f(x_,settings);
        if(isfield(settings,'cyclic'))
            if(settings.cyclic)
                data.spec(:,i) = cycle(data.spec(:,i));
            end
        end
    end

    data.len = len;
    data.lag = lag;
    data.num_wnds = num_wnds;

end

function y = mdwt_(x,opts)
    y = mdwt(x,opts.basis);
end

function y = dct_(x,opts)
    y = abs ( dct(x) );
end

