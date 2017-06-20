function y = toint64(x)
   y = uint64(0);
   x = uint8(x);
   for i=1:length(x) 
    for j=1:8
        a = bitget(x(i),j);
        y = bitset(y,j + 8*(i-1),a);
    end
   end
end   
