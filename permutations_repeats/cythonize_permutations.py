from distutils.core import setup
from Cython.Build import cythonize
from numpy import get_include


setup(
    name = "Permutations with Repeat",
    ext_modules = cythonize("permutations_prob.pyx"),
    include_dirs=get_include(),
    reload_support=True
)