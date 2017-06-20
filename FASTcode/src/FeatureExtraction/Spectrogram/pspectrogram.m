function [part, run_time] = pspectrogram(x,settings)

    settings = pspectrogram_default_settings(settings);

    part = partition_ranges(settings);

    [run_time] = compute_spectrograms(x,part,settings);


end

%Compute the number of partitions and the respective range
function part = partition_ranges(settings)

    offset = settings.range(1) - 1;
    len = settings.range(2) - settings.range(1) + 1;
    plength = settings.plength;
    part.n = ceil(len/plength);
    overlap = compute_overlap(settings);

    %Ensure that the second last partition (including overlap)
    %doesn't go out of bounds. If so, this is the last partition
    if( (part.n-1)*plength + overlap > len)
        part.n = part.n - 1;
    end

    % Assign ranges for all partitions except the last one
    for i=1:(part.n - 1)
      part.i0(i) = (i - 1)*plength + 1 + offset;
      part.in(i) = i*plength + overlap + offset;
    end

    if(part.n == 0)
        part.n = part.n + 1;
    end

    % Assign range for the last partition
    part.i0(part.n) = (part.n - 1)*plength + 1 + offset;
    part.in(part.n) = len + offset;


end

function [run_time] = compute_spectrograms(x,part,settings)

    show_msg(settings.verbose, ...
        ['Starting partial spectrogram computation with ' ...
        num2str(part.n) ' partition(s)']);
    
    init_matlabpool(settings);
    
    run_time = 0;
    if (settings.parallel == 0)
        for i=1:part.n
            [part_time] = compute_spectrogram(x,settings,i,part);
            run_time = run_time + part_time;
        end  
    else
        parfor i=1:part.n
            [part_time] = compute_spectrogram(x,settings,i,part);
            run_time = run_time + part_time;
        end 
    end
    
    close_matlabpool(settings);

end

function init_matlabpool(settings)

    if (settings.parallel == 0)
        return
    end

    if (matlabpool('size') ~= settings.parallel && matlabpool('size') ~= 0)
        matlabpool close
    end

    if (matlabpool('size') ~= settings.parallel)
        my_cluster = parcluster();
        matlabpool(my_cluster,settings.parallel);
    end 
end

function close_matlabpool(settings)
    if (settings.parallel == 0)
        return
    end

    matlabpool close

end

% Save the partial spectrogram
function save_spectrogram(i,data,settings)
    if(~isdir(get_save_dir(settings.data)))
        mkdir(get_save_dir(settings.data));
    end
    file = get_pname(settings.data,i);

    save(file,'data','settings', '-v7.3');

end

function part = get_save_dir(settings)
    part = [settings.dir];
end 

function part = get_pname(settings,p_ind)
    part = [settings.dir 'spec_' settings.name '_part' num2str(p_ind) '.mat'];
end 

% Compute the partial spectrogram
function [run_time] = compute_spectrogram(x,settings,i,part);
    range    = settings.range;
    wnd_len  = settings.wnd_len;
    noverlap = settings.noverlap;
    nfft     = settings.nfft;
    fs       = settings.fs;
    
    time = tic;
    [data.S,data.F,data.T,data.P] = spectrogram(x(part.i0(i):part.in(i)),wnd_len,noverlap,nfft,fs);  
    run_time = toc(time);
    show_msg(settings.verbose,['Spectrogram partition ' num2str(i) ... 
                               ' out of ' num2str(part.n) ' took ' ...
                                num2str(run_time) 's' ]);

    save_spectrogram(i,data,settings);

end

%Compute the redundant overlap needed
function overlap = compute_overlap(settings)

    wnd_len = settings.wnd_len;

    overlap = wnd_len - 1;

end

function show_msg(verbose,msg)
    if(~verbose)
        return
    end

    disp(msg);

end


