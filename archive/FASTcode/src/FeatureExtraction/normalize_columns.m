function [X, colnorm] = normalize_columns(X, pnorm)
%/ 
%/ [X, colnorm] = normalize_columns(X, pnorm)
%/      Normalizes each row in matrix X, with respect to the vector norm 
%/      given by pnorm. Returns matrix of normalized columns and norms of original columns 
%/
%/ Input: 
%/      X:    M x N (double), data matrix
%/
%/ Optional Input:
%/      pnorm (default 2): vector norm to be used for column normalization
%/          see documentation for Matlab <norm> function for details.
%/          options: 2 (default) | positive integer scalar | Inf | -Inf | 'fro'
%/
%/ Output:
%/      X:          M x N (double), data matrix with columns normalized to
%/                      length 1, as measured by pnorm
%/      colnorm:    N x 1 (double), column norms of original data matrix
%/                      prior to normalization
%/


    if nargin == 1
        pnorm = 2;
    end

    N = size(X,2);
    colnorm = zeros(N,1);
    
    for i = 1:N
        colnorm(i,1) = norm(X(:,i),pnorm);
        X(:,i) = X(:,i)/colnorm(i,1);
    end

end