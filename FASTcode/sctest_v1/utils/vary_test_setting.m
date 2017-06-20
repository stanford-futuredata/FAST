function test_suite = vary_test_setting(test,settings,field,range)
    test_suite = cell(length(range),1);

    assert(isfield(settings,field),'Setting not found');
    for i=1:length(range)
        if(iscell(range))
            settings.(field) = range{i};
        else
            settings.(field) = range(i);
        end
        test_suite{i} = new_test(test,settings);
    end

end

