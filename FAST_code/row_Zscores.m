function [X, means, stdevs] = row_Zscores(X, means, stdevs)
% function [X, means, stdevs, bounds] = row_Zscores(X, means, stdevs)
%/ [X, means, stds, bounds] = row_Zscores(X, means, stds) 
%/      Computes z-scores of each entry in X using rowmean/stdev, (computes 
%/      mean and standard deviation for each row in input X, if not provided)    
%/
%/ Inputs:
%/      X: M x N (double), M data points with N features, 
%/         (columns of X should be normalized - first line of code
%/          normalizes columsn of X)
%/
%/ Optional inputs: 
%/      means  (optional): M x 1 (double), mean for each row 
%/      stdevs (optional): M x 1 (double), standard deviation for each row
%/          [If both means and stdevs are not provided as inputs, both are
%/           computed from rows of X]
%/
%/ Outputs:
%/      X 
%/      means:  M x 1 (double), mean for each row
%/      stdevs: M x 1 (double), standard deviation for each row
%/      bounds: M x 2 (double), minimum and maximum values found in each row 
%/

        %/ normalized columns of X
        X = normalize_columns(X, 2); %/ alternatively, this can be done outside of this function
    
        %/ computes mean/stdevs if both are not provided by user
        if nargin < 3    
            means  = mean(X,2);
            stdevs = std(X,[],2);
        end
        
% COMMENT OUT FOR NOW - NOT USED (Clara Yoon)
%         %/ computes bounds on values for each row
%         bounds(:,1)  = min(X,[],2);
%         bounds(:,2)  = max(X,[],2);
       
        %/ standardizes data: z = (x - mean) / stdev
        for i = 1:size(X,2)
            X(:,i) =  (X(:,i) - means)./stdevs;
        end
        
end