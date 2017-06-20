function y = mdwt(x,wl_basis)
% Interface to J. Burkardt's C Wavelet transform library
% 
% Usage:
% y = mldwt(x,wl_basis)
% 
% x:        Input data (column-vector). 
% wl_basis: Wavelet basis to use. Possible choices:
%           haar_1d, daub2, daub4, daub6, daub8, daub10, daub12
%           daub14, daub16, daub18, daub20.
% y:        Output data. The transformed input data (column-vector). 

switch wl_basis
    case 'haar_1d'
        y = mxWavelet(x,0);
    case 'haar_2d'
        y = mxWavelet(x,1);
    case 'daub2'
        y = mxWavelet(x,2);
    case 'daub4'
        y = mxWavelet(x,3);
    case 'daub6'
        y = mxWavelet(x,4);
    case 'daub8'
        y = mxWavelet(x,5);
    case 'daub10'
        y = mxWavelet(x,6);
    case 'daub12'
        y = mxWavelet(x,7);
    case 'daub14'
        y = mxWavelet(x,8);
    case 'daub16'
        y = mxWavelet(x,9);
    case 'daub18'
        y = mxWavelet(x,10);
    case 'daub20'
        y = mxWavelet(x,11);
end


end
