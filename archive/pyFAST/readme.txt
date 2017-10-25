pyFAST codes
Karianne Bergen 11/14/2016

Dependencies:
numpy  (NumPy package)
scipy  (SciPy package)   
pywt   (PyWavelets package)
skimage (scikit-image package)
sklearn (scikit-learn package)
mmh3    (mmh3 package - python wrapper for MurmurHash3)
math   
copy
sys
time

in /similarity_search folder, must build with cython:
python setup.py build_ext --inplace


Example:
scr_FASTMinHashLSHpy.py 
1) extracts binary fingerprints for 24hr of single-channel continuous data, 
2) Performs all-to-all search for similar pairs of fingerprints using MinHash/LSH-based approximate similarity search
3) Performs all-to-some search for similar pairs of fingerprints, where only a subset of the data (in this case randomly selected) is included in the fingerprint database and the full set of fingerprints are used as queries against the database set.