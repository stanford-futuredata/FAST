function [t,data,SAChdr] = fget_sac(filename)
%[t,data,SAChdr] = fget_sac(filename)

% read sac into matlab 
% written by Zhigang Peng
% program called
% [head1, head2, head3, data]=sac(filename);
% [SAChdr]=sachdr(head1, head2, head3);

% Updated Mon Jul 30 11:21:24 PDT 2001

if nargin <1, error('ERROR!! No input file name'); end

[head1, head2, head3, data]=sac(filename);
[SAChdr]=sachdr(head1, head2, head3);
t = [SAChdr.times.b:SAChdr.times.delta:(SAChdr.data.trcLen-1)*SAChdr.times.delta+SAChdr.times.b]';
