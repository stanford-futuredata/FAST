function y = daub20_transform ( n, x )

%*****************************************************************************80
%
%% DAUB20_TRANSFORM computes the DAUB20 transform of a vector.
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
     2.667005790055555E-02; ...
     1.881768000776914E-01; ...
     5.272011889317255E-01; ...
     6.884590394536035E-01; ...
     2.811723436605774E-01; ...
    -2.498464243273153E-01; ...
    -1.959462743773770E-01; ...
     1.273693403357932E-01; ...
     9.305736460357235E-02; ...
    -7.139414716639708E-02; ...
    -2.945753682187581E-02; ...
     3.321267405934100E-02; ...
     3.606553566956169E-03; ...
    -1.073317548333057E-02; ...
     1.395351747052901E-03; ...
     1.992405295185056E-03; ...
    -6.858566949597116E-04; ...
    -1.164668551292854E-04; ...
     9.358867032006959E-05; ...
    -1.326420289452124E-05 ];
  p = 19;
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
