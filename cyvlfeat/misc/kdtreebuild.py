# Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
# All rights reserved.
#
# This file is part of the VLFeat library and is made available under
# the terms of the BSD license (see the COPYING file).


import numpy as np
from cyvlfeat.misc.cykdtreebuild import cy_kdtreebuild
from cyvlfeat.test_util import lena

img = lena().astype(np.float32)


def kdtreebuild(image, num_trees=None, thresholding_method=None, distance=None, verbose=False):
    # if image is None or num_trees is None or distance is None:
    #     raise ValueError('One of the required arguments is None.')

    if image is None:
        raise ValueError('Image is None')

    if image.ndim == 3 and image.shape[-1] == 1:
        image = image[..., 0]

    # Validate image size
    if image.ndim != 2:
        raise ValueError('Only 2D arrays are supported')

    if thresholding_method is None:
        thresholding_method = "VL_KDTREE_MEDIAN"

    if thresholding_method is not None:
        if thresholding_method.lower() == 'median':
            thresholding_method = 'VL_KDTREE_MEDIAN'
        elif thresholding_method.lower() == 'mean':
            thresholding_method = 'VL_KDTREE_MEAN'
        else:
            raise ValueError('Unknown thresholding method.')

    if num_trees is None:
        num_trees = 1

    if num_trees is not None:
        if num_trees < 1:
            raise ValueError('num_tress must be greater than one')

    if distance is None:
        distance = "VlDistanceL2"

    if distance is not None:
        if distance.lower() == 'l2':
            distance = 'VlDistanceL2'
        elif distance.lower() == 'l1':
            distance = 'VlDistanceL1'
        else:
            raise ValueError('Invalid value for distance')

    # Ensure types are correct before passing to Cython
    image = np.require(image, dtype=np.float32, requirements='C')

    return cy_kdtreebuild(image, num_trees, thresholding_method, distance, verbose)


if __name__ == '__main__':
    result = kdtreebuild(img, 2, 'mean', 'l2', True)
