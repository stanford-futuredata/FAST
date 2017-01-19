function data = get_field_settings(cell_array,field)

    n = length(cell_array);

    data = zeros(n,1);

    for i=1:n
        data(i) = cell_array{i}.settings.(field);
    end

end
