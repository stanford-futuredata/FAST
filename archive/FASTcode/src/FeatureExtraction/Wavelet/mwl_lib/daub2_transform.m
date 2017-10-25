function y = daub2_transform ( n, x )

%*****************************************************************************80
%
%% DAUB2_TRANSFORM computes the DAUB2 transform of a vector.
%
%  Discussion:
%
%    DAUB2 is better known as the Haar transform.
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
%    N must be a power of 2.
%
%    Input, real X(N), the vector to be transformed.
%
%    Output, real Y(N), the transformed vector.
%
  c = [ 7.071067811865475E-01; ...
        7.071067811865475E-01 ];

  y(1:n,1) = x(1:n);
  z(1:n,1) = 0.0;

  m = n;

  while ( 2 <= m )

    m = floor ( m / 2 );

    for i = 1 : m
      z(i,1)   = c(1) * ( y(2*i-1) + y(2*i) );
      z(i+m,1) = c(2) * ( y(2*i-1) - y(2*i) );
    end

    y(1:2*m,1) = z(1:2*m,1);

  end

  return
end
