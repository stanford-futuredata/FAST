 function example(settings)
    % driver code
    addpath('../..');
    set_paths();

    %quick_test('spec_test','shift',10,1,'spec_test',struct(),@eq_signals);
    shift_test('PSD_shift_wnd256',true,@eq_signals,1:4);
    %snr_test_cos();
    %snr_test_psd();
    %snr_test_abs();

end

function snr_test_psd()
    settings.spec_kind = 'PSD';
    inject = true;
    snr_test('PSD_snr_signal_wnd64',inject,@eq_signals,1:8,settings);
    inject = false;
    snr_test('PSD_snr_noise_wnd64',inject,@noise_signals,1:8,settings); 
    inject = true;
    snr_test('PSD_snr_signal_noise_wnd64',inject,@noise_signals,1:8,settings); 

end

function snr_test_cos()
    settings.spec_kind = 'cosine';
    inject = true;
    snr_test('cos_snr_signal_wnd64',inject,@eq_signals,1:8,settings);
    inject = false;
    snr_test('cos_snr_noise_wnd64',inject,@noise_signals,1:8,settings); 
    inject = true;
    snr_test('cos_snr_signal_noise_wnd64',inject,@noise_signals,1:8,settings); 

end

function snr_test_abs()
    settings.spec_kind = 'abs-mag';
    inject = true;
    snr_test('snr_signal_wnd64',inject,@eq_signals,1:8,settings);
    inject = false;
    snr_test('snr_noise_wnd64',inject,@noise_signals,1:8,settings); 
    inject = true;
    snr_test('snr_signal_noise_wnd64',inject,@noise_signals,1:8,settings); 

end


function snr_test(name,inject,fun,signals,settings)
    low_range = 0.1*(1:10);
    snr_range = linspace(1.5,40,25);
    snr_range = [low_range, snr_range];

    test.inject = inject;

    for i=signals
      [test_suite settings] = init_test(name,'snr',snr_range,fun,i,test,settings);
      main(test_suite,settings);
    end

end

function shift_test(name,inject,fun,signals)
    shift_range = 0:64;

    settings = struct();
    test.inject = inject;

    for i=signals
      [test_suite settings] = init_test(name,'shift',shift_range,fun,i,test,settings);
      main(test_suite,settings);
    end

end

function [test_suite settings] = ...
    init_test(name,field,range,fun,signal,test,settings)
    settings.name = name;
    settings = default_settings(settings); 
    settings.save.name = [name num2str(signal)];
    settings.peak_num_coeff = 1000;
    settings.spec_kind = 'PSD';
    settings.wl_num_coeff = 200;
    settings.debug = false;
    settings.spec_wnd_len = 256;
    test.name = name;
    test.sig_id = fun(signal);
    test.num_signals = 50;
    test.snr    = 10;
    test.shift  = 0;
    test.method = {'spectral peaks','spectral mag wavelet','spectral sign wavelet',...
                   'cosine'};
    test.metric = {'Jaccard-dist','Jaccard-dist','Jaccard-dist','l2-dist'};
    test_suite = vary_test_param(test,settings,field,range);
end 

function [test_suite settings] = ...
          quick_test(name,field,range,signal,save_name,settings,fun)
    settings.name = name;
    settings = default_settings(settings); 
    settings.save.name = save_name;
    settings.debug = true;
    test.name = name;
    test.sig_id = fun(signal);
    test.num_signals = 10;
    test.inject = true;
    test.snr    = 0.1;
    test.shift  = 0;
    test.method = {'spectral peaks'};
    test.metric = {'Jaccard-dist'};
    test_suite = vary_test_param(test,settings,field,range);
    main(test_suite,settings);

end


%Produce a scatter plot comparing Jaccard vs l2
function scatter_test()

    test_suite = init_test();

    settings = default_settings();
    data = main(test_suite,settings);
    
    %Scatter plot comparing results from method 1 vs method 2
    %The group_id is used to assign a color to the group
    group_id =1; 
    clf, hold on
    plot_scatter(test_suite{1},data{1},1,2,group_id); 
    plot_scatter(test_suite{2},data{2},1,2,2); 
    legend('Signal + noise','Noise');

end

 
