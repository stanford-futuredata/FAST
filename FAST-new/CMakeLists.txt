cmake_minimum_required(VERSION 2.8)

project(FAST)
set(SOURCE_FILES MurmurHash3.cpp MurmurHash3.h ReadOptions.h MinHash.cpp MinHash.h SimilaritySearch.cpp SimilaritySearch.h HashtableStats.cpp HashtableStats.h main.cpp)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -fopenmp  -std=c++11 -O3 -g")

# refer to http://stackoverflow.com/questions/6646405/how-do-you-add-boost-libraries-in-cmakelists-txt/6646746#6646746
set(Boost_USE_MULTITHREADED ON)
find_package( Boost COMPONENTS system log program_options filesystem REQUIRED )
include_directories( ${Boost_INCLUDE_DIRS} )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBOOST_LOG_DYN_LINK") # http://stackoverflow.com/questions/23137637/linker-error-while-linking-boost-log-tutorial-undefined-references

list(APPEND CMAKE_MODULE_PATH "cmake/modules/")
find_package(TBB COMPONENTS tbbmalloc tbbmalloc_proxy)
include_directories( ${TBB_INCLUDE_DIRS} )

add_executable(main ${SOURCE_FILES})
target_link_libraries( main ${Boost_PROGRAM_OPTIONS_LIBRARY} ${Boost_LOG_LIBRARY} ${Boost_SYSTEM_LIBRARY} ${Boost_FILESYSTEM_LIBRARY} ${TBB_LIBRARIES} )