########################################################################################################
## pyFAST - Fingerprint and Similarity Thresholding in python
##
## Karianne Bergen
## 11/14/2016
##
## (see Yoon et. al. 2015, Sci. Adv. for algorithm details)
##
########################################################################################################
##
## Approximate Similarity Search with MinHash/LSH
##
########################################################################################################

import numpy as np
import mmh3
import time
import sys
from scipy.sparse import dok_matrix

sys.path.append('similarity_search')
from min_hash import mhs_to_keys, fingerprint_to_mhs


class MinHashLSH(object):
    
    def __init__(self, nfeats, nhashfun = 4, ntbls = 100, seed = 123456, nvotes = 1, near_repeats = 1, limit = 10000, storekeys = True):
        self.nhashfun  = nhashfun                       #/ number of hash functions per table
        self.ntbls     = ntbls                          #/ number of hash tables 
        self.ntimes    = ntbls*nhashfun                 #/ total number of hash functions required
        self.seed      = np.uint32(np.int32(seed))      #/ random seed for hash functions
        self.nvotes    = nvotes                         #/ sets detection threshold for LSH
        self.near_repeats = near_repeats                #/ avoids self-matches (lets user define bandwidth)
        self.limit     = limit                          #/ above this limit, stop search within hash bucket
        self.nfp       = 0                              #/ number of fingerprints in database
        self.nfeats    = nfeats                         #/ dimension of binary fingerprints
        self.maxval    =  2**32-1                       #/ largest integer value, int32
        self.maxidx    = 2**32-1                        #/ maximum time index (for initializing sparse matrix)
        self.mmh_funcs = self._initialize_hashfuncs()   #/ defines hash functions
        self.tables    = self._initialize_tables()      #/ stores hash tables
        self.store_keys = storekeys                     #/ if True, stores keys associated with each index
        self.index_to_keys = {} 
        
    def _initialize_tables(self):    #/ initializes data structure 
        tbls = [] # list of dicts
        for _ in range(self.ntbls):
            tbls.append({})
        return tbls                    
        
    def _initialize_hashfuncs(self):  #/ generates random numbers for minhash
        #mmhfuncs = np.mod([mmh3.hash(np.array([i]),self.seed + j) for i in range(self.nfeats) for j in range(self.ntimes)], self.maxval).astype('uint32')
        mmhfuncs = np.zeros(self.nfeats*self.ntimes, dtype=np.uint32)
        tmp = np.zeros(1)
        for i in range(self.nfeats):
            for j in range(self.ntimes):
                tmp[0] = i
                mmhfuncs[j + i*self.ntimes ] = mmh3.hash(tmp, self.seed + j)
        # data ordering: blocks with constant value of i (feature#)
        return mmhfuncs                         

    def _clear_hashfunc(self):  #/ clears random numbers for minhash
        self.mmh_funcs = None                                        
                                                                
    def insert_data(self, fp, time_idx):   #/ insert one or more fingerprints into hash table - does not store keys
        nrow, nfeat = np.shape(fp)     #/ one fingerprint per row
        if nfeat != self.nfeats:
            print "ERROR: dimension mismatch - can not add to database"
            return
        for i in range(nrow): #/ adds one at a time
            mhs = fingerprint_to_mhs(fp[i,:], self.mmh_funcs, nfeat, self.ntimes)
            keys = mhs_to_keys(mhs, self.nhashfun, self.ntbls)  #/ ~1 second for  10k data points vs.
            for j in range(self.ntbls):
                self.tables[j].setdefault(keys[j],[])     
                self.tables[j][keys[j]].append(time_idx[i])
            if self.store_keys:
                self.index_to_keys[time_idx[i]] = keys
                
    def set_nvotes(self,nvotes):
        self.nvotes = nvotes
    
    def search_database_internal(self, time_idx):
        nqueries = len(time_idx) 
        detdata = dok_matrix((self.maxidx,self.maxidx),dtype = np.uint8)
        for i in range(nqueries):
            keys = self.index_to_keys[time_idx[i]]
            pair_idx1, pair_idx2, pair_sim, _, _, _, _ = self.query_by_keys(keys, time_idx[i])
            detdata[pair_idx1,pair_idx2] = pair_sim
        return detdata                                           
           
    def query_by_keys(self, keys, time_idx, nonsymmetric=True): #/ 
        #/ TODO: implement 'nonsymmetric' - if False will return both halves of symmetric similarity values (i.e. both [i,j, Sij] and [j,i, Sij])
        pair_idx1 = []
        pair_idx2 = []
        pair_sim  = []
        t_getvals = None
        t_prunevals = None
        t_countvals = None
        #count_map = collections.defaultdict(int)
        count_map = {} #/ count co-occurances of indices
        for j in range(self.ntbls):
            if keys[j] in self.tables[j]: #/ checks to make sure the key exists in hashtable (for external search)
                vals = self.tables[j][keys[j]] #/ extracts list of indices in same hash bucket
                nvals = len(vals)       
                if nvals > self.limit:  #/ enforces size-limit on buckets (for extreme cases)
                    nvals = self.limit
                for k in range(nvals):
                    m = vals[k]
                    if m in count_map:
                        count_map[m] += 1
                    else:                            
                        count_map[m] = 1                               
        for idx, sim in count_map.iteritems():
            if sim >= self.nvotes:
                if idx < time_idx-self.near_repeats or idx > time_idx+self.near_repeats:          
                    if idx >= time_idx:
                        pair_idx1.append(time_idx)
                        pair_idx2.append(idx)
                        pair_sim.append(sim)
                    else:
                        pair_idx1.append(idx)
                        pair_idx2.append(time_idx)
                        pair_sim.append(sim) 
        t_add = None
        return pair_idx1, pair_idx2, pair_sim, t_getvals, t_prunevals, t_countvals, t_add

    def search_database_external(self,fp, time_idx):  
        self.store_keys = False
        detdata = dok_matrix((self.maxidx,self.maxidx),dtype = np.uint8)   
        nqueries, nfeat = np.shape(fp)     #/ one fingerprint per row
        if nfeat != self.nfeats:
            print "ERROR: dimension mismatch - can not search database"
            return
        for i in range(nqueries): #/ adds one at a time
            mhs = fingerprint_to_mhs(fp[i,:], self.mmh_funcs, nfeat, self.ntimes)
            keys = mhs_to_keys(mhs, self.nhashfun, self.ntbls)  #/ ~1 second for  10k data points vs.                   
            pair_idx1, pair_idx2, pair_sim, t_getvals0, t_prunevals0, t_countvals0, t_add0 = self.query_by_keys(keys, time_idx[i])
            detdata[pair_idx1,pair_idx2] = pair_sim        
        return detdata  
        
    def search_database(self, fp, time_idx): #/ uses pre-computed keys for data already in database
        db_idx  = self.index_to_keys.keys()
        ext_idx = list(set(time_idx) - set(db_idx))
        detdata = self.search_database_internal(db_idx)
        detdata += self.search_database_external(fp[ext_idx,:], ext_idx)
        return detdata
                                        
    def query_by_data(self,fp,time_idx):
        return                           
                                        
    def _compute_mhs(self, fp, nrow):
        nrow, nfeat = np.shape(fp)
        min_hash_sigs = np.zeros((nrow,self.ntimes), dtype=np.uint8)  
        for i in range(nrow):
            min_hash_sigs[i,:] = self._compute_mhs_single(fp[i,:])      
        return min_hash_sigs           
        
    def _compute_mhs_single(self, fp):
        indices = np.array([i for i in range(self.nfeats) if fp[i]])    # 0.0004s per execution
        mhs  = np.zeros(self.ntimes,dtype=np.uint8)       
        for j in range(self.ntimes):  #/ 0.005s for all tables
            mhs[j] = np.mod(np.min(self.mmh_funcs[indices + j*self.nfeats]), 256).astype(np.uint8)
        return mhs   
        
    def _toint64(self,mhs): #/ converts mhs to keys
        keys = np.zeros(self.ntbls,dtype=np.uint64)
        for i in range(self.ntbls):
            submhs = mhs[(i*self.nhashfun):((i+1)*self.nhashfun)]
            keys[i] = np.sum([(submhs[p] << p*self.bitshift) for p in range(self.nhashfun)])       
        return keys
                                            
    def _insert_mhs_single(self, mhs, tidx):
        return  
    
    def clear_tables(self):
        self.tables = None
        self.tables = self._initialize_tables()
    
    def get_coeffs(self):
        return self.coeffsA, self.coeffsB                                        

    def set_near_repeats(self, near_repeats):
        self.near_repeats = near_repeats          
                        
    def set_nvotes(self, nvotes):
        self.nvotes = nvotes    
        
    def set_limit(self, limit):
        self.limit = limit         
        
    def get_parameters(self):
        params = dict()
        params ['nhashfun'] = self.nhashfun  
        params ['ntimes'] = self.ntimes
        params ['ntbls'] = self.ntbls
        params ['seed'] = self.seed
        params ['nfp'] = self.nfp
        params ['nfeats'] = self.nfeats
        params ['nvotes'] = self.nvotes
        params ['limit'] = self.limit
        params ['maxval'] = self.maxval
        params ['near_repeats'] = self.near_repeats
        params ['bitshift'] = self.bitshift
        return params          
        
    def __del__(self):
        print "deleting", self  