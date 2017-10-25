function v = haar_2d_inverse ( u )

%*****************************************************************************80
%
%% HAAR_2D_INVERSE inverts the Haar transform of an array.
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
%    Input, integer M, N, the dimensions of the array.
%
%    Input, real U(M,N), the vector to be transformed.
%
%    Output, real V(M,N), the transformed vector.
%
  [ m, n ] = size ( u );

  v = u;

  s = sqrt ( 2.0 );

  w = zeros ( m, n );
%
%  Inverse transform of all rows.
%
  k = 1;

  while ( k * 2 <= n )

    w(:,1:2:2*k-1) = ( v(:,1:k) + v(:,1+k:k+k) ) / s;
    w(:,2:2:2*k)   = ( v(:,1:k) - v(:,1+k:k+k) ) / s;

    v(:,1:2*k) = w(:,1:2*k);
    k = k * 2;

  end
%
%  Inverse transform of all columns.
%
  k = 1;

  while ( k * 2 <= m )

    w(1:2:2*k-1,:) = ( v(1:k,:) + v(1+k:k+k,:) ) / s;
    w(2:2:2*k,:)   = ( v(1:k,:) - v(1+k:k+k,:) ) / s;

    v(1:2*k,:) = w(1:2*k,:);
    k = k * 2;

  end

  return
end
