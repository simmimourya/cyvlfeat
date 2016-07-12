from cyvlfeat.slic import slic
import numpy as np
from numpy.testing import assert_allclose
from cyvlfeat.test_util import lena


img = lena().astype(np.float32)

def test_slic_segment():
    segment = slic(img, region_size = 10, regularizer = 10):
    assert segment.shape[0] == 124241
