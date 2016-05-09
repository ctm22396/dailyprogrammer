from libc.stdlib cimport realloc, malloc, free
from libc.stdio cimport printf
from cython cimport cdivision, boundscheck, wraparound
cimport numpy as cnp
import numpy as np
from time import time

cdef extern from "header_int128.h":
    ctypedef unsigned long long int128

cdef struct big

cdef struct Order:
    int * ranks
    int * uniques
    int num_unique

@cdivision(True)
@boundscheck(False)
@wraparound(False)
cdef Order rank(cnp.ndarray[long, mode="c"] sequence, int issorted):
    cdef cnp.ndarray[long, mode="c"] c_sequence = sequence
    cdef cnp.ndarray[long, mode="c"] sorted_sequence
    if not issorted:
        sorted_sequence = np.sort(c_sequence)
    else:
        sorted_sequence = c_sequence
    cdef int num_unique = 0
    cdef int length = sequence.shape[0]
    cdef int * seen = <int *>malloc(sizeof(int))
    cdef int * ranks = <int *>malloc(length * sizeof(int))
    cdef Order out
    cdef int duplicate = 0

    with nogil:
        for i in range(length):
            for j in range(num_unique):
                if sorted_sequence[i] == seen[j]:
                    duplicate = 1
                    break
                else:
                    duplicate = 0
            if not duplicate:
                num_unique += 1
                seen = <int *>realloc(seen, num_unique*sizeof(int))
                seen[num_unique - 1] = sorted_sequence[i]

    for i in range(length):
        for j in range(num_unique):
            if sequence[i] == seen[j]:
                ranks[i] = j

    out.ranks = ranks
    out.uniques = seen
    out.num_unique = num_unique

    return out

@cdivision(True)
@boundscheck(False)
@wraparound(False)
cdef int128 calculate_index(cnp.ndarray[long, mode="c"] c_sequence):
    cdef int length = c_sequence.shape[0]
    cdef int i = 0
    cdef int j = 0
    cdef int128 index = 0
    cdef Order ranks = rank(c_sequence, 0)
    cdef int * counts = <int *>malloc(ranks.num_unique*sizeof(int))
    cdef int128 factorial = 1
    cdef int128 denominator = 1

    with nogil:
        for i in range(ranks.num_unique):
            counts[i] = 0

        i = 0
        for i in reversed(range(length)):
            counts[ranks.ranks[i]] += 1
            denominator *= counts[ranks.ranks[i]]
            j = 0
            for j in range(ranks.ranks[i]):
                if counts[j] > 0:
                    index += factorial * counts[j] / denominator
            factorial *= length - i

    free(counts)

    return index

@cdivision(True)
@boundscheck(False)
@wraparound(False)
def ex_calc_index(sequence):
    cdef cnp.ndarray[long, mode="c"] c_sequence = sequence

    return calculate_index(c_sequence)

@cdivision(True)
@boundscheck(False)
@wraparound(False)
cdef int128 bang(long num) nogil:
    cdef int128 result = 1
    cdef int i = 0

    for i in range(2, num + 1):
        result *= i

    return result

@cdivision(True)
@boundscheck(False)
@wraparound(False)
cdef cnp.ndarray[long, mode="c"] gen_seq(int128 index, cnp.ndarray[long, mode="c"] sorted_array):
    cdef int length = sorted_array.shape[0]
    cdef cnp.ndarray[cnp.int32_t, mode="c"] out = np.empty(length, dtype=np.int32)
    cdef Order ranks = rank(sorted_array, 1)
    cdef int * uniques = ranks.uniques
    cdef int * counts = <int *>malloc(ranks.num_unique*sizeof(int))
    cdef int128 denominator = 1
    cdef int128 permutations = 1
    cdef int128 num_in_block = 0
    cdef int i = 0
    cdef int j = 0
    cdef int k = 0
    cdef int skip = 0
    cdef int remaining = length

    with nogil:
        for i in range(ranks.num_unique):
            counts[i] = 0

        i = 0
        for i in range(length):
            counts[ranks.ranks[i]] += 1

        i = 0
        for i in range(ranks.num_unique):
            denominator *= bang(counts[i])

        permutations = bang(remaining)/denominator

        i = 0
        while index:
            j = 0
            for j in range(ranks.num_unique):
                num_in_block = (permutations * counts[j])/remaining
                if num_in_block > index:
                    break
                else:
                    index -= num_in_block


            out[i] = uniques[j]
            permutations = (permutations * counts[j])/remaining
            remaining -= 1
            counts[j] -= 1
            if counts[j] < 1:
                k = 0
                skip = 0
                for k in range(ranks.num_unique):
                    if counts[k] == 0:
                        skip = 1
                    counts[k] = counts[k + skip]
                    uniques[k] = uniques[k + skip]

                ranks.num_unique -= 1
                counts = <int *>realloc(counts, ranks.num_unique*sizeof(int))
                uniques = <int *>realloc(uniques, ranks.num_unique*sizeof(int))
            i += 1

        j = 0
        for j in range(ranks.num_unique):
            k = 0
            for k in range(counts[j]):
                out[i] = uniques[j]
                i += 1

    free(counts)
    free(uniques)

    return out

def ex_gen_seq(index, sequence):
    cdef cnp.ndarray[long, mode="c"] c_sequence = sequence

    return gen_seq(index, c_sequence)










