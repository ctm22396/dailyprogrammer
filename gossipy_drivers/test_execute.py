import pyximport; pyximport.install()
from test import foo

foo([b'hello', b'python', b'world'], [b'python', b'rules'])