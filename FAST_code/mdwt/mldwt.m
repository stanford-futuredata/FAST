function y = mldwt(x,wl_basis)
% Interface to J. Burkardt's MATLAB Wavelet transform library
% 
% Usage:
% y = mldwt(x,wl_basis)
% 
% x:        Input data (column-vector). 
% wl_basis: Wavelet basis to use. Possible choices:
%           haar_1d, daub2, daub4, daub6, daub8, daub10, daub12
%           daub14, daub16, daub18, daub20.
% y:        Output data. The transformed input data (column-vector).

m = size(x,1);
n = size(x,2);

switch wl_basis
    case 'haar_1d'
        y = haar_1d(m,x);
    case 'haar_2d'
        y = haar_2d(x);
    case 'daub2'
        y = daub2_transform(m,x);
    case 'daub4'
        y = daub4_transform(m,x);
    case 'daub6'
        y = daub6_transform(m,x);
    case 'daub8'
        y = daub8_transform(m,x);
    case 'daub10'
        y = daub10_transform(m,x);
    case 'daub12'
        y = daub12_transform(m,x);
    case 'daub14'
        y = daub14_transform(m,x);
    case 'daub16'
        y = daub16_transform(m,x);
    case 'daub18'
        y = daub18_transform(m,x);
    case 'daub20'
        y = daub20_transform(m,x);
end


end 
