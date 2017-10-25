function ss_test()

    paths();


    voting = test_1hr('voting');
    show_stats(voting.stats);
    subplot(1,2,1);
    plot_pairs(voting);
    default = test_1hr('default');
    show_stats(default.stats);
    subplot(1,2,2);
    plot_pairs(default);


end

function data = test_1hr(method)
    settings.data = '1';
    settings.method = method;
    [data settings] = ss(settings);
    timing(settings.method,data.times);
    data.stats = compute_stats(data);

end

function plot_pairs(data)
    plot(data.pair_i,data.pair_k,'o');
    ylim([0 1]); 
    xlim([1 data.nfp]);
    xlabel('Fingerprint index');
    ylabel('Success rate');
end

function [data settings] = ss(settings)

    if(nargin < 1)
        settings = struct();
    end

    settings = default_settings(settings);

    fp = load_fp(settings.data);
    nfp = size(fp,2);
    
    query = uint32([1:2:nfp]'); 
    
    data = run(fp,query,settings);
    data.nfp = nfp;

end

function stats = compute_stats(data)

    stats.peak = max(data.nfp_buckets);
    stats.ppeak = 100*double(max(data.nfp_buckets))/sum(data.nfp_buckets);
    stats.pairs = length(data.pair_i);

end

function show_stats(s)
    disp(['Peak: ',            num2str(s.peak) ' items', ...
          ' ( ',               num2str(s.ppeak), '% ), ', ... 
          'Number of pairs: ', num2str(s.pairs) ...
          ]);
end

function data = run(fp,query,settings)
    time = tic;
    ntbls = settings.ntbls;
    nfuncs = settings.nfuncs;
    votes = settings.nvotes;
    trials = 1;
    near_repeats = settings.near_repeats;
    seed = 1e12*rand();

    switch settings.method
        case 'voting'
[data.pair_i, data.pair_j, data.pair_k, data.times, data.nfp_buckets] = ...
mxSimilaritySearchV(fp,ntbls,nfuncs,trials,seed,query,near_repeats,votes);
        case 'default'
[data.pair_i, data.pair_j, data.pair_k, data.times, data.nfp_buckets] = ...
mxSimilaritySearch(fp,ntbls,nfuncs,trials,seed,query,near_repeats);
    end

    data.times(end+1) = toc(time);
    data.pair_i = int32(data.pair_i);
    data.pair_j = int32(data.pair_j);
    data.pair_k = double(data.pair_k)/ntbls;

end

function timing(method,times)
    disp([ method ' took: ' num2str(times(4))]); 
    disp([ method ', min-hash, took: ' num2str(times(1))]);
    disp([ method ', populate hash tables, took: ' num2str(times(2))]);
    disp([ method ', retrieve matches, took: ' num2str(times(3))]);
end

function default = default_settings(default)

    if(nargin < 1)
        default = struct();
    end
    
    if(~isfield(default,'nfuncs'))
        default.nfuncs = 4;
    end
    
    if(~isfield(default,'ntbls'))
        default.ntbls = 80;
    end
    
    if(~isfield(default,'nvotes'))
        default.nvotes = 5;
    end
    
    if(~isfield(default,'near_repeats'))
        default.near_repeats = 10;
    end
    
    if(~isfield(default,'data'))
        default.data = '1';
    end
    
    %Method can be either 'voting' or 'default'
    if(~isfield(default,'method'))
        default.method = 'default';
    end

end

function paths()
    addpath('mex');
end

function fp = load_fp(data)
    switch data
        case '24';
            file = 'fp24';
        case '1'
            file = 'fp1';
    end

    load(['data/' file],'fp');

end
