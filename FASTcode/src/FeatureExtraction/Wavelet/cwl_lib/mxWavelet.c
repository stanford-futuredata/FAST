/*=================================================================
 * Wrapper for Wavelet transforms
 * @author Ossian O'Reilly
 *=================================================================*/ 
#include "mex.h"
#include "haar.h"
#include "wavelet.h"
#include <string.h>

#define assert( isOK )        ( (isOK) ? (void)0 : (void) mexErrMsgTxt("assert failed\n") )
double* wavelet_transform(int num_rows, int num_cols, int basis, double x[], double y[]);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {                    

	/* Check for proper number of arguments. */
    if ( nrhs != 2 ) {
        mexErrMsgIdAndTxt("Minhash:rhs",
                "This function takes two input arguments.");
    }
    
    int num_rows = mxGetM(prhs[0]);      /* Number of rows (number of samples, if vector) */
    int num_cols = mxGetN(prhs[0]);            /* Number of columns */
    int basis = (int)mxGetScalar(prhs[1]);  /* Wavelet basis */
    
    /* Get input data */ 
    double *x = (double*)mxGetPr(prhs[0]);

    double *y;

    /* Set pointer for output data */
    plhs[0] = mxCreateDoubleMatrix(num_rows, num_cols, mxREAL);
    double *out = (double*)mxGetPr(plhs[0]);  

    /* copy input data */
    /* memcpy(out, x, num_cols * num_rows * sizeof(double) ); */

    /* Apply wavelet transform */
    y = wavelet_transform(num_rows, num_cols, basis, x, y);

    /* copy output data to MATLAB memory */
    memcpy(out, y, num_cols * num_rows * sizeof(double) ); 

    free(y);
   
    return;
}                     

/* Vector input wavelet transform */
double* wavelet_transform(int num_rows, int num_cols, int basis, double x[], double y[]){
    switch (basis){
        case -2:
            y = ohaar_1d(num_rows,x);
            break;
        case -1:
            y = ohaar_2d(num_rows,num_cols,x);
            break;
        case 0:
            y = haar_1d(num_rows,x);
            break;
        case 1:
            y = haar_2d(num_rows,num_cols,x);
            break;
        case 2:
            y = daub2_transform(num_rows,x);
            break;
        case 3:
            y = daub4_transform(num_rows,x);
            break;
        case 4:
            y = daub6_transform(num_rows,x);
            break;
        case 5:
            y = daub8_transform(num_rows,x);
            break;
        case 6:
            y = daub10_transform(num_rows,x);
            break;
        case 7:
            y = daub12_transform(num_rows,x);
            break;
        case 8:
            y = daub14_transform(num_rows,x);
            break;
        case 9:
            y = daub16_transform(num_rows,x);
            break;
        case 10:
            y = daub18_transform(num_rows,x);
            break;
        case 11:
            y = daub20_transform(num_rows,x);
            break;
    }
    return(y);
}
