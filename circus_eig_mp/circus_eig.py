import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg
import mpmath
import time, os
mpmath.mp.dps = 1000


savepath = os.uname()[1] + "_python/"
if not os.path.exists(savepath):
    os.mkdir(savepath)
of = open(savepath + "mp%d-eig-time.dat" % mpmath.mp.dps, "w")


for dim in range(10, 110, 10):
    a = np.concatenate(( [1,-1], np.zeros(dim-2,dtype=int) ))
    b = np.concatenate(( np.arange(1,6), np.zeros(dim-5, dtype=int) ))
    m = mpmath.matrix(scipy.linalg.toeplitz(a, b))

    tic = time.time()
    evals0, evecs0 = mpmath.mp.eig(m)
    toc = time.time() - tic
    print(dim, toc)
    of.write("%d\t%f\n" % (dim, toc))
    of.flush()

of.close()



#print(a)
