from libc.stdlib cimport realloc, malloc, free
from libc.stdio cimport printf
from libc.string cimport memcpy
from time import time


cdef char ** product(char *base, int base_length, int repeat):
    cdef char ** return_list = <char **>malloc(0)
    cdef char ** old_return_list = <char **>malloc(0)
    cdef long i = 0
    cdef long j = 0
    cdef long k = 0
    cdef long l = 0

    i = 0
    for i in range(repeat):
        j = 0
        return_list = <char **>malloc(base_length**(i + 1) * sizeof(char *))
        if i == repeat - 1:
            for j in range(base_length**(i + 1)):
                return_list[j] = <char *>malloc((i + 2) * sizeof(char))
        else:
            for j in range(base_length**(i + 1)):
                return_list[j] = <char *>malloc((i + 1) * sizeof(char))
        j = 0
        for j in range(base_length**i):
            k = 0
            for k in range(base_length):
                l = 0
                for l in range(i + 1):
                    if l == i:
                        return_list[k + j * base_length][l] = base[k]
                    else:
                        return_list[k + j * base_length][l] = old_return_list[j][l]
                if i == repeat - 1:
                    return_list[k + j * base_length][l+1] = b'\0'

        free(old_return_list)
        if i < repeat - 1:
            j = 0
            old_return_list = <char **>malloc(base_length**(i + 1) * sizeof(char *))
            for j in range(base_length**(i + 1)):
                old_return_list[j] = <char *>malloc((i + 1) * sizeof(char))
                old_return_list[j] = return_list[j]
            if i < repeat - 1:
                free(return_list)

    return return_list

cdef char * len_base_max0(char ** sequence, int length, int str_length):
    cdef int i = 0
    cdef int j = 0
    cdef int * counts = <int *>malloc(length * sizeof(int))

    for i in range(length):
        counts[i] = 0

    i = 0
    for i in range(length):
        j = 0
        for j in range(str_length):
            if sequence[i][j] == b'0':
                counts[i] = counts[i] + 1

    cdef int maks = 0
    i = 0
    j = 0
    for i in range(length):
        if counts[i] > maks:
            maks = counts[i]
            j = i

    return sequence[j]

cdef int calculate(char * seq, int length):
    cdef int val = 0
    cdef int i = 0
    for i in range(length):
        if seq[i] == b'0':
            val = val + (i+1)
        elif seq[i] == b'1':
            val = val - (i+1)
        elif seq[i] == b'2':
            val = val*(i+1)

    return val

cdef char * gen_guesses(int lower, long number):
    cdef char ** guesses = product(b'012', 3, lower)
    cdef int i = 0
    cdef int length = 0
    cdef int g_length = 3 ** lower
    cdef char ** enders = <char **>malloc(100*sizeof(char *))
    cdef int found = 0
    cdef char * g

    for i in range(g_length):
        g = guesses[i]
        op_result = calculate(g, lower)
        if op_result == number:
            found = 1
            enders[length] = g
            length = length + 1
    if found:
        return len_base_max0(enders, length, lower)


cdef char * generate_sequence(long number):
    if number == 0:
        return b'2'
    elif number == 1:
        return b'0'
    elif number == 2:
        return b'02'
    cdef int lower = 1
    cdef int val = 1
    cdef char * guess
    while True:
        guess = gen_guesses(lower, number)
        if guess:
            return guess
        free(guess)
        lower = lower + 1

start_time = time()
print("Generating shortest sequences for numbers 1 to 500:")
cdef int num = 0
for num in range(1,1001):
    printf('%d: %s\n', num, generate_sequence(num))
print("It only took {} seconds".format(time() - start_time))

def calculate_ex(seq, length):
    return calculate(seq, length)

def generate_sequence_ex(number):
    return generate_sequence(number).decode()