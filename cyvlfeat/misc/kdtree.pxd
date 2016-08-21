# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.

# This file is modified from part of the VLFeat library and is made available
# under the terms of the BSD license.


from cyvlfeat._vl.kdtree cimport *


cdef extern from "_vl/kdtree.h":
    cdef:
        void restore_parent_recursively(VlKDTree *tree, int nodeIndex, int *numNodesToVisit)
        # mxArray * new_array_from_kdforest (VlKDForest * forest)
        float[:, :] new_array_from_kdforest (VlKDForest * forest)
        # VlKDForest * new_kdforest_from_array (mxArray * forest_array, mxArray * data_array)
        VlKDForest * new_kdforest_from_array (float[: , :] forest_array, float[: ,:] data_array)
