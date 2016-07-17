# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.
#
# This file is part of the VLFeat library and is made available under
# the terms of the BSD license (see the COPYING file).


import numpy as np
cimport numpy as np
cimport cython
import cython
from cyvlfeat._vl.host cimport *
from cyvlfeat._vl.mathop cimport *
from cyvlfeat._vl.lbp cimport *
from libc.stdio cimport printf

@cython.boundscheck(False)
cpdef cy_lbp(np.ndarray[float, ndim=2, mode='c'] image, int cell_size):
    cdef:
        vl_size width = image.shape[1]
        vl_size height = image.shape[0]
        # vl_size cell_size = cell_size
        vl_uint8 dimensions[3] 
        VlLbp *lbp = vl_lbp_new(VlLbpUniform, VL_TRUE)
    printf(lbp)

    dimensions[0] = height / cell_size
    dimensions[1] = width / cell_size
    dimensions[2] = vl_lbp_get_dimension(lbp)

    print(dimensions)

    cdef np.ndarray[float, ndim=3, mode='c'] features = np.empty(
        (dimensions[0], dimensions[1], dimensions[2]), dtype=np.float32, order='C')

    vl_lbp_process(lbp, &features[0, 0, 0], &image[0, 0], height, width, cell_size)

    return features