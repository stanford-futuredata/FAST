function mdwt_driver(m,n,num_iter)
% Driver function for testing MATLAB/MEX wavelet transforms.
% Displays l2-error and runtime statistics.
% the functions mdwt() interfaces with the MEX wavelet functions, 
% whereas mldwt() interfaces with the MATLAB wavelet functions. 
% mdwt() operators on a single column vector 
%
% Usage:
% mdwt_driver(m,n,num_iter)
%
% 2^m      : (rows) number of wavelet samples
% 2^n      : (cols)
% num_iter : number of wavelet transforms to compute

%Include Burkardt's matlab wavelet library
addpath('mwl_lib');
%Include MEX interface to Burkardt's C wavelet library
addpath('cwl_lib');

if(nargin < 1)
    %
    m = 8;
    n = 8;
end
if(nargin < 2)
    num_iter = 1000;
end

%Wavelet bases to test
wl_basis = {'haar_1d','daub2','daub4','daub6','daub8','daub10' ...
            'daub12','daub14','daub16','daub18','daub20'};

disp(['Running wavelet 2D-transform test. Vector MEX input, vector length = ' ...
num2str(2^m) ' x ' num2str(2^n) '. Number of wavelet transforms: ' num2str(num_iter) ]);
e = dwt_error(m,n,'haar_2d');
ml_T = dwt_time(@mldwt,'haar_2d',m,n,num_iter);
m_T = dwt_time(@mdwt,'haar_2d',m,n,num_iter);
wl_msg('haar_2d',e,ml_T,m_T,{'MATLAB: ','MEX: '});

n = 0;
disp(['Running wavelet transform test. Vector MEX input, vector length = ' ...
num2str(2^m) '. Number of wavelet transforms: ' num2str(num_iter) ]);
for i=1:length(wl_basis)
        e = dwt_error(m,n,wl_basis{i});
        ml_T = dwt_time(@mldwt,wl_basis{i},m,n,num_iter);
        m_T = dwt_time(@mdwt,wl_basis{i},m,n,num_iter);
        wl_msg(wl_basis{i},e,ml_T,m_T,{'MATLAB: ','MEX: '});
end

end

% Error computation for MATLAB wavelet and MEX wavelet
function e = dwt_error(m,n,wl_basis)
    x = randn(2^m,2^n);
    ml_y = mldwt(x,wl_basis);
    m_y = mdwt(x,wl_basis);
    e = l2_error(ml_y(:),m_y(:));
end

%Timing for any of the wavelet interface functions
function T = dwt_time(f,wl_basis,m,n,num_iter)
     x = randn(2^m,2^n);
     t = tic;
    for i=1:num_iter
        y = f(x,wl_basis);
    end
    T = toc(t);
end

%Output message showing error and timing
function wl_msg(wl_basis,e,ml_T,m_T,str)
    disp([wl_basis, 9 'l2-error: ' num2str(roundn(e,-3)), ...
                    9  str{1}, num2str(roundn(ml_T,-3)), ' s' ...
                    9  str{2}, num2str(roundn(m_T,-3)), ' s' ... 
                    9 'Speedup: ' num2str(roundn(ml_T/m_T,-2))]);
end

%l2-error computation
function e = l2_error(x,y)
    e = sqrt( sum((x-y).^2) );
end
