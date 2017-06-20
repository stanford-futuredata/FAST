function y = daub18_transform ( n, x )

%*****************************************************************************80
%
%% DAUB18_TRANSFORM computes the DAUB18 transform of a vector.
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
     3.807794736387834E-02; ...
     2.438346746125903E-01; ...
     6.048231236901111E-01; ...
     6.572880780513005E-01; ...
     1.331973858250075E-01; ...
    -2.932737832791749E-01; ...
    -9.684078322297646E-02; ...
     1.485407493381063E-01; ...
     3.072568147933337E-02; ...
    -6.763282906132997E-02; ...
     2.509471148314519E-04; ...
     2.236166212367909E-02; ...
    -4.723204757751397E-03; ...
    -4.281503682463429E-03; ...
     1.847646883056226E-03; ...
     2.303857635231959E-04; ...
    -2.519631889427101E-04; ...
     3.934732031627159E-05 ];
  p = 17;
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
