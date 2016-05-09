from permutations_prob import ex_calc_index, ex_gen_seq
from numpy import array
from timeit import timeit


i1 = ['5 4 3 2 1 0',
      '2 1 0 0',
      '5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0',
      '8 8 8 8 8 8 8 8 8 7 7 7 6 5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0 6 7 8']

reps = 10000

for i in i1:
    dur = timeit("from permutations_prob import ex_calc_index; "
                 + "from numpy import array; "
                 + "ex_calc_index(array('{}'.split(' ')).astype(int))".format(i), number=reps - 1)
    print(i)
    print(ex_calc_index(array(i.split(' ')).astype(int)))
    print("{} loops, {} secs per loop.".format(reps, dur/reps))
    print()

i2 = ['719, 0 1 2 3 4 5',
      '11, 0 0 1 2',
      '10577286119, 0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5',
      '3269605362042919527837624, 0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5 6 6 7 7 7 7 8 8 8 8 8 8 8 8 8 8']

for i in i2:
    i = i.split(', ')
    dur = timeit("from permutations_prob import ex_gen_seq; "
                 + "from numpy import array; "
                 + "ex_gen_seq(int({0}[0]), array({0}[1].split(' ')).astype(int))".format(i), number=reps - 1)
    print(i)
    print(ex_gen_seq(int(i[0]), array(i[1].split(' ')).astype(int)))
    print("{} loops, {} secs per loop.".format(reps, dur / reps))
    print()


i = 'hello, heely owler world!'
i = ' '.join([str(ord(j)) for j in list(i)])
dur = timeit("from permutations_prob import ex_calc_index; "
             + "from numpy import array; "
             + "ex_calc_index(array('{}'.split(' ')).astype(int))".format(i), number=reps - 1)
print(i)
print(ex_calc_index(array(i.split(' ')).astype(int)))
print("{} loops, {} secs per loop.".format(reps, dur / reps))
print()



