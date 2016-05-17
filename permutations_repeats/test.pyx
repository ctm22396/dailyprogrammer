from libc.stdlib cimport realloc, malloc, free
from libc.stdio cimport printf, scanf, fopen, fclose, FILE, getline
from libc.string cimport strcmp, strcpy, strlen

cdef int partition(char ** array, int low, int high):
    cdef int i = low
    cdef int j = 0
    cdef int k = 0
    cdef int swap = 0
    cdef int rewind = 0
    cdef char * pivot = array[high]

    for j in range(low, high):
        swap = 0
        rewind = 0

        k = 0
        while (pivot + k)[0]:

            if (pivot + k)[0] > (array[j] + k)[0]:
                swap = 1
                break
            elif (pivot + k)[0] == (array[j] + k)[0]:
                rewind += 1
            else:
                break

            k += 1

        if swap:
            temp = array[i]
            array[i] = array[j]
            array[j] = temp
            i += 1

    temp = array[i]
    array[i] = array[high]
    array[high] = temp

    return i


cdef void sort_char_array(char ** array, int low, int high):
    cdef int index = 0

    if low < high:
        index = partition(array, low, high)
        sort_char_array(array, low, index - 1)
        sort_char_array(array, index + 1, high)

def main():
    cdef char * filename = b'test.txt'
    cdef FILE * in_file = fopen(filename, 'rb')

    cdef:
        size_t buf_size = 64
        char ** lines = <char **>malloc(10000*buf_size)
        ssize_t characters = 0
        int num_lines = 0

    while True:
        lines[num_lines] = <char *>malloc(buf_size)
        characters = getline(&lines[num_lines], &buf_size, in_file)
        if characters == -1:
            break
        num_lines += 1

    fclose(in_file)

    sort_char_array(lines, 0, num_lines - 1)

    for j in range(num_lines):

        if j < num_lines - 1:
            printf('%s', lines[j])

        free(lines[j])

    free(lines)
