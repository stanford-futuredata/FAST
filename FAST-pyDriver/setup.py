from distutils.core import setup, Extension
from Cython.Build import cythonize
import numpy
import os

#os.environ["CC"] = "gcc"

ext = Extension(
	name = 'cyInterface',
	sources = ["cyInterface.pyx", "MinHash.cpp", "MurmurHash3.cpp", "SimilaritySearch.cpp",
		"toint64.cpp"],
	language='c++',
	include_dirs=[numpy.get_include()],
	extra_compile_args=["-std=c++11"],
    extra_link_args=["-std=c++11"])

setup(name='cyInterface', ext_modules=cythonize(ext))

