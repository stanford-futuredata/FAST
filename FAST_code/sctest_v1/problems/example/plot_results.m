function plot_results()

addpath('../..');
set_paths();



%Get default plot settings
settings = default_settings();

clf

param = 'snr';
signals = 1:12;

hold off

%plot_snr_main('PSD');
%plot_snr_main('cos');
plot_shift_main();



end

function plot_snr_main(mode)

data = 'snr';
prefix = 'wnd64';
ct = @(name) [mode '_' data '_' name '_' prefix ];
figure(1)
plot_snr_(ct('signal'),ct('noise'));
end

function plot_snr_(signal,noise)

for i=1:4
    subplot(2,2,i);
    for j=5:8
        plot_snr(signal,1,j,i);
        plot_snr(noise,2,j,i);
    end
end

end

function plot_shift_main()
signal = 'PSD_shift_wnd256';
for i=1:4
subplot(2,2,i);
plot_shift(signal,1,1,i);
plot_shift(signal,1,2,i);
plot_shift(signal,1,3,i);
plot_shift(signal,1,4,i);
end

end


function plot_snr(data,group_id,signals,method)
    field.name = 'Signal to Noise ratio ';
    field.id   = 'snr';
    field.param_type = 'param';
    field.dir = 'data';
    field.data = data;
    field.group_id = group_id;
    field.title = '';
    settings = default_settings();
    for i=signals
        [test_suite stats data] = load_data(field,i);
        plot_variance(test_suite,data,stats,field,method,field.group_id,settings.plt);
    end
end

function plot_shift(data,group_id,signals,method)
    field.name = 'Shift (Number of Samples) ';
    field.id   = 'shift';
    field.param_type = 'param';
    field.dir = 'data';
    field.data = data;
    field.group_id = group_id;
    field.title = '';
    settings = default_settings();
    for i=signals
        [test_suite stats data] = load_data(field,i);
        plot_variance(test_suite,data,stats,field,method,field.group_id,settings.plt);
    end
end
function [test_suite stats data] = load_data(field,num)
    load([field.dir '/'  field.data num2str(num)],'test_suite','stats','data');
end
