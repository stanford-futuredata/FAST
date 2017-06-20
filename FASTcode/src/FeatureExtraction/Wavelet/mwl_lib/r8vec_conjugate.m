function d = r8vec_conjugate ( c )

%*****************************************************************************80
%
%% R8VEC_CONJUGATE reverses a vector and negates even-indexed entries.
%
%  Discussion:
%
%    There are many times in wavelet computations when such an operation
%    is invoked.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 August 2011
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real C(N), the input vector.
%
%    Output, real D(N), the "conjugated" vector.
%
  n = length ( c );

  d = c(n:-1:1);

  d(2:2:n) = - d(2:2:n);

  return
end
