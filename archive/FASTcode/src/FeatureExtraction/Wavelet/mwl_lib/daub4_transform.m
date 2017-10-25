function y = daub4_transform ( n, x )

%*****************************************************************************80
%
%% DAUB4_TRANSFORM computes the DAUB4 transform of a vector.
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
  c = [  0.4829629131445341E+00; ...
         0.8365163037378079E+00; ...
         0.2241438680420133E+00; ...
        -0.1294095225512603E+00 ];

  y(1:n,1) = x(1:n);
  z(1:n,1) = 0.0;

  m = n;

  while ( 4 <= m )
  
    i = 1;

    for j = 1 : 2 : m - 1
      j0 = i4_wrap ( j,     1, m );
      j1 = i4_wrap ( j + 1, 1, m );
      j2 = i4_wrap ( j + 2, 1, m );
      j3 = i4_wrap ( j + 3, 1, m );
      z(i,1)     = c(1) * y(j0) + c(2) * y(j1) + c(3) * y(j2) + c(4) * y(j3);
      z(i+m/2,1) = c(4) * y(j0) - c(3) * y(j1) + c(2) * y(j2) - c(1) * y(j3);
      i = i + 1;
    end

    y(1:m,1) = z(1:m);

    m = floor ( m / 2 );

  end

  return
end
