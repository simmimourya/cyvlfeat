# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.

# This file is modified from part of the VLFeat library and is made available
# under the terms of the BSD license.
from cyvlfeat._vl.host cimport vl_bool, vl_uindex, vl_index, vl_size
from cyvlfeat._vl.mathop cimport VlRand



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
        VlKDTreeThresholdingMethod

    # Neighbor of a query point
    ctypedef struct _VlKDForestNeighbor:
      double distance  # distance to the query point
      vl_uindex index  # index of the neighbor in the KDTree data
    ctypedef _VlKDForestNeighbor VlKDForestNeighbor

    ctypedef struct _VlKDTree:
      VlKDTreeNode * nodes 
      vl_size numUsedNodes 
      vl_size numAllocatedNodes 
      VlKDTreeDataIndexEntry * dataIndex 
      unsigned int depth 
    ctypedef _VlKDTree VlKDTree

    ctypedef struct _VlKDForestSearchState:
      VlKDTree * tree 
      vl_uindex nodeIndex 
      double distanceLowerBound 
    ctypedef _VlKDForestSearchState VlKDForestSearchState

    ctypedef struct _VlKDForestSearcher

    # KDForest object
    ctypedef struct _VlKDForest:
      vl_size dimension 

      # random number generator
      VlRand * rand 

      # indexed data  
      vl_type dataType 
      void const * data 
      vl_size numData 
      VlVectorComparisonType distance;
      void (*distanceFunction)(void) 

      # tree structure  
      VlKDTree ** trees 
      vl_size numTrees 

      # build  
      VlKDTreeThresholdingMethod thresholdingMethod 
      VlKDTreeSplitDimension splitHeapArray [VL_KDTREE_SPLIT_HEAP_SIZE] 
      vl_size splitHeapNumNodes 
      vl_size splitHeapSize 
      vl_size maxNumNodes;

      # query  
      vl_size searchMaxNumComparisons 
      vl_size numSearchers;
      struct _VlKDForestSearcher * headSearcher   # head of the double linked list with searchers  

    ctypedef _VlKDForest VlKDForest 

    
    




