function settings = default_settings(settings)

    if(nargin < 1)
        settings = struct();
    end

    % Test suite name
    if(~isfield(settings,'name'))
        settings.name = 'untitled';
    end

    % Show information
    if(~isfield(settings,'verbose'))
        settings.verbose = true;
    end

    % Window length used by signal
    if(~isfield(settings,'len'))
        settings.len = 256;
    end

    % Enable debugging
    if(~isfield(settings,'debug'))
        settings.debug = false;
    end 

    % Time series duration
    if(~isfield(settings,'duration'))
        settings.duration = 648000;
    end

    % Stride used by random noise sampling (not active)
    if(~isfield(settings,'stride'))
        settings.stride = 2;
    end

    %% Save data
    if(~isfield(settings,'active'))
        settings.save = struct();
    end
    
    %Use save functionality
    if(~isfield(settings.save,'active'))
        settings.save.active = true;
    end
    
    if(~isfield(settings.save,'name'))
        settings.save.name = 'untitled_project';
    end

    if(~isfield(settings.save,'dir'))
        settings.save.dir = 'data/';
    end

    % Signal to noise ratio
    if(~isfield(settings,'snr'))
        settings.snr = 10;
    end
    
    % Signal to noise variance
    if(~isfield(settings,'snr_var'))
        settings.snr_var = 10;
    end

    if(~isfield(settings,'data'))
        settings.data = 'input_data/2011.008.00.00.00.deci5.24hr.NC.CCOB.EHZ.D.SAC';
    end

    %Number of samples per second in data
    if(~isfield(settings,'srate'))
        settings.srate = 20;
    end
    
    % -- Injection options
    % place all injected signal with a fixed stride
    if(~isfield(settings,'inject_uniformly'))
        settings.inject_uniformly = true;
    end

    % Injection stride (if inject_uniformly = true)
    % stride starts at the length of a signal
    if(~isfield(settings,'inject_stride'))
        settings.inject_stride = 500;
    end

    % -- Noise options
    % Start index and end index of noise
    if(~isfield(settings,'noise_range'))
        settings.noise_range = [576000,648000];
    end

    % Seed used to select indices where
    % the signal will be buried in the noise
    if(~isfield(settings,'noise_seed'))
        settings.noise_seed = 94383902;
    end


    % -- Plotting
    % Maximum number of points to include on the scatter plot
    % (per cluster)
    if(~isfield(settings,'scatter_max'))
        settings.scatter_max = 500;
    end

    if(~isfield(settings,'scatter_colors'))
        settings.scatter_colors = ...
            {'ro','bo','go','ko','mo'};
    end

    if(~isfield(settings,'plt'))
        settings.plt = struct();
    end

    if(~isfield(settings.plt,'xlim'))
        settings.plt.xlim = 'auto';
    end

    if(~isfield(settings.plt,'ylim'))
        settings.plt.ylim = [0 1];
    end

    if(~isfield(settings.plt,'colors'))
        settings.plt.colors = ...
            {'r','b','g','k','m','y','c'};
    end 

    if(~isfield(settings.plt,'path'))
        settings.plt.path = 'figures';
    end

    % -- Spectrogram
    % Length of hamming window used to form
    % spectrogram
    if(~isfield(settings,'spec_wnd_len'))
        settings.spec_wnd_len = 64;
    end

    % Lag between hamming windows
    if(~isfield(settings,'spec_wnd_lag'))
        settings.spec_wnd_lag = 1;
    end

    % Number of frequencies to use
    if(~isfield(settings,'spec_nfft'))
        settings.spec_nfft = 256;
    end

    % Low frequency index
    if(~isfield(settings,'spec_low_f'))
        settings.spec_low_f = 1;
    end
    
    % High frequency index
    if(~isfield(settings,'spec_high_f'))
        settings.spec_high_f = 128;
    end

    % Spectral image length (in samples)
    if(~isfield(settings,'spec_img_len'))
        settings.spec_img_len = 128;
    end

    % Spectral image lag (in samples)
    if(~isfield(settings,'spec_img_lag'))
        settings.spec_img_lag = 10;
    end

    % Number of coefficients to average in x
    if(~isfield(settings,'spec_avg_x'))
        settings.spec_avg_x = 1;
    end
    
    if(~isfield(settings,'spec_avg_y'))
        settings.spec_avg_y = 1;
    end

    % Type of spectrogram: PSD, cosine, or abs-mag
    if(~isfield(settings,'spec_kind'))
        settings.spec_kind = 'PSD';
    end


    % Enable block mode
    if(~isfield(settings,'spec_block_mode'))
        settings.spec_block_mode = false;
    end
    % Block dimensions
    if(~isfield(settings,'spec_block_dim'))
        settings.spec_block_dim = [4 4];
    end
    % Number of coefficients per block to keep in block mode
    if(~isfield(settings,'spec_block_num_coeff'))
        settings.spec_block_num_coeff = 1;
    end

    % -- Spectral peaks method
    % Filter spectral peaks by keeping either 'num_coeff' or
    % specify 'threshold' value.
    if(~isfield(settings,'spectral_peak_filter_coeff'))
        settings.spectral_peak_filter_coeff = 'num_coeff';
    end 

    if(~isfield(settings,'peak_num_coeff'))
        settings.peak_num_coeff = 200;
    end

    if(~isfield(settings,'peak_threshold'))
        settings.peak_threshold = 0.8;
    end

    % Verbose
    if(~isfield(settings,'spec_verbose'))
        settings.verbose = true;
    end

    %-- Wavelet
    if(~isfield(settings,'wl_num_coeff'))
        settings.wl_num_coeff = 240;
    end
    
    %-- Scaleogram
    if(~isfield(settings,'scl'))
        scl = struct();
    else
        scl = settings.scl;
    end

    if(~isfield(scl,'img_len'))
        scl.img_len = 256;
    end

    if(~isfield(scl,'wnd_len'))
        scl.wnd_len = 128;
    end

    % Lag between hamming windows
    if(~isfield(scl,'wnd_lag'))
        scl.wnd_lag = 2;
    end

    % Wavelet basis
    if(~isfield(scl,'basis'))
        scl.basis = 'daub8';
    end

    % Number of coefficients to average in x
    if(~isfield(scl,'avg_x'))
        scl.avg_x = 1;
    end
    
    if(~isfield(scl,'avg_y'))
        scl.avg_y = 1;
    end  

    if(~isfield(scl,'scl.cylic'))
        scl.cyclic = true;
    end
    
    %-- Discrete cosine spectrogram
    if(~isfield(settings,'ct'))
        ct = struct();
    else
        ct = settings.ct;
    end

    if(~isfield(ct,'img_len'))
        ct.img_len = 256;
    end

    if(~isfield(ct,'wnd_len'))
        ct.wnd_len = 64;
    end

    % Lag between windows
    if(~isfield(ct,'wnd_lag'))
        ct.wnd_lag = 1;
    end

    % Number of coefficients to average in x
    if(~isfield(ct,'avg_x'))
        ct.avg_x = 1;
    end
    
    if(~isfield(ct,'avg_y'))
        ct.avg_y = 1;
    end  

    settings.ct = ct; 

    %% stats
    if(~isfield(settings,'stats'))
        settings.stats = struct();
    end
    % Standard deviation
    if(~isfield(settings.stats,'stdev'))
        settings.stats.stdev = true;
    end
    
    % Mean
    if(~isfield(settings.stats,'avg'))
        settings.stats.avg = true;
    end
    
    % Maximum spread
    if(~isfield(settings.stats,'len'))
        settings.stats.len = true;
    end





end
