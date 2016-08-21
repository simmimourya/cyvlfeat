# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# Copyright (C) 2013 Andrea Vedaldi.
# All rights reserved.
#
# This file is part of the VLFeat library and is made available under
# the terms of the BSD license (see the COPYING file).

cimport cython
from cyvlfeat._vl.generic cimport *
from cyvlfeat._vl.random cimport *


# # Period parameters
# cdef N
# cdef M
# cdef MATRIX_A VL_UINT32_C(0x9908b0df)  # constant vector a
# cdef UPPER_MASK VL_UINT32_C(0x80000000)  # most asignificant w-r bits
# cdef LOWER_MASK VL_UINT32_C(0x7fffffff)  # least significant r bits


# Initialise random number generator: initializes mt[N] with a seed
cpdef void rand_init(VlRand *self):
    return vl_rand_init(VlRand * self)


# Seed the state of the random number generator
cpdef void rand_seed(VlRand *self, vl_uint32 s):
    return vl_rand_seed(VlRand * self, s)
    # FIXME: return vl_rand_seed(VlRand * self, vl_uint32 s)


# Seed the state of the random number generator by an array
cpdef void rand_seed_by_array(VlRand *self, vl_uint32 key[], vl_size
keySize):
    # FIXME: return vl_rand_seed_by_array(VlRand *self, vl_uint32 key[], vl_size keySize)
    return vl_rand_seed_by_array(VlRand *self, key[:], keySize)


# Randomly permute and array of indexes
cpdef void rand_permute_indexes (VlRand *self, vl_index *array, vl_size size):
    return vl_rand_permute_indexes (VlRand *self, vl_index *array, size)


# Generate a random UINT32
cpdef vl_uint32 rand_uint32 (VlRand * self):
    return vl_rand_uint32 (VlRand * self)




