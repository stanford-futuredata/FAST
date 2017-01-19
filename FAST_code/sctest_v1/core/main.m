function data = main(test_suite,settings)

    data = cell(length(test_suite),1);

    %Display info
    show_info(test_suite,settings);

    % Compute similarity results for each test
    total.start_time = tic;
    for i=1:length(test_suite)
        start_time = tic;
        ts_data = get_signal(test_suite{i});
        ts_data = add_noise(ts_data,test_suite{i});
        t_data = transform(ts_data,test_suite{i});
        data{i} = similarity(t_data,ts_data,test_suite{i});
        data_stats{i} = stats(data{i},test_suite{i});
        show_test_time(i,start_time,settings);
    end
    show_total_test_time(i,total.start_time,settings);

    save_data(test_suite,data,data_stats,settings);

end

function show_info(test_suite,settings)

    if(~settings.verbose)
        return
    end

    disp(['Running test suite: ' settings.name ', containing ' ...
    num2str(length(test_suite)) ' tests']); 
end

function show_test_time(i,time,settings)
    if(~settings.verbose)
        return
    end
    disp(['Test ' num2str(i) ' took: ' num2str(toc(time)) ]);
end

function show_total_test_time(i,time,settings)
    if(~settings.verbose)
        return
    end
    disp(['All tests took: ' num2str(toc(time)) ]);
end 

function save_data(test_suite,data,stats,settings)

    if(~settings.save.active)
        return
    end



    if(~isdir(settings.save.dir))
        mkdir(settings.save.dir);
    end

    if(settings.verbose)
        disp(['Saving data to: ' settings.save.dir '/' ...
              settings.save.name ]);
    end

    save_obj = [settings.save.dir '/' settings.save.name];
    save(save_obj,'test_suite','data','stats');

end


