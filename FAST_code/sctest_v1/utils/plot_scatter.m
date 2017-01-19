function h = plot_scatter(test,data,set_a,set_b,group_id)

    colors = test.settings.scatter_colors; 

    % Extract the top matches, but preserve ordering
    num_matches = test.num_signals;
    x = get_top_matches(data{set_a}.k,num_matches);
    y = get_top_matches(data{set_b}.k,num_matches);

    plot(x,y,get_color(colors,group_id));
    xlabel([data{set_a}.method ', '  data{set_a}.metric]);
    ylabel([data{set_b}.method ', '  data{set_b}.metric]);
    xlim(xlims(x,test.settings.plt.xlim));
    ylim(test.settings.plt.ylim);
    title(test.name);

end

function xl_ = xlims(x,xl)

    if(size(xl,2) == 2)
        xl_  = xl;
    else
        xl_ = [min(x) max(x)];
    end
end

function c = get_color(colors,i)
    c = colors{mod(i,length(colors))};
end

function [x ind] = get_top_matches(x,num_matches)

    [x_sorted ind] = sort(x);
    ind = ind(1:num_matches);
    x = x(ind);
    %ind_sorted = sort(ind);
    %x = x(ind);

end
