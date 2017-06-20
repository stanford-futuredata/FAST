function y = daub14_transform ( n, x )

%*****************************************************************************80
%
%% DAUB14_TRANSFORM computes the DAUB14 transform of a vector.
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
     7.785205408500917e-02; ...
     3.965393194819173e-01; ...
     7.291320908462351e-01; ...
     4.697822874051931e-01; ...
    -1.439060039285649e-01; ...
    -2.240361849938749e-01; ...
     7.130921926683026e-02; ...
     8.061260915108307e-02; ...
    -3.802993693501441e-02; ...
    -1.657454163066688e-02; ...
     1.255099855609984e-02; ...
     4.295779729213665e-04; ...
    -1.801640704047490e-03; ...
     3.537137999745202e-04 ];
  p = 13;
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
