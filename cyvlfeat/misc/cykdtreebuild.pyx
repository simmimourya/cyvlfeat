# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.
#
# This file is part of the VLFeat library and is made available under
# the terms of the BSD license (see the COPYING file).

cimport cython
import cython
cimport numpy as np
import numpy as np
from cyvlfeat._vl.kdtree cimport *
from cyvlfeat.misc.kdtree cimport *
from cyvlfeat._vl.host cimport vl_get_type_name, vl_uindex, VL_TYPE_FLOAT
from cyvlfeat.cy_util cimport py_printf, set_python_vl_printf

@cython.boundscheck(False)
cpdef cy_kdtreebuild(np.ndarray[float, ndim=2, mode='c'] data, int num_trees,
                     VlKDTreeThresholdingMethod thresholding_method,
                     VlVectorComparisonType distance, bint verbose):
        # Set the vlfeat printing function to the Python stdout
        set_python_vl_printf()

        cdef:
            VlKDForest *forest
            # void * data
            vl_size num_data = data.shape[1]
            vl_size dimension = data.shape[0]
            # str thresholding_method = "VL_KDTREE_MEDIAN"
            # FIXME: String declaration using cstringio
            # VlVectorComparisonType distance = "VlDistanceL2"
            # vl_size num_trees = 1
            char * strs # FIXME: char * strs = 0
            vl_uindex ti

            #TODO: accept both SINGLE and DOUBLE data.


        forest = vl_kdforest_new(VL_TYPE_FLOAT, dimension, num_trees, distance)
        vl_kdforest_set_thresholding_method(forest, thresholding_method)

        if vl_kdforest_get_thresholding_method(forest) == "VL_KDTREE_MEDIAN":
            strs = "median"
        elif vl_kdforest_get_thresholding_method(forest) == "VL_KDTREE_MEAN":
            strs = "mean"

        if verbose:
            py_printf("vl_kdforestbuild: data %s [%d x %d]\n",
                   vl_get_type_name(VL_TYPE_FLOAT), dimension, num_data)
            py_printf("vl_kdforestbuild: threshold selection method: %s\n", strs)
            py_printf("vl_kdforestbuild: number of trees: %d\n",
                   vl_kdforest_get_num_trees(forest))

        vl_kdforest_build(forest, num_data, &data[0,0])

        if verbose:
            for ti in range(vl_kdforest_get_num_trees(forest)):
                py_printf("vl_kdforestbuild: tree %d: depth %d, num nodes %d\n",
                       ti,
                       vl_kdforest_get_depth_of_tree(forest, ti),
                       vl_kdforest_get_num_nodes_of_tree(forest, ti))

        out = new_array_from_kdforest(forest)
        vl_kdforest_delete(forest)

        outs = np.array(<double> out)
        return outs

