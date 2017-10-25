function v = haar_1d ( n, u )

%*****************************************************************************80
%
%% HAAR_1D computes the Haar transform of a vector.
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
%
%    Input, real U(N,1), the vector to be transformed.
%
%    Output, real V(N,1), the transformed vector.
%
  v = u(:);

  s = sqrt ( 2.0 );

  w = zeros ( n, 1 );

  m = n;

  while ( 1 < m )
  
    m = floor ( m / 2 );

    w(  1:  m) = ( v(1:2:2*m-1) + v(2:2:2*m) ) / s;
    w(m+1:m+m) = ( v(1:2:2*m-1) - v(2:2:2*m) ) / s;

    v(1:2*m) = w(1:2*m);

  end

  return
end
