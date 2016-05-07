from distutils.core import setup
from Cython.Build import cythonize

setup(
    name = "cython_product",
    ext_modules = cythonize('product.pyx', include_path=["/Users/christianmeyer/anaconda/include/python3.5m"])

)