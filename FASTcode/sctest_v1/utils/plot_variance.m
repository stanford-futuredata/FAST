function h = plot_variance(test,data,stats,field,method,group_id,settings)

    %colors = test.settings.scatter_colors; 
    pv = @(x,lower,upper,color) ...
    set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),...
        'EdgeColor',color,'facealpha',0.2,'edgealpha',0.0);

    x   = get_field_param(test,field);
    x   = x(:)';
    avg = get_field(stats,'avg',method);
    avg   = avg(:)';
    stdev = get_field(stats,'stdev',method);
    stdev   = stdev(:)';

    pv(x,avg-stdev,avg+stdev,get_color(settings.colors,group_id));
    hold on
    plot(x,avg,get_color(settings.colors,group_id));
    xlabel(field.name);
    ylabel([data{1}{method}.method ', '  data{1}{method}.metric]);

    xlim(xlims(x,settings.xlim));
    ylim(settings.ylim);
    title(field.title);

end

function x = get_field_param(test,field)
    switch field.param_type
        case 'setting'
            x   = get_field_settings(test,field.id); 
        case 'param'
            x   = get_field(test,field.id,-1)'; 
    end
end

function c = get_color(colors,i)
    c = colors{mod(i-1,length(colors))+1};
end

function xl_ = xlims(x,xl)

    if(length(xl) == 2)
        xl_  = xl;
    else
        xl_ = [min(x) max(x)];
    end
end

function [x ind] = get_top_matches(x,num_matches)

    [x_sorted ind] = sort(x);
    ind = ind(1:num_matches);
    x = x(ind);
    %ind_sorted = sort(ind);
    %x = x(ind);

end
