
import numpy as np

def gaussian(a, sigma=0.7):
    return np.random.normal(0,sigma,a.shape) + a

