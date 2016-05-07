from libc.stdlib cimport malloc, free
from libc.string cimport strcmp

cdef char ** to_cstring_array(list_str):
    cdef char **ret = <char **>malloc(len(list_str) * sizeof(char *))
    for i in range(len(list_str)):
        ret[i] = list_str[i]
    return ret

def foo(list_str1, list_str2):
    cdef unsigned int i, j
    cdef char **c_arr1 = to_cstring_array(list_str1)
    cdef char **c_arr2 = to_cstring_array(list_str2)

    for i in range(len(list_str1)):
        for j in range(len(list_str2)):
            if i != j and strcmp(c_arr1[i], c_arr2[j]) == 0:
                print(i, j, list_str1[i])
    free(c_arr1)
    free(c_arr2)