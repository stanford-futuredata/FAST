import numpy as NP
from matplotlib import pyplot as PLT
from matplotlib import cm as CM

LARGE_NUM = 10000
A = NP.ones((20, 20))
A = NP.triu(A)
A[13, 17] = LARGE_NUM
A[3, 7] = LARGE_NUM
A[6, 11] = LARGE_NUM
A[4, 16] = LARGE_NUM

mask =  NP.tri(A.shape[0], k=-1)
A = NP.ma.array(A, mask=mask) # mask out the lower triangle
fig = PLT.figure()
ax1 = fig.add_subplot(111)
#cmap=CM.flag # autocorr
cmap=CM.gray_r # FAST
cmap.set_bad('w') # default value is 'k'

PLT.rcParams.update({'font.size': 22})
# autocorr
#PLT.xlabel('Waveform time #1')
#PLT.ylabel('Waveform time #2')
# FAST
PLT.xlabel('Fingerprint time #1')
PLT.ylabel('Fingerprint time #2')

map = ax1.imshow(A, interpolation="nearest", cmap=cmap)
ax1.patch.set_alpha(0)
#fig.colorbar(map)

#PLT.savefig('matrix_cartoon_autocorr.eps')
PLT.savefig('matrix_cartoon_FAST.eps')
PLT.show()
