function v = haar_2d ( u )

%*****************************************************************************80
%
%% HAAR_2D computes the Haar transform of an array.
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
%    Input, real U(M,N), the vector to be transformed.
%
%    Output, real V(M,N), the transformed vector.
%
  [ m, n ] = size ( u );

  v = u;

  s = sqrt ( 2.0 );

  w = zeros ( m, n );
%
%  Transform all columns.
%
  k = m;

  while ( 1 < k )
  
    k = floor ( k / 2 );

    w(  1:  k,:) = ( v(1:2:2*k-1,:) + v(2:2:2*k,:) ) / s;
    w(k+1:k+k,:) = ( v(1:2:2*k-1,:) - v(2:2:2*k,:) ) / s;

    v(1:2*k,:) = w(1:2*k,:);

  end
%
%  Transform all rows.
%
  k = n;

  while ( 1 < k )
  
    k = floor ( k / 2 );

    w(:,  1:  k) = ( v(:,1:2:2*k-1) + v(:,2:2:2*k) ) / s;
    w(:,k+1:k+k) = ( v(:,1:2:2*k-1) - v(:,2:2:2*k) ) / s;

    v(:,1:2*k) = w(:,1:2*k);

  end

  return
end

