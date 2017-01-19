function v = haar_1d_inverse ( n, u )

%*****************************************************************************80
%
%% HAAR_1D_INVERSE inverts the Haar transform of a vector.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    15 March 2011
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the length of the vector.
%    N must be a power of 2.
%
%    Input, real U(N,1), the vector to be transformed.
%
%    Output, real V(N,1), the transformed vector.
%
  v = u(:);

  s = sqrt ( 2.0 );

  w = zeros ( n, 1 );

  m = 1;

  while ( m * 2 <= n )

    w(1:2:2*m-1) = ( v(1:m) + v(1+m:m+m) ) / s;
    w(2:2:2*m)   = ( v(1:m) - v(1+m:m+m) ) / s;

    v(1:2*m) = w(1:2*m);
    m = m * 2;

  end

  return
end
