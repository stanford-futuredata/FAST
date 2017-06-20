function data = similarity_search(fp,nfp,query,settings,mode_)

    nfuncs = settings.nfuncs;
    ntbls  = settings.ntbls;
    votes = settings.nvotes;
    limit  = settings.limit;
    near_repeats = settings.near_repeats;

    data = struct();
    
%     seed = 1e12*rand();

    % Use fixed seed for easier debug
    seed = 1e12*0.5;

    switch mode_
        case 'initialize'
            data = ...
            mxSimilaritySearchV(fp,nfp,ntbls,nfuncs,seed,uint32(query),near_repeats,votes,limit,0); 

        case 'search'                                     % data.search_time, ...
           
            [data.pair_i, data.pair_j, data.pair_k, data.times.search, ...
             data.num_buckets, data.max_items_bucket] = ...
            mxSimilaritySearchV(fp,nfp,ntbls,nfuncs,seed,uint32(query(:)),near_repeats,votes,limit,1);
        
            % Return fraction of hash tables as similarity metric
            data.pair_k = single(data.pair_k)/ntbls;

        case 'finalize'
            mxSimilaritySearchV(fp,nfp,ntbls,nfuncs,seed,uint32(query),near_repeats,votes,limit,2); 
    end


end
