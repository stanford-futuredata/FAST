from distutils.core import setup, Extension
from Cython.Build import cythonize
import numpy

# First create an Extension object with the appropriate name and sources
ext = Extension(
                name="min_hash",
                sources=["toint64.cpp","min_hash.pyx"],
                language="c++",
                include_dirs=[numpy.get_include()],
                extra_compile_args=["-std=c++11"],
                extra_link_args=["-std=c++11"])

# Use cythonize on the extension object.
setup(ext_modules=cythonize(ext))

#from distutils.core import setup
#from Cython.Build import cythonize
#
#setup( 
#    name = 'Hello World app',
#    ext_modules = cythonize("min_hash.pyx")    
#)