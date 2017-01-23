cimport numpy as np
import numpy as np
from libcpp cimport bool
from libcpp.map cimport map as cmap
from libcpp.vector cimport vector
from libc.stdint cimport uint8_t, uint32_t, uint64_t, uint16_t

cdef class SearchParam:
	cdef public int nfuncs, ntbls, nvotes, near_repeats
	cdef public long limit

	def __cinit__(self, int nfuncs, int ntbls, int nvotes, int near_repeats, long limit):
		self.nfuncs = nfuncs
		self.ntbls = ntbls
		self.nvotes = nvotes
		self.near_repeats = near_repeats
		self.limit = limit

cdef class Param:
	cdef public SearchParam searchParam
	cdef public int numPartitions, fingerprintLength, fingerprintLag, t_value
	cdef public float windowDuration, windowLag
	cdef public str fileNameStr, saveVersion

	def __cinit__(self, fname):
		self.fileNameStr = fname
		if '24hr' in fname:
			self.numPartitions = 3
			self.windowDuration = 10.0
			self.windowLag = 0.1
			self.fingerprintLength = 100
			self.fingerprintLag = 10
			self.t_value = 800
			self.saveVersion = '-v7'
			self.searchParam = SearchParam(5, 100, 4, 5, 4e9)
		elif '3month' in fname:
			self.numPartitions = 540 # 92 days
			self.windowDuration = 3.0
			self.windowLag = 0.03
			self.fingerprintLength = 64
			self.fingerprintLag = 10
			self.t_value = 800
			self.saveVersion = '-v7.3'
			self.searchParam = SearchParam(8, 100, 4, 5, 4e9)

cdef extern from "MinHash.h":
	void MinHashMM_Block_32(const bool *fp, int nfp, int fp_dim, int ntimes, uint32_t seed,
		void *sigs, double *out_time)

cdef extern from "SimilaritySearch.h":
	ctypedef cmap[uint64_t, vector] table
	ctypedef vector[table*] table_vec
	void InitializeDatabase(int ntimes, int nfp, uint8_t *vals,
        uint8_t ntbls, uint8_t nfuncs, table_vec *t, uint64_t *keys, double *out_time)
	void SearchDatabase_voting(int nquery, int nfp, uint32_t *query, uint8_t ntbls,
        uint32_t near_repeats, table_vec *t, uint64_t *keys,
        int nvotes, int limit, double *out_time)


cpdef load(filename, np.ndarray[bool, ndim=1, mode="c"] fingerprints,
	int fp_dim, int nfp):
	cdef Param p = Param(filename)

	cdef bool* fp_buff = &fingerprints[0]
	print fingerprints[:150]
	cdef int ntimes = p.searchParam.nfuncs * p.searchParam.ntbls
	cdef np.ndarray[uint8_t, ndim=1, mode="c"] min_hash_sigs = np.empty(ntimes * nfp, dtype=np.uint8)
	cdef uint8_t* sigs_buff = &min_hash_sigs[0]

	cdef double time
	MinHashMM_Block_32(fp_buff, nfp, fp_dim, ntimes, 1, sigs_buff, &time)
	print "MinHash signature took: " + str(time)

	cdef np.ndarray[uint64_t, ndim=1, mode="c"] keys = np.empty(nfp * p.searchParam.ntbls, dtype=np.uint64)
	cdef uint64_t* keys_buff = &keys[0]
	cdef table_vec t_vec
	for i in range(p.searchParam.ntbls):
		t_vec.push_back(new table())
	time = 0
	InitializeDatabase(ntimes, nfp, sigs_buff, p.searchParam.ntbls, 
		p.searchParam.nfuncs, &t_vec, keys_buff, &time)
	print "Hash table populate took: " + str(time)

	time = 0
	cdef np.ndarray[uint32_t, ndim=1, mode="c"] querys = np.arange(nfp, dtype=np.uint32)
	cdef uint32_t* query_buff = &querys[0]
	SearchDatabase_voting(nfp, nfp, query_buff, p.searchParam.ntbls,
        p.searchParam.near_repeats, &t_vec, keys_buff,
        p.searchParam.nvotes, p.searchParam.limit, &time)
	print "Similarity search took: " + str(time)



