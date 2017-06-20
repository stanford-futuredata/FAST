% Compile all MEX files required to run FAST
addpath(genpath('./'));
cd FeatureExtraction/Wavelet/cwl_lib/
compile_wavelet
cd ../../../SimilaritySearch/
compile_similarity_search
cd ../NetworkFAST/
compile_network_FAST
cd ../Postprocess/
compile_remove_duplicate_pairs
cd ..
