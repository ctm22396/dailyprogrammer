import pyximport; pyximport.install()
from product import product_ex
from itertools import product

print(product_ex('012'.encode(), 16))