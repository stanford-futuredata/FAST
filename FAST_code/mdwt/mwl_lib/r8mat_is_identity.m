function error_frobenius = r8mat_is_identity ( n, a )

%*****************************************************************************80
%
%% R8MAT_IS_IDENTITY determines if a matrix is the identity.
%
%  Discussion:
%
%    The routine returns the Frobenius norm of A - I.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 November 2007
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the order of the matrix.
%
%    Input, real A(N,N), the matrix.
%
%    Output, real ERROR_FROBENIUS, the Frobenius norm
%    of the difference matrix A - I, which would be exactly zero
%    if A were the identity matrix.
%
  error_frobenius = 0.0;

  for i = 1 : n
    for j = 1 : n
      if ( i == j )
        error_frobenius = error_frobenius + ( a(i,j) - 1.0 )^2;
      else
        error_frobenius = error_frobenius + a(i,j)^2;
      end
    end 
  end

  error_frobenius = sqrt ( error_frobenius );

  return
end
