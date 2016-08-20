import numpy as np
from cyvlfeat.quickshift import quickshift
from cyvlfeat.quickshift import flatmap
from cyvlfeat.quickshift import imseg


def quickseg(image, ratio, kernel_size, max_dist):
    """
    Produce a quickshift segmentation of a greyscale image.

    Parameters
    ----------
    image : [H, W] or [H, W, 1] `float64` `ndarray`
        Input image, Greyscale.  A single channel, greyscale,
        `float64` numpy array (ndarray).
    ratio : `double`
        Trade-off between spatial consistency and color consistency.
        Small ratio gives more importance to the spatial component.
        Note that distance calculations happen in unnormalized image
        coordinates, so RATIO should be adjusted to compensate for
        larger images.
    kernel_size : `double`
        The standard deviation of the parzen window density estimator.
    max_dist : `double`
        The maximum distance between nodes in the quickshift tree. Used
        to cut links in the tree to form the segmentation.

    Returns
    -------
    i_seg :
        A color image where each pixel is labeled by the mean color in its
        region.
    labels : [H, W] `float64` `ndarray`.
        Array of the same size of image.
        A labeled image where the number corresponds to the cluster identity.
    maps : [H, W] `float64` `ndarray`.
        Array of the same size of image.
        `maps` as returned by `quickshift`: For each pixel, the pointer to the
        nearest pixel which increases the estimate of the density.
    gaps : [H, W] `float64` `ndarray`.
        Array of the same size of image.
        `gaps` as returned by `quickshift`: For each pixel, the distance to
        the nearest pixel which increases the estimate of the density.
    estimate : [H, W] `float64` `ndarray`.
        Array of the same size of image.
        `estimate` as returned by `quickshift`: The estimate of the density.
    """

    # validate image
    if image.dtype != np.float64:
        raise ValueError('Image array must be of Double precision')
    # image = np.asarray(image, dtype=np.float64)

    # Add less than one pixel noise to break ties caused by
    # constant regions in an arbitrary fashions
    noise = np.random.random(image.shape) / 2250
    image += noise

    # For now we're dealing with Greyscale images only.
    if image.shape[2] == 1:
        imagex = ratio * image

    # Perform quickshift to obtain the segmentation tree, which is already cut by
    # maxdist. If a pixel has no nearest neighbor which increases the density, its
    # parent in the tree is itself, and gaps is inf.

    (maps, gaps, estimate) = quickshift(image, kernel_size, max_dist)

    # Follow the parents of the tree until we have reached the root nodes
    # mapped: a labeled segmentation where the labels are the indices of the modes
    # in the original image.
    # labels: mapped after having been renumbered 1: nclusters and reshaped into a
    # vector

    (mapped, labels) = flatmap(maps)
    labels = np.resize(labels, maps.shape)

    # imseg builds an average description of the region by color

    i_seg = imseg(image, labels)

    return i_seg, labels, maps, gaps, estimate
