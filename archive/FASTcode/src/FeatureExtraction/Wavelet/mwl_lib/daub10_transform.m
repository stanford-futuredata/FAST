function y = daub10_transform ( n, x )

%*****************************************************************************80
%
%% DAUB10_TRANSFORM computes the DAUB10 transform of a vector.
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
    0.1601023979741929; ...
    0.6038292697971895; ...
    0.7243085284377726; ...
    0.1384281459013203; ...
   -0.2422948870663823; ...
   -0.0322448695846381; ...
    0.0775714938400459; ...
   -0.0062414902127983; ...
   -0.0125807519990820; ...
    0.0033357252854738 ];
  p = 9;
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
