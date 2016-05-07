from libc.stdlib cimport realloc, malloc, free
from libc.string cimport memcpy

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

def product_ex(base, repeat):
    x = product(base, 3, repeat)
    for i in range(len(base)**repeat):
        print(x[i])