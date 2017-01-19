function [head1, head2, head3, data]=sac(filename)
% Read one single SAC format file and generate head1 (float matrix),
% head2 (int matrix), and head3 (char matrix).

% head3 here is integer matrix, to show it under ASCII, just char(head3).

% Written by Xianglei Huang  03/2000
% Modified by Zhigang Peng 10/17/00 17:40:51

fid=fopen(filename, 'rb');

if (fid==-1)
  disp('can not open input data file format, press CTRL-C to exit \n');
  pause
end

head1=fread(fid, [5, 14], 'float32');
head2=fread(fid, [5, 8], 'int32');
head3=fread(fid, [24, 8], 'char');
head1=head1'; head2=head2'; head3=head3';
npts=head2(2, 5);
data=fread(fid, npts, 'float32');

% change Thu Nov  9 14:18:38 PST 2000
% add the checking of the output number of function argv.
if(nargout == 1) % only interest in the data, not header.
data=fread(fid, npts, 'float32');
end

fclose(fid);
