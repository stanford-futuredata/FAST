function [mem,memunit] = logmemory()
% [status,msg] = system('top -n 1 -u ceyoon|grep MATLAB');
% msg = strsplit(strtrim(msg));
% mem = msg(6);
% mem = cell2mat(mem);
% memstr = mem(1:end-1);
% memunit = mem(end); % units (MB, GB)
% mem = str2num(memstr); % memory

% [mem,memunit] = system('top -n 1 -u ceyoon|grep MATLAB');

[mem,memunit] = system('top -n 1 -u ceyoon');
end