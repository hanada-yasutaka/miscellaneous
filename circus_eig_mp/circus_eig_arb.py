import numpy as np
import flint
import scipy.linalg
import time, os

flint.ctx.dps = 1000
#flint.ctx.threads = 8

savepath = os.uname()[1] + "_python_arb/"
if not os.path.exists(savepath):
    os.mkdir(savepath)
of = open(savepath + "mp%d-eig-time.dat" % flint.ctx.dps, "w")


dims = np.append(np.arange(10, 100, 10), np.arange(100, 600, 100))
for dim in dims:
    a = np.concatenate(( [1,-1], np.zeros(dim-2,dtype=int) ))
    b = np.concatenate(( np.arange(1,6), np.zeros(dim-5, dtype=int) ))
    m1 = scipy.linalg.toeplitz(a, b)

    CM1 = flint.arb_mat(m1.tolist())

    tic = time.time()
    [evals1, evecs1] = CM1.eig(left=True, nonstop=True)
    toc = time.time() - tic

    print(dim, toc)
    of.write("%d\t%f\n" % (dim, toc))
    of.flush()

of.close()
