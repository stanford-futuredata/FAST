function fingerprints = fingerprint_demo(nfp,nbits,NNZ)     
% Generates a fingerprint consisting of 1-bits or 0-bits.
% The fingerprints are by translating
% an image a of a block of 1-bits in the horizontal direction. It is only
% used for testing purposes and has no value beyond that.
% The bitrep function (see below) can be used by actual fingerprinting schemes
% to convert -1 entries to bits. 
%
% Usage:
% fingerprints = fingerprint_demo(nfp)
% nfp: Number of fingerprints to generate
% nbits: Number of bits in the fingerprint
% NNZ: Number of non-zero bits in the fingerprint
% fingerprints: matrix of dimension nfp x nbits. Each fingerprint is a vector of
% 1-bits and 0-bits.

fingerprints = false(nbits,nfp);


for i=1:nfp
    x = translation(i,nbits,NNZ);
    fingerprints(:,i) = x; 
end  
end

% Translation test
% Generate a sparse image of size 32x128
% with 200 non-zero entries that can be either 1 or -1
% and periodically translate rx steps in the x-direction
function y = translation(rx,nbits,NNZ)
    y = false(nbits,1);
    A = true(NNZ,1);
    y(1:NNZ) = A; 
    y = circshift(y,rx);
end  

function y = normal()
 NNZ = 200;
    N = 32;
    M = 128;
    n = 10; 
    m = 20;
    y = spalloc(N,M,NNZ);
    A = ones(n,m);
    b = floor( 1 + 0.2*n*m*abs(randn(ceil(NNZ),1)));
    b
    A(b) = 0;
    y(1:n,1:m) = A;
end

%Construct the bit representation of a signed vector
% +1 is encoded as 01 and -1 is encoded as 10, and 0 is encoded as 00
%example: x = [1 -1 0 1] returns y = [01 10 00 01] (spaces are only used for
%clarity)
function y = bitrep(x)
    x = x(:);
   y = false(2*length(x),1);
   ind = 1:length(x);
   indp = 2 * ind( x == 1 );
   indm = 2 * ind( x == -1 ) - 1;
   y(indp) = true;
   y(indm) = true;
end 
