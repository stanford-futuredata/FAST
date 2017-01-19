function wtSac(sacFile, hd, data)
% wtSac(sacFile, hd, data)
% write SAC format data

aa=fopen(sacFile,'w');
if aa<0
  sacFile
  return;
end
fwrite(aa, hd(1:70), 'single');
fwrite(aa, hd(71:158), 'int');
fwrite(aa, data,'single');
fclose(aa);
