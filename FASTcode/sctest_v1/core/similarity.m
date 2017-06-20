function data = similarity(t_data,ts_data,test)


    data = cell(length(test.method),1);
    for i=1:length(test.method)

        % Add i,j info
        data{i}.method = test.method{i};
        data{i}.i = test.sig_id;
        data{i}.j = ts_data.glb_injections;

        switch test.metric{i}
            case 'l2-dist'
                data{i} = l2_dist(data{i},t_data{i}.signal,t_data{i}.t_noise,test);
            case 'gJaccard-dist'
                data{i} = gJaccard_dist(data{i},t_data{i}.signal,t_data{i}.t_noise,test);
            case 'Jaccard-dist'
                data{i} = Jaccard_dist(data{i},t_data{i}.signal,t_data{i}.t_noise,test);
        end

    end
    

end

function data = l2_dist(data,u,vecs,test)

    data.metric = 'l2-dist';
    data.k = zeros(size(vecs,2),1);
    u = u/norm(u);
    for i=1:size(vecs,2)
        v = vecs(:,i);
        v = v/norm(v); 
        data.k(i) = 0.5 * sqrt( sum( (u - v).^2 ) );
    end

end

function data = gJaccard_dist(data,u,vecs,test)
    data.metric = 'gJaccard-dist';
    data.k = zeros(size(vecs,2),1);
        
    for i=1:size(vecs,2)
        v = vecs(:,i);
        data.k(i) = 1 - sum ( min( abs(u),abs(v) ).*delta_func(u,v) )/ sum (max( abs(u),abs(v) ) );
    end
end

function data = Jaccard_dist(data,u,vecs,test)
    data.metric = 'Jaccard-dist';
    data.k = zeros(size(vecs,2),1);
        
    for i=1:size(vecs,2)
        v = vecs(:,i);
        data.k(i) = 1 - sum ( and( u,v ) )/ sum ( or( u,v ) );
    end
end 

function w = delta_func(u,v)
    w = sign(u) == sign(v);
end
