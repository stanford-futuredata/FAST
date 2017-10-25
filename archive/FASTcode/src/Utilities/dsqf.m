function y = dsqf(x,dx,xmax,thres)
% Dead-space quantization with binary fill-in
% 
% Usage:
% function y = dsq(x,dx,thres)
% x     : input data (vector) 
% dx    : quantization step  
% xmax  : maximum value 
% thres : threshold. Values below threshold are not filled-in
% y     : binary output data (vector)
% the dimension of y is [ len(x) , 2n ], where 
% n = (xmax - thres)/dx

n = (xmax - thres)/dx;


y = false(length(x),2*n);

% Take all values the exceed the threshold
xp = x > thres;
xm = x < -thres;
% Compute corresponding indices for xp and xm
range = 1:length(x);
xpi = range(xp);
xmi = range(xm);

% Compute number of fill-ins
xp_fill = floor(   (x(xp) - thres)/dx  + 0.5*dx ) + 1;
xm_fill = floor( - (x(xm) + thres)/dx  + 0.5*dx ) + 1;

xp_fill(xp_fill > n) = n;
xm_fill(xm_fill > n) = n;

for i=1:length(xpi)
    y(xpi(i),(n + 1):(n + xp_fill(i))) = true;
end

for i=1:length(xmi)
    y(xmi(i),(n-xm_fill(i)+1):n) = true;
end  

end
