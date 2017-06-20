function stats_data = stats(data,test)

    stats_data = cell(length(test.method),1);
    for i=1:length(test.method)
        stats_data{i} = get_stats(data{i},test.settings);
    end

end

function stats_data = get_stats(data,settings)

    stats_data = struct();
    stats_data.method = data.method;

    stats_data = get_stdev(stats_data,data,settings);
    stats_data = get_mean(stats_data,data,settings);
    stats_data = get_length(stats_data,data,settings);


end

function stats_data = get_stdev(stats_data,data,settings)
    if(~settings.stats.stdev)
        return
    end

    stats_data.stdev = std(data.k);
end

function stats_data = get_mean(stats_data,data,settings)
    if(~settings.stats.avg)
        return
    end

    stats_data.avg = mean(data.k);
end

function stats_data = get_length(stats_data,data,settings)
    if(~settings.stats.len)
        return
    end

    stats_data.len = max(data.k) - min(data.k);
end

