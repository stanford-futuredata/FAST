function y = daub6_transform ( n, x )

%*****************************************************************************80
%
%% DAUB6_TRANSFORM computes the DAUB6 transform of a vector.
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
  c = [  0.3326705529500826E+00; ...
         0.8068915093110925E+00; ...
         0.4598775021184915E+00; ...
       - 0.1350110200102545E+00; ...
       - 0.08544127388202666E+00; ...
         0.03522629188570953E+00 ];
  y(1:n,1) = x(1:n);
  z(1:n,1) = 0.0;

  p = 5;
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
