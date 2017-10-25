function [t,data,SAChdr] = fget_sac_window(t0,tl,filename)
%[t,data,SAChdr] = fget_sac(filename)

% read sac into matlab 
% written by Zhigang Peng, edited by Yihe Huang
% program called
% [head1, head2, head3, data]=sac(filename);
% [SAChdr]=sachdr(head1, head2, head3);

% Updated Mon Jul 14 2014

if nargin <1, error('ERROR!! No input file name'); end

[head1, head2, head3, delta, data]=sac_window(t0,tl,filename);
[SAChdr]=sachdr(head1, head2, head3);
t=0:delta:tl;
% t = [t0:SAChdr.times.delta:(tl-t0+1)*SAChdr.times.delta+t0]';
