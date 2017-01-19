function [topdata] = get_autocorr_detections(cc_i, cc_j, cc_values, dt, skip_time)

% Remove duplicate detection pairs
% Keep only detection pair with highest similarity

cc_i = int32(cc_i);
cc_j = int32(cc_j);

skip_samples = ceil(skip_time/dt);

[sortedCC, ix] = sort(cc_values, 'descend');
nx_orig = length(cc_values);

% preallocsize = 6000;
% preallocsize = 60000;
preallocsize = 600000;
topdata.cc_i = zeros(preallocsize, 1, 'int32');
topdata.cc_j = zeros(preallocsize, 1, 'int32');
topdata.cc = zeros(preallocsize, 1);
top_k = 1;
for k = 1:nx_orig
    k_sort = ix(k);

    if (top_k > preallocsize)
        break;
    else
        search_cc_i = topdata.cc_i(1:top_k,:);
        search_cc_j = topdata.cc_j(1:top_k,:);
        found_similar_ii = length(find( abs(search_cc_i-cc_i(k_sort)) < skip_samples ));
        found_similar_jj = length(find( abs(search_cc_j-cc_j(k_sort)) < skip_samples ));

        if (found_similar_ii && found_similar_jj)
            continue;
        else
            topdata.cc_i(top_k) = cc_i(k_sort);
            topdata.cc_j(top_k) = cc_j(k_sort);
            topdata.cc(top_k) = cc_values(k_sort);
            top_k = top_k+1;
        end
    end
end
'top_k = ', top_k

end

