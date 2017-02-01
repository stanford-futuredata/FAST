cmake_minimum_required(VERSION 2.8)

project(FAST-pyDriver)
set(SOURCE_FILES MurmurHash3.cpp MurmurHash3.h toint64.cpp toint64.h MinHash.cpp MinHash.h SimilaritySearch.cpp SimilaritySearch.h main.cpp)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3 -g")
add_executable(main ${SOURCE_FILES})

