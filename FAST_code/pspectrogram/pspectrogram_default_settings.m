function settings = pspectrogram_default_settings(settings)

    if(nargin < 1 )
        settings = struct();
    end


    if(~isfield(settings,'data'))
        settings.data = struct();
    end

    settings.data = default_data_settings(settings.data);

    % Display output info
    if(~isfield(settings,'verbose'))
        settings.verbose = true;
    end

    % Signal range to convert to spectrogram
    if(~isfield(settings,'range'))
        settings.range = [1,100];
    end

    % Partition length
    if(~isfield(settings,'plength'))
        settings.plength = 1e3;
    end

    %-- Spectrogram settings
    % Spectral Window length (samples)
    if(~isfield(settings,'wnd_len'))
        settings.wnd_len = 128;
    end

    % Spectral window overlap (samples)
    if(~isfield(settings,'noverlap'))
        settings.noverlap = 127;
    end

    % Number of fft points/ number of frequencies
    if(~isfield(settings,'nfft'))
        settings.nfft = 512;
    end

    % Sampling frequency (samples per second)
    if(~isfield(settings,'fs'))
        settings.fs = 20;
    end

    %Perform computations in parallel (one partition or more partitions per worker)
    % if 'parallel = 0' all computations are performed in serial
    % if 'parallel = n' then the computations are performed using 'n' workers
    if(~isfield(settings,'parallel'))
        settings.parallel = 0;
    end

end

% Partitioned spectrograms are stored in
% dir/name/data_1.mat ... dir/name/data_n.mat
% where the user specifies 'dir' and 'name'.
% The files data_1, ... data_n.mat contain
% data for each spectrogram partition.
function data = default_data_settings(data)

    if(~isfield(data,'name'))
        data.name = 'test';
    end

    if(~isfield(data,'dir'))
        data.dir = '.';
    end

end
