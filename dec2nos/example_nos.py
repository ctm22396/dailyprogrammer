import string

from functools import reduce
from itertools import count
from operator import add, mul, sub
from time import time

ops = (add, sub, mul)
digs = string.digits + string.ascii_lowercase


# adapted from http://stackoverflow.com/questions/2267362/convert-integer-to-a-string-in-a-given-numeric-base-in-python
def int2base(x, base):
  if x == 0:
    return digs[0]

  digits = []
  while x:
    digits.append(digs[x % base])
    x //= base

  return ''.join(reversed(digits))

from_nosbase = lambda s: reduce(lambda a, b: ops[int(s[b - 1])](a, b), range(len(s) + 1))
to_nosbase = lambda y: next(filter(lambda x: from_nosbase(x) == y, (int2base(z, 3) for z in count())))

start_time = time()
print("Generating shortest sequences for numbers 1 to 500:")
[print(str(num) + ': {}'.format(to_nosbase(num))) for num in range(1, 501)]
print("It only took {} seconds".format(time() - start_time))