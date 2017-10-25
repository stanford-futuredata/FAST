addpath('../SimilaritySearch/');

% mex mxAddSimilarityMatrix.cpp toint64.cpp SimilaritySearch.cpp
mex -largeArrayDims mxAddSimilarityMatrix.cpp ../SimilaritySearch/toint64.cpp ../SimilaritySearch/SimilaritySearch.cpp
