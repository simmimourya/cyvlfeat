# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.

# This file is modified from part of the VLFeat library and is made available
# under the terms of the BSD license.


from cyvlfeat._vl.host cimport vl_bool, vl_uindex, vl_index, vl_size, vl_type
from cyvlfeat._vl.random cimport *
from cyvlfeat._vl.mathop cimport VlVectorComparisonType


cdef extern from "vl/kdtree.h":
    cdef int VL_KDTREE_SPLIT_HEAP_SIZE "VL_KDTREE_SPLIT_HEAP_SIZE"
    cdef int VL_KDTREE_VARIANCE_EST_NUM_SAMPLES "VL_KDTREE_VARIANCE_EST_NUM_SAMPLES"

    ctypedef struct _VlKDTreeNode:
        vl_uindex parent
        vl_index lowerChild
        vl_index upperChild
        unsigned int splitDimension
        double splitThreshold
        double lowerBound
        double upperBound
    ctypedef _VlKDTreeNode VlKDTreeNode

    ctypedef struct _VlKDTreeSplitDimension:
        unsigned int dimension
        double mean
        double variance
    ctypedef _VlKDTreeSplitDimension VlKDTreeSplitDimension

    ctypedef struct _VlKDTreeDataIndexEntry:
        vl_index index
        double value
    ctypedef _VlKDTreeDataIndexEntry VlKDTreeDataIndexEntry

    # Thresholding method
    cdef enum _VlKDTreeThresholdingMethod:
        VL_KDTREE_MEDIAN,
        VL_KDTREE_MEAN
    ctypedef _VlKDTreeThresholdingMethod VlKDTreeThresholdingMethod

    # Neighbor of a query point
    ctypedef struct _VlKDForestNeighbor:
        double distance  # distance to the query point
        vl_uindex index  # index of the neighbor in the KDTree data
    ctypedef _VlKDForestNeighbor VlKDForestNeighbor

    ctypedef struct _VlKDTree:
        VlKDTreeNode *nodes
        vl_size numUsedNodes
        vl_size numAllocatedNodes
        VlKDTreeDataIndexEntry *dataIndex
        unsigned int depth
    ctypedef _VlKDTree VlKDTree

    ctypedef struct _VlKDForestSearchState:
        VlKDTree *tree
        vl_uindex nodeIndex
        double distanceLowerBound
    ctypedef _VlKDForestSearchState VlKDForestSearchState

    # FIXME: defined twice.
    ctypedef struct _VlKDForestSearcher

    # KDForest object
    ctypedef struct _VlKDForest:
        vl_size dimension

        # random number generator
        VlRand *rand

        # indexed data
        vl_type dataType
        void *data
        vl_size numData
        VlVectorComparisonType distance
        void (*distanceFunction)()

        # tree structure
        VlKDTree ** trees
        vl_size numTrees

        # build
        VlKDTreeThresholdingMethod thresholdingMethod
        #VlKDTreeSplitDimension splitHeapArray [VL_KDTREE_SPLIT_HEAP_SIZE]
        VlKDTreeSplitDimension splitHeapArray [5]
        vl_size splitHeapNumNodes
        vl_size splitHeapSize
        vl_size maxNumNodes

        # query
        vl_size searchMaxNumComparisons
        vl_size numSearchers
        # FIXME: struct definition was here.
        _VlKDForestSearcher *headSearcher  # head of the double linked list with searchers
    ctypedef _VlKDForest VlKDForest

    # VlKDForest searcher object
    ctypedef struct _VlKDForestSearcher:
        # maintain a linked list of searchers for later disposal
        # FIXME: struct definition was here.
        _VlKDForestSearcher *next
        # FIXME: struct definition was here.
        _VlKDForestSearcher *previous

        vl_uindex *searchIdBook
        VlKDForestSearchState *searchHeapArray
        VlKDForest *forest

        vl_size searchNumComparisons
        vl_size searchNumRecursions
        vl_size searchNumSimplifications

        vl_size searchHeapNumNodes
        vl_uindex searchId
    ctypedef _VlKDForestSearcher VlKDForestSearcher

    # Creating, copying and disposing
    VlKDForest *vl_kdforest_new(vl_type dataType,
                                vl_size dimension, vl_size numTrees, VlVectorComparisonType normType)
    VlKDForestSearcher *vl_kdforest_new_searcher(VlKDForest *kdforest)
    void vl_kdforest_delete(VlKDForest *self)
    void vl_kdforestsearcher_delete(VlKDForestSearcher *searcher)

    # Building and querying
    void vl_kdforest_build(VlKDForest *self,
                           vl_size numData,
                           void *data)

    vl_size vl_kdforest_query(VlKDForest *self,
                              VlKDForestNeighbor *neighbors,
                              vl_size numNeighbors,
                              void *query)

    vl_size vl_kdforest_query_with_array(VlKDForest *self,
                                         vl_uint32 *index,
                                         vl_size numNeighbors,
                                         vl_size numQueries,
                                         void *distance,
                                         void *queries)

    vl_size vl_kdforestsearcher_query(VlKDForestSearcher *self,
                                      VlKDForestNeighbor *neighbors,
                                      vl_size numNeighbors,
                                      void *query)

    # Retrieving and setting parameters
    vl_size vl_kdforest_get_depth_of_tree(VlKDForest *self, vl_uindex treeIndex)
    vl_size vl_kdforest_get_num_nodes_of_tree(VlKDForest *self, vl_uindex treeIndex)
    vl_size vl_kdforest_get_num_trees(VlKDForest *self)
    vl_size vl_kdforest_get_data_dimension(VlKDForest *self)
    vl_type vl_kdforest_get_data_type(VlKDForest *self)
    void vl_kdforest_set_max_num_comparisons(VlKDForest *self, vl_size n)
    vl_size vl_kdforest_get_max_num_comparisons(VlKDForest *self)
    void vl_kdforest_set_thresholding_method(VlKDForest *self, VlKDTreeThresholdingMethod method)
    VlKDTreeThresholdingMethod vl_kdforest_get_thresholding_method(VlKDForest *self)
    VlKDForest *vl_kdforest_searcher_get_forest(VlKDForestSearcher *self)
    VlKDForestSearcher *vl_kdforest_get_searcher(VlKDForest *self, vl_uindex pos)
