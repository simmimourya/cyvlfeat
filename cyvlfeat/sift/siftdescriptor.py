import numpy as np
from .cysift import cy_siftdescriptor

cpdef cy_siftdescriptor(grad, f, magnification=3, float_descriptors=False, 
                    verbose=True, norm_threshold = 'Nan'):

def sift(image, n_octaves=None, n_levels=3,  first_octave=0,  peak_thresh=0,
         edge_thresh=10, norm_thresh=None,  magnification=3, window_size=2,
         frames=None, force_orientations=False, float_descriptors=False,
         compute_descriptor=False, verbose=False):

cpdef cy_sift(np.ndarray[float, ndim=2, mode='c'] data, int n_octaves,
              int n_levels, int first_octave, int peak_threshold,
              int edge_threshold, float norm_threshold, int magnification,
              int window_size, float[:, :] frames, bint force_orientations,
              bint float_descriptors, bint compute_descriptor, bint verbose):
