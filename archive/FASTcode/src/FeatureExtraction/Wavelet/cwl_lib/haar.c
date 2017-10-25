# include <stdlib.h>
# include <stdio.h>
# include <math.h>
# include <time.h>
#include <string.h>
# include "haar.h"

/******************************************************************************/

double* haar_1d ( int n, double x[] )

/******************************************************************************/
/*
  Purpose:

    HAAR_1D computes the Haar transform of a vector.

  Licensing:

    This code is distributed under the GNU LGPL license.

  Modified:

    14 March 2011

  Author:

    John Burkardt

  Parameters:

    Input, int N, the dimension of the vector.

    Input/output, double X[N], on input, the vector to be transformed.
    On output, the transformed vector.
*/
{
  int i;
  int m;
  double s;
  double *y;
  double *z;

  s = sqrt ( 2.0 );

  y = ( double * ) calloc ( n , sizeof ( double ) );
  z = r8vec_copy_new ( n, x );
  m = n;
  
  while ( 1 < m )
  {
    m = m / 2;
    for ( i = 0; i < m; i++ )
    {
      y[i]   = ( z[2*i] + z[2*i+1] ) / s;
      y[i+m] = ( z[2*i] - z[2*i+1] ) / s;
    }
    for ( i = 0; i < m * 2; i++ )
    {
      z[i] = y[i];
    }
  }

  free ( y );

  return z;
}

/******************************************************************************/

void haar_1d_inverse ( int n, double x[] )

/******************************************************************************/
/*
  Purpose:

    HAAR_1D_INVERSE computes the inverse Haar transform of a vector.

  Discussion:

    The current version of this function requires that N be a power of 2.
    Otherwise, the function will not properly invert the operation of HAAR_1D.

  Licensing:

    This code is distributed under the GNU LGPL license.

  Modified:

    14 March 2011

  Author:

    John Burkardt

  Parameters:

    Input, int N, the dimension of the vector.  For proper calculation,
    N must be a power of 2.

    Input/output, double X[N], on input, the vector to be transformed.
    On output, the transformed vector.
*/
{
  int i;
  int m;
  double s;
  double *y;

  s = sqrt ( 2.0 );

  y = ( double * ) malloc ( n * sizeof ( double ) );
/*
  Not necessary unless N not a power of 2 works...
*/
  for ( i = 0; i < n; i++ )
  {
    y[i] = 0.0;
  }

  m = 1;
  while ( m * 2 <= n )
  {
    for ( i = 0; i < m; i++ )
    {
      y[2*i]   = ( x[i] + x[i+m] ) / s;
      y[2*i+1] = ( x[i] - x[i+m] ) / s;
    }
    for ( i = 0; i < m * 2; i++ )
    {
      x[i] = y[i];
    }
    m = m * 2;
  }

  free ( y );

  return;
}

double* ohaar_1d ( int n, double x[] ) 
{
  int i;
  int m;
  double s;
  double *y;
  double *z;

  s = 7.071067811865475E-01; 
  y = ( double * ) malloc ( n * sizeof ( double ) );
  z = ( double * ) malloc ( n * sizeof ( double ) );
  memcpy(z, x,n * sizeof(double) );
  m = n;
  while ( 1 < m )
  {
    m = m / 2;  
    for ( i = 0; i != m; ++i ){
      y[m + i] = ( z[2*i] - z[2*i+1] ) * s;
      z[i] = ( z[2*i] + z[2*i+1] ) * s;
    }
  }
  y[0] = z[0];
  free (z);
  return y;
}

double* ohaar_2d ( int m, int n, double x[] ) 
{
  int i, j;
  int k;
  double s,p;
  double *y;
  double *z;

  s = 7.071067811865475E-01; 
  p = 0.5;
  y = ( double * ) malloc ( n * m * sizeof ( double ) );
  z = ( double * ) malloc ( n * m * sizeof ( double ) );
  memcpy(z, x,n * m * sizeof(double) );
  m = n;

  /* Transform columns */
  k = m;
  while ( 1 < k )
  {
    k = k * p;  
    for ( j = 0; j != n; ++j )
        for ( i = 0; i != k; ++i )
        {
            y[k+i+j*m] = ( z[2*i+j*m] - z[2*i+1+j*m] ) * s;
            z[i  +j*m] = ( z[2*i+j*m] + z[2*i+1+j*m] ) * s;
        }
  }
  y[0] = z[0];

  /* Transform rows */
  k = n;
  while ( 1 < k )
  {
    k = k * p;  
    for ( j = 0; j != k; ++j )
        for ( i = 0; i != m; ++i )
        {
            y[i+(k+j)*m] = ( z[i+2*j*m] - z[i+(2*j+1)*m] ) * s;
            z[i+(  j)*m] = ( z[i+2*j*m] + z[i+(2*j+1)*m] ) * s;
        }
  }
  y[0] = z[0];


  free (z);
  return y;
}

double* haar_2d ( int m, int n, double u[] )

/******************************************************************************/
/*
  Purpose:

    HAAR_2D computes the Haar transform of an array.

  Licensing:

    This code is distributed under the GNU LGPL license.

  Modified:

    18 March 2011

  Author:

    John Burkardt

  Parameters:

    Input, int M, N, the dimensions of the array.
    M and N should be powers of 2.

    Input/output, double U[M*N], the array to be transformed.
*/
{
  int i;
  int j;
  int k;
  double s, p;
  double *v, *z;

  s = 7.071067811865475E-01;
  p = 0.5;

  v = ( double * ) malloc ( m * n * sizeof ( double ) );
  z = ( double * ) malloc ( m * n * sizeof ( double ) );
  memcpy(z, u, m * n * sizeof(double) );

/*
  Transform all columns.
*/
  k = m;

  while ( 1 < k )
  {
    k = k * p;

    for ( j = 0; j != n; ++j )
    {
      for ( i = 0; i != k; ++i )
      {
        v[i  +j*m] = ( z[2*i+j*m] + z[2*i+1+j*m] ) * s;
        v[k+i+j*m] = ( z[2*i+j*m] - z[2*i+1+j*m] ) * s;
      }
    }
    for ( j = 0; j < n; j++ )
    {
      for ( i = 0; i < 2 * k; i++ )
      {
        z[i+j*m] = v[i+j*m];
      }
    }
  }
/*
  Transform all rows.
*/
  k = n;

  while ( 1 < k )
  { 
    k = k * p;

    for ( j = 0; j < k; j++ )
    {
      for ( i = 0; i < m; i++ )
      {
        v[i+(  j)*m] = ( z[i+2*j*m] + z[i+(2*j+1)*m] ) * s;
        v[i+(k+j)*m] = ( z[i+2*j*m] - z[i+(2*j+1)*m] ) * s;
      }
    }

    for ( j = 0; j < 2 * k; j++ )
    {
      for ( i = 0; i < m; i++ )
      {
        z[i+j*m] = v[i+j*m];
      }
    }
  }
  free ( v );

  return z;
}







/******************************************************************************/

void haar_2d_inverse ( int m, int n, double u[] )

/******************************************************************************/
/*
  Purpose:

    HAAR_2D_INVERSE inverts the Haar transform of an array.

  Licensing:

    This code is distributed under the GNU LGPL license.

  Modified:

    18 March 2011

  Author:

    John Burkardt

  Parameters:

    Input, int M, N, the dimensions of the array.
    M and N should be powers of 2.

    Input/output, double U[M*N], the array to be transformed.
*/
{
  int i;
  int j;
  int k;
  double s;
  double *v;

  s = sqrt ( 2.0 );

  v = ( double * ) malloc ( m * n * sizeof ( double ) );

  for ( j = 0; j < n; j++ )
  {
    for ( i = 0; i < m; i++ )
    {
      v[i+j*m] = u[i+j*m];
    }
  }
/*
  Inverse transform of all rows.
*/
  k = 1;

  while ( k * 2 <= n )
  {
    for ( j = 0; j < k; j++ )
    {
      for ( i = 0; i < m; i++ )
      {
        v[i+(2*j  )*m] = ( u[i+j*m] + u[i+(k+j)*m] ) / s;
        v[i+(2*j+1)*m] = ( u[i+j*m] - u[i+(k+j)*m] ) / s;
      }
    }

    for ( j = 0; j < 2 * k; j++ )
    {
      for ( i = 0; i < m; i++ )
      {
        u[i+j*m] = v[i+j*m];
      }
    }
    k = k * 2;
  }
/*
  Inverse transform of all columns.
*/
  k = 1;

  while ( k * 2 <= m )
  {
    for ( j = 0; j < n; j++ )
    {
      for ( i = 0; i < k; i++ )
      {
        v[2*i  +j*m] = ( u[i+j*m] + u[k+i+j*m] ) / s;
        v[2*i+1+j*m] = ( u[i+j*m] - u[k+i+j*m] ) / s;
      }
    }

    for ( j = 0; j < n; j++ )
    {
      for ( i = 0; i < 2 * k; i++ )
      {
        u[i+j*m] = v[i+j*m];
      }
    }
    k = k * 2;
  }
  free ( v );

  return;
}
/******************************************************************************/
