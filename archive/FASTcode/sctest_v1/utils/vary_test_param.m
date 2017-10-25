function test_suite = vary_test_param(test,settings,field,range)
    test_suite = cell(length(range));

    assert(isfield(test,field),'Parameter not found');

    for i=1:length(range)
        test.(field) = range(i);
        test_suite{i} = new_test(test,settings);
    end

end

