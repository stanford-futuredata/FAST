% function P = pspectrogram_test(n)
function [] = pspectrogram_test(n)
% Ensure that the computation of a complete spectrogram exactly matches
% The partitioned spectrogram computed by pspectrogram
% 
% Usage:
% pspectrogram_test(n)
%
% Input arguments
% n : number of samples for test signal (optional)

if(nargin < 1)
    n = 1e3;
end

x = input_signal(n);

settings.range = [1,length(x)];
settings.noverlap = 126;
settings = pspectrogram_default_settings(settings);

disp( ...
'Running test 1: Partial spectrogram same as full spectrogram');
result = one_partition_test(x,settings);
test_msg(result);

disp( ...
'Running test 2: Partial spectrogram with two partitions');
result = two_partition_test(x,settings);
test_msg(result); 

disp( ...
'Running test 3: Partial spectrogram with fixed plength = 100');
result = fixed_partition_test(x,settings);
test_msg(result); 

disp( ...
'Running test 4: Partial spectrogram computed in parallel');
result = par_partition_test(x,settings);
test_msg(result); 

end

function result = one_partition_test(x,settings)

     P = compute_spectrogram(x,settings);
     settings.data.dir = 'tests/';
     settings.data.name = 'test1';
     settings.plength = length(x);
    
     % Compute partitioned spectrogram
     pspectrogram(x,settings);
     
     % Compute the error
     e = compute_error(P,settings,1);

     result = e < 1e-12;

end

function result = two_partition_test(x,settings)

     P = compute_spectrogram(x,settings);
     settings.data.dir = 'tests/';
     settings.data.name = 'test2';
     settings.plength = length(x)/2;
     assert(mod(settings.plength,2) == 0,...
         ' length(x) must be divisible by two.');
    
     % Compute partitioned spectrogram
     pspectrogram(x,settings);
     
     % Compute the error
     e = compute_error(P,settings,1:2);

     result = sum(e) < 1e-12;

end 

function result = fixed_partition_test(x,settings)

     P = compute_spectrogram(x,settings);
     settings.data.dir = 'tests/';
     settings.data.name = 'test3';
     settings.plength = 100;
    
     % Compute partitioned spectrogram
     part = pspectrogram(x,settings);
     
     % Compute the error
     e = compute_error(P,settings,1:part.n);

     result = sum(e) < 1e-12;

end  

function result = par_partition_test(x,settings)

     x = input_signal(1e5);
     settings.data.dir = 'tests/';
     settings.data.name = 'test4';
     settings.range = [1,length(x)];
     settings.plength = 1e4;
     settings.parallel = 4;
    
     % Compute full spectrogram
     P = compute_spectrogram(x,settings);
     
     % Compute partitioned spectrogram
     part = pspectrogram(x,settings);
     
     % Compute the error
     e = compute_error(P,settings,1:part.n);

     result = sum(e) < 1e-12;

end  

function x = input_signal(n)
    x = 100*randn(n,1);
end

function P = compute_spectrogram(x,settings)
    % Compute the complete spectrogram
    range    = settings.range;
    wnd_len  = settings.wnd_len;
    noverlap = settings.noverlap;
    nfft     = settings.nfft;
    fs       = settings.fs;
    
    [S,F,T,P] = spectrogram(x(range(1):range(2)),wnd_len,noverlap,nfft,fs); 
end

function e = compute_error(P,settings,range)

    e = zeros(length(range),1);
    for i=range
        %Load partition from disk
        ps = load_pspectrogram(settings.data,i,{'P'});
        %Get spectrogram partition from P
        Pp = get_partition(P,settings,i);
        e(i) = l2_error(ps.P,Pp);
    end
end

function e = l2_error(P1,P2)
    e = sum( (P1(:) - P2(:)).^2 );
end

% Get the spectrogram partition from the full spectrogram given the partition
% index p_ind
function P = get_partition(P,settings,p_ind)
    lag = settings.wnd_len - settings.noverlap;
    max_len = min(size(P,2), ceil(settings.plength*p_ind/lag));
    i0 = ceil( (settings.plength*(p_ind - 1) + 1)/lag );
    P = P(:,i0:max_len);

end


function test_msg(result)
    if(result)
        disp('------------------------ Test passed ------------------------');
    else
        disp('------------------------ Test failed ------------------------');
    end
end
