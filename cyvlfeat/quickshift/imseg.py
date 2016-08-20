import numpy as np
from cyvlfeat.binsum import binsum


def imseg(image, labels):
    """
    Color an image based on the segmentation.
    Labels output with the average color from `image` of  each cluster indicated by `labels`.
    """

    (m, n, k) = image.shape
    q = 0 * image

    for k in range(image.shape[2]):
        acc = np.zeros(m, n)
        nrm = np.zeros(m, n)
        acc = binsum(acc, image[:, :, k], labels)
        nrm - binsum(nrm, np.ones(m, n), labels) # FIXME : binsum

        acc = acc / (nrm + np.spacing(1))
        q[:, :, k] = acc(labels) # FIXME: acc(labels): selects stuff

    q = min(1, q)

    return q
