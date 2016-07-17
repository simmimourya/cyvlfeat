import numpy as np
from cyvlfeat.misc.cylbp import cy_lbp
from cyvlfeat.test_util import lena

img = lena().astype(np.float32)


def lbp(image, cell_size):

    # check for none
    if image is None or cell_size is None:
        raise ValueError('One of the required arguments is None')

    # Remove last channel
    if image.ndim == 3 and image.shape[-1] == 1:
        image = image[..., 0]

    # Validate image size
    if image.ndim != 2:
        raise ValueError('Only 2D arrays are supported')

    if cell_size < 1:
        raise ValueError('cell_size is less than 1')

    # Ensure types are correct before passing to Cython
    image = np.require(image, dtype=np.float32, requirements='C')

    result = cy_lbp(image, cell_size)

    return result

if __name__ == '__main__':
    ye = cy_lbp(img, cell_size= 200)
    print(ye)
    print(ye.shape[0])
    print(ye.shape[1])
    print(ye.shape[2])
