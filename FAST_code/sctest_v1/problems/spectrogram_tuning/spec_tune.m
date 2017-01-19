 function spec_tune(settings)
    % driver code
    addpath('../..');
    set_paths();

    scatter_test();

    %block_peaks();

    %num_peaks();

   %wnd_len();

   %freq();

end

function block_peaks()
    settings = struct();
    param = 'spec_block_num_coeff';
    save_name = 'block_num_coeff';
    settings.spec_block_dim = [4 4];
    settings.spec_block_mode = true;
    settings.spec_nfft = 256;
    settings.spec_low_f = 41;
    settings.spec_avg_x = 2;
    settings.spec_avg_y = 2;
    range = 1:8:128;
    range = 1:2:8;
    settings.debug = true;
    for i=1:4
        quick_test(param,param,range,i,save_name,settings);
    end
end

function num_peaks()
settings = struct();
    param = 'peak_num_coeff';
    save_name = 'num_coeff_snr5';
    range = 50:100:1000;
    settings.spec_low_f = 31;
    settings.debug = false;
    for i=1:1
        quick_test('num_coeff',param,range,i,save_name,settings);
    end

end

function wnd_len()
settings = struct();
    param = 'spec_wnd_len';
    save_name = 'wnd_len';
    range = 32:4:128;
    for i=1:12
        quick_test('window length',param,range,i,save_name,settings);
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
          quick_test(name,field,range,signal,save_name,settings)
    settings.name = name;
    settings = default_settings(settings); 
    settings.save.name = [save_name num2str(signal)];
    test.name = name;
    test.sig_id = eq_signals(signal);
    test.num_signals = 100;
    test.inject = true;
    test.snr    = 5;
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

 
