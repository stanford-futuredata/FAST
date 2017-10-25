import numpy as np
cimport numpy as cnp
from libcpp cimport bool
from libc.stdint cimport uint8_t, uint32_t, uint64_t, uint16_t

def say_hello_to(name):
    print("Hello %s!" % name)
    
cdef extern from "toint64.h":    
    uint64_t toint64_16(const uint8_t*, uint8_t) 
    
cpdef toint64_16py( cnp.ndarray[dtype=cnp.uint8_t, ndim=1, mode="c"] min_hash_sigs,  int nhashfuncs):
    outvals = toint64_16(<uint8_t*> min_hash_sigs.data, nhashfuncs)  
    return outvals
 
cpdef mhs_to_keys( cnp.ndarray[dtype=cnp.uint8_t, ndim=1, mode="c"] mhs,  int nhashfuncs, int ntbls):  
    cdef int mhs_len, i
    mhs_len = mhs.shape[0]
    result = np.zeros(ntbls, dtype=np.uint64)
    for i in range(ntbls):
        result[i] = toint64_16py(mhs[(i*nhashfuncs):((i+1)*nhashfuncs)],nhashfuncs)
    return result

cpdef fingerprint_to_mhs( cnp.ndarray[dtype=cnp.uint8_t, ndim=1, mode="c", cast=True]  fp, cnp.ndarray[dtype=cnp.uint32_t, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
    cdef int i, j, k, jminval
    cdef int MAXVAL = 2**32-1
    cdef int nnzidx = 0 
    cdef cnp.ndarray[dtype=cnp.uint16_t, ndim=1] nz_indices = np.zeros(nfeats,dtype=np.uint16)
    cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=1] mhs = np.zeros(ntimes,dtype=np.uint8)      
    #/ gets list of indices of non-zeros
    for i in range(nfeats): 
        if fp[i]:
            nz_indices[nnzidx] = i
            nnzidx += 1         
    #/ gets list of indices of non-zeros
    for j in range(ntimes):
        jminval = MAXVAL
        for k in range(nnzidx):
            if mmh_funcs[nz_indices[k] + j*nfeats]  < jminval:
                jminval = mmh_funcs[nz_indices[k] + j*nfeats]  
        mhs[j] = jminval
    return mhs    

def fingerprints_to_mhs( cnp.ndarray[dtype=cnp.uint8_t, ndim=2, mode="c", cast=True]fp, cnp.ndarray[dtype=cnp.uint32_t, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
    cdef int nfp, i
    nfp = fp.shape[0]
    #cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=1] thisfp = np.zeros(nfeats,dtype=np.uint8) 
    cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=2] mhs = np.zeros((nfp,ntimes),dtype=np.uint8) 
    for i in range(nfp):
        #thisfp = fp[i,:]      
        mhs[i,:] = fingerprint_to_mhs( fp[i,:] , mmh_funcs, nfeats, ntimes)
    return mhs  

#/ this works but is slow!!!
#def fingerprint_to_mhs( cnp.ndarray[dtype=cnp.uint8_t, ndim=1, mode="c", cast=True]  fp, cnp.ndarray[dtype=cnp.uint32_t, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
#    cdef int i, j
#    #cdef cnp.ndarray[dtype=cnp.uint16_t, ndim=1] nz_indices = np.array([i for i in range(nfeats) if fp[i]],dtype=np.uint16)
#    cdef cnp.ndarray[dtype=cnp.uint16_t, ndim=1] nz_indices = np.array(np.where(fp),dtype=np.uint16).ravel()
#    cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=1] mhs = np.zeros(ntimes,dtype=np.uint8)        
#    for j in range(ntimes):        
#        mhs[j] = np.mod(np.min(mmh_funcs[nz_indices + j*nfeats]), 256).astype(np.uint8)
#    return mhs    

#/ this works but is slow!!!
#def fingerprints_to_mhs( cnp.ndarray[dtype=cnp.uint8_t, ndim=2, mode="c", cast=True]fp, cnp.ndarray[dtype=cnp.uint32_t, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
#    cdef int nfp, i, j
#    nfp = fp.shape[0]
#    cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=2] mhs = np.zeros((nfp,ntimes),dtype=np.uint8) 
#    for i in range(nfp):
#        nz_indices = np.array(np.where(fp[i,:]),dtype=np.uint16).ravel()          
#        for j in range(ntimes):
#            mhs[i,j] = np.mod(np.min(mmh_funcs[nz_indices + j*nfeats]), 256).astype(np.uint8)
#    return mhs  

#def fingerprint_to_mhs( cnp.ndarray[dtype=cnp.uint8_t, ndim=1, mode="c", cast=True]  fp, cnp.ndarray[dtype=cnp.uint32_t, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
#    cdef int fp_len, j
#    cdef cnp.ndarray[dtype=cnp.uint16_t, ndim=1] nz_indices 
#    cdef cnp.ndarray[dtype=cnp.uint8_t, ndim=1] mhs = np.zeros(ntimes,dtype=np.uint8)  
#    fp_len = fp.shape[0]         
#    nz_indices = np.array(np.where(fp),dtype=np.uint16).ravel()
#    for j in range(ntimes):
#        mhs[j] = np.mod(np.min(mmh_funcs[nz_indices + j*nfeats]),256)
#    return mhs

#def fingerprints_to_mhs( cnp.ndarray[dtype=bool, ndim=2, mode="c"]  fp, cnp.ndarray[dtype=cnp.uint32, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
#        cdef int nfp, fp_len, mmhf_len, i, j, p
#        cdef cnp.ndarray[dtype=cnp.int16, ndim=1] indices
#        nfp = fp.shape[0]
#        fp_len = fp.shape[1]    
#        mmhf_len =  mmh_funcs #/ TODO: this should be equal to nfeats*ntimes  
#        cdef cnp.ndarray[dtype=cnp.uint8, ndim=2] mhs = cnp.zeros((nfp,ntimes),dtype=np.uint8)        
#        for i in range(nfp):
#            indices =  cnp.array(cnp.where(fp[i,:]),dtype=int16).ravel()
        
#    def _compute_mhs_single(self, fp):
#        indices = np.array([i for i in range(self.nfeats) if fp[i]])    # 0.0004s per execution
#        mhs  = np.zeros(self.ntimes,dtype=np.uint8)       
#        for j in range(self.ntimes):  #/ 0.005s for all tables
#            mhs[j] = np.mod(np.min(self.mmh_funcs[indices + j*self.nfeats]), 256).astype(np.uint8)        

#def fingerprints_to_mhs( cnp.ndarray[dtype=cnp.int16, ndim=2, mode="c"]  fp_nzidx, cnp.ndarray[dtype=cnp.uint32, ndim=1, mode="c"]  mmh_funcs, int nfeats, int ntimes):
#        cdef int fp_len, mmhf_len, i, j
#        fp_len = fp_nzidx.shape[0]    
#        mmhf_len =  mmh_funcs    
          
      #cnp.ndarray[dtype=cnp.uint8_t, ndim=2, mode="c"]  
    
 #/ To build, run python setup_minhash.py build_ext --inplace
 #/ Then simply start a Python session and do from min_hash import say_hello_to and use the imported function as you see fit.