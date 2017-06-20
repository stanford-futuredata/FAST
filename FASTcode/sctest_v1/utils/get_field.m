function data = get_field(cell_array,field,method)

    n = length(cell_array);

    data = zeros(n,1);

    if(method ~= -1)
        for i=1:n
            data(i) = cell_array{i}{method}.(field);
        end
    else
        for i=1:n
            data(i) = cell_array{i}.(field);
        end
    end

end
