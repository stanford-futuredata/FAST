 function spec_tune(settings)
    % driver code
    addpath('../..');
    set_paths();

    %scatter_test();

    %block_peaks();

    num_peaks_main();


    %test();

    %wnd_len_main();

   %freq();

end


function test()

    settings = struct();
    settings.spec_kind = 'cosine';
    settings.debug = true;
    settings.name = 'test';
    param = 'spec_wnd_len';
    save_name = 'wnd_len';
    range = 16:8:256;  
    range  = 64;
    signals = 1:4;
    run(true,@eq_signals,'test',param,range,signals,settings);
end

function num_peaks_main()

  signals = 1:4;
  range = 50:100:4000;
  param = 'peak_num_coeff';
  data = 'num_coeff_wnd64';
  ct = @(name) [ data '_' name ];
  settings.spec_kind = 'cosine';
  settings.spec_wnd_len = 64;
  settings.debug = false;
  settings.name = 'Number of coefficients';

  %Signal with noise
  run(true,@eq_signals,ct('signal'),param,range,signals,settings);
  %Nosy signal with noise
  run(true,@noise_signals,ct('noise'),param,range,signals,settings);
  %No signal with noise
  run(false,@noise_signals,ct('no_signal'),param,range,signals,settings);

end


function wnd_len_main()
    settings = struct();
    settings.spec_kind = 'cosine';
    param = 'spec_wnd_len';
    save_name = 'wnd_len';
    range = 16:8:256;  
    signals = 1:4;

    %Signal with noise
    run(true,@eq_signals,'wnd_len_signal',param,range,signals,settings);
    %Nosy signal with noise 
    run(true,@noise_signals,'wnd_len_noise',param,range,signals,settings);
    %No signal with noise
    run(false,@noise_signals,'wnd_len_no_signal',param,range,signals,settings);
end 

function run(inject,f,save_name,param,range,signals,settings)
    settings.f = f;
    test.inject = inject;
    setting = default_settings(settings);
    for i=signals
        quick_test(settings.name,param,range,i,save_name,settings,test);
    end

end  

function freq()
settings = struct();
    param = 'spec_high_f';
    save_name = 'spec_high_f';
    range = 32:8:256;
    settings.spec_nfft = 512;
    settings.spec_low_f = 1;
    for i=1:12
        quick_test('High frequency cutoff',param,range,i,save_name,settings);
    end

end  

function [test_suite settings] = ...
          quick_test(name,field,range,signal,save_name,settings,test)
    settings.name = name;
    settings = default_settings(settings); 
    settings.save.name = [save_name num2str(signal)];
    settings.peak_num_coeff = 1000;
    test.name = name;
    test.sig_id = settings.f(signal);
    test.num_signals = 50;
    test.snr    = 10;
    test.method = {'spectral peaks'};
    test.metric = {'Jaccard-dist'};
    test_suite = vary_test_setting(test,settings,field,range);
    main(test_suite,settings);

end

%Produce a scatter plot comparing Jaccard vs l2
function scatter_test()

    settings.spec_block_mode = false;
    settings.spec_nfft = 256;
    settings.spec_low_f = 41;
    settings.spec_avg_x = 1;
    settings.spec_avg_y = 1;   
    settings.peak_num_coeff = 2000;
    settings.spec_block_num_coeff = 4;
    settings = default_settings(settings);
    settings.plt.xlim = [0 1];
    settings.plt.ylim = [0 1];
    
    test_suite = sc_test(2,3,settings);


    data = main(test_suite,settings);
    
    %Scatter plot comparing results from method 1 vs method 2
    %The group_id is used to assign a color to the group
    group_id =1; 
    clf, hold on
    plot_scatter(test_suite{1},data{1},1,2,1); 
    plot_scatter(test_suite{2},data{2},1,2,2); 
    xlim([0 1]);
    %legend('Signal + noise','Noise');

end

function test_suite = sc_test(signal,noise,settings)

    test.name = 'Signal and Noise test';
    test.sig_id = eq_signals(signal);
    test.inject = true;
    settings.debug = false;
    test.num_signals = 50;
    test.snr    = 1;
    test.method = {'spectral peaks','spectral sign wavelet'};
    test.metric = {'Jaccard-dist','Jaccard-dist'};
    test_suite{1} = new_test(test,settings);
    test.sig_id = noise_signals(noise);
    test.inject = false;
    test_suite{2} = new_test(test,settings);


end

 
