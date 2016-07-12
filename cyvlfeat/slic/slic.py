import numpy as np
from .cyslic import cy_slic


def slic(image, region_size, regularizer, verbose=False):
    r"""
    Extracts the SLIC superpixels from the image.

    Parameters
    ----------
    image : [H, W, 1] `float32` `ndarray`
        A `float32` numpy array (ndarray)
        representing the image to calculate superpixels for.
    region_size : `int`
        Starting size of the superpixels
    regularizer : `float`
        The trades-off appearance for spatial regularity
        when clustering (a larger value results in more
        spatial regularization)
    verbose: `bool`, optional
        If ``True``, be verbose.

    Returns
    -------
    segments: `float32` `ndarray`
        contains the superpixel identifier for each image pixel.
    """

    # Check for none
    if image is None or region_size is None or regularizer is None:
        raise ValueError('A required input is None')

    if image.ndim != 3:
        raise ValueError('Image should be a 3D array')
    image = np.require(image, dtype=np.float32, requirements='C')

    if region_size < 1:
        raise ValueError('region_size cannot be less than 1')

    # confirm this from Patrick. Less than 0 now. Not accidently changed
    # from less than 1 to less than 0
    if regularizer < 0:
        raise ValueError('regularizer cannot be less than 0')

    result = cy_slic(image, region_size, regularizer, verbose)

    return result



