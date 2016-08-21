# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.
#
# This file is part of the VLFeat library and is made available under
# the terms of the BSD license (see the COPYING file).

# remind tanya for CCD

from .host cimport vl_size, vl_bool, vl_int32, vl_uint32, vl_uint64, vl_int64, vl_uindex, vl_index

cdef extern from "vl/random.h":
    # brief Random number generator state
    ctypedef struct _VlRand:
      vl_uint32 mt [624]
      vl_uint32 mti
    ctypedef _VlRand VlRand

    # name Setting and reading the state
    void vl_rand_init (VlRand * self)
    void vl_rand_seed (VlRand * self, vl_uint32 s)
    void vl_rand_seed_by_array (VlRand * self,
                                      vl_uint32 key [],
                                      vl_size keySize)

    # name Generate random numbers
    inline vl_uint64 vl_rand_uint64 (VlRand * self)
    inline vl_int64  vl_rand_int63  (VlRand * self)
    vl_uint32 vl_rand_uint32 (VlRand * self)
    inline vl_int32  vl_rand_int31  (VlRand * self)
    inline double    vl_rand_real1  (VlRand * self)
    inline double    vl_rand_real2  (VlRand * self)
    inline double    vl_rand_real3  (VlRand * self)
    inline double    vl_rand_res53  (VlRand * self)

    inline vl_uindex vl_rand_uindex (VlRand * self, vl_uindex range)

    void vl_rand_permute_indexes (VlRand * self, vl_index* array, vl_size size)

    # Generate a random index in a given range
    inline vl_uindex vl_rand_uindex (VlRand * self, vl_uindex range)

    # Generate a random UINT64
    inline vl_uint64 vl_rand_uint64 (VlRand * self)

    # Generate a random INT63
    inline vl_int64 vl_rand_int63 (VlRand * self)

    # Generate a random INT31
    inline vl_int32 vl_rand_int31 (VlRand * self)

    # Generate a random number in [0,1]
    inline double vl_rand_real1 (VlRand * self)

    # Generate a random number in [0,1]
    inline double vl_rand_real2 (VlRand * self)

    # Generate a random number in [0,1]
    inline double vl_rand_real3 (VlRand * self)

    # Generate a random number in [0,1) with 53-bit resolution
    inline double vl_rand_res53 (VlRand * self)



















