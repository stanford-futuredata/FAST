
function test = new_test(test,settings)

    if(nargin < 1)
        test = struct();
    elseif(nargin < 2)
        settings = default_settings();
    end

    if(~isfield(test,'name'))
        test.name = 'default';
    end

    if(~isfield(test,'sig_id'))
        test.sig_id = 20*500;
    end

    if(~isfield(test,'snr'))
        test.snr = 10;
    end
    
    % Variance in snr
    if(~isfield(test,'snr_var'))
        test.snr_var = 0;
    end

    if(~isfield(test,'shift'))
        test.shift = 0;
    end

    if(~isfield(test,'num_signals'))
        test.num_signals = 100;
    end

    if(~isfield(test,'inject'))
        test.inject = true;
    end

    if(~isfield(test,'method'))
        test.method = {'null'};
    end
    
    if(~isfield(test,'metric'))
        test.metric = {'l2-dist'};
    end

    test.settings = settings;

end    
