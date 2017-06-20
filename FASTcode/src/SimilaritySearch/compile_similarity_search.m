%Compile with boost
%mex -v CXXFLAGS='-std=c++11' mxSimilaritySearch.cpp toint64.cpp MinHash.cpp MurmurHash3.cpp SimilaritySearch.cpp -I/usr/local/boost_1_53/include
%Compile without voting
%mex mxSimilaritySearch.cpp toint64.cpp MinHash.cpp MurmurHash3.cpp SimilaritySearch.cpp

%Compile with voting
% mex mxSimilaritySearchV.cpp toint64.cpp MinHash.cpp MurmurHash3.cpp SimilaritySearch.cpp
mex -largeArrayDims mxSimilaritySearchV.cpp toint64.cpp MinHash.cpp MurmurHash3.cpp SimilaritySearch.cpp
