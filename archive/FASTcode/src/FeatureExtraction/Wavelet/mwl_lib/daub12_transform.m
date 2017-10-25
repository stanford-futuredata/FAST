function y = daub12_transform ( n, x )

%*****************************************************************************80
%
%% DAUB12_TRANSFORM computes the DAUB12 transform of a vector.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 July 2011
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the dimension of the vector.
%    N must be a power of 2 and at least 4.
%
%    Input, real X(N), the vector to be transformed. 
%
%    Output, real Y(N), the transformed vector.
%
  c = [ ...
    0.1115407433501095; ...
    0.4946238903984533; ...
    0.7511339080210959; ...
    0.3152503517091982; ...
   -0.2262646939654400; ...
   -0.1297668675672625; ...
    0.0975016055873225; ...
    0.0275228655303053; ...
   -0.0315820393174862; ...
    0.0005538422011614; ...
    0.0047772575109455; ...
   -0.0010773010853085 ];
  p = 11;
  y(1:n,1) = x(1:n);
  m = n;
  q = floor ( ( p - 1 ) / 2 );

  while ( 4 <= m )
  
    i = 1;
    z(1:m,1) = 0.0;

    for j = 1 : 2 : m - 1

      mh = floor ( m / 2 );
      for k = 0 : 2 : p - 1
        j0 = i4_wrap ( j + k,     1, m );
        j1 = i4_wrap ( j + k + 1, 1, m );
        z(i,1)    = z(i,1)    + c(  k+1) * y(j0) + c(  k+2) * y(j1);
        z(i+mh,1) = z(i+mh,1) + c(p-k+1) * y(j0) - c(p-k  ) * y(j1);
      end

      i = i + 1;

    end

    y(1:m,1) = z(1:m);

    m = floor ( m / 2 );

  end

  return
end
