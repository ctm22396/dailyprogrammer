from libc.stdlib cimport realloc, malloc, atoi, strtol
from libc.stdio cimport fopen, fclose, FILE, getline, printf
from libc.string cimport strlen
from cython cimport cdivision, boundscheck, wraparound
from time import time

cdef extern from 'ctype.h':
    int isdigit(char c)

cdef struct RouteList:
    int ** routes
    int num_routes
    int * len_routes

@cdivision(True)
@boundscheck(False)
@wraparound(False)
cdef RouteList routes_from_file(const char * filename):
    cdef FILE * route_file = fopen(filename, 'rb')
    cdef RouteList empty
    empty.routes = NULL
    empty.num_routes = 0
    empty.len_routes = NULL

    if not route_file:
        return empty

    cdef:
        size_t buf_size = 64
        char ** lines = <char **>malloc(10*buf_size)
        ssize_t characters = 0
        int i = 0

    while True:
        lines[i] = <char *>malloc(buf_size)
        characters = getline(&lines[i], &buf_size, route_file)
        if characters == -1:
            break
        i += 1


    fclose(route_file)

    cdef int num_lines = 0
    while strlen(lines[num_lines]):
        num_lines += 1

    cdef RouteList route_list

    route_list.num_routes = num_lines
    route_list.len_routes = <int *>malloc(num_lines * sizeof(int))
    route_list.routes = <int **>malloc(num_lines * sizeof(int *))

    if not route_list.len_routes:
        return empty
    if not route_list.routes:
        return empty

    i = 0
    cdef int len_line = 0
    cdef int val = 0
    cdef int since_space = 0
    cdef char * char_to_int
    cdef int cleaner = 0
    for i in range(num_lines):
        len_line = 0
        route_list.routes[i] = <int *>malloc(sizeof(int))
        route_list.routes[i][0] = 0
        if not route_list.routes[i]:
            return empty

        while lines[i][0] != b'\n' and lines[i][0] != b'\0':
            if 47 < lines[i][0] < 58:
                since_space += 1
            else:

                if since_space:
                    lines[i] -= since_space
                    cleaner = 0
                    while not isdigit(lines[i][0]):
                        cleaner += 1
                        lines[i] += 1
                    route_list.routes[i][len_line] = atoi(lines[i])
                    lines[i] -= cleaner
                    lines[i] += since_space
                    len_line += 1
                    route_list.routes[i] = <int *>realloc(route_list.routes[i], (len_line + 1) * sizeof(int))
                    if not route_list.routes[i]:
                        return empty
                    route_list.routes[i][len_line] = 0
                    since_space = 0

            lines[i] += 1

        if len_line:
            lines[i] -= since_space
            cleaner = 0
            while not isdigit(lines[i][0]):
                cleaner += 1
                lines[i] += 1
            route_list.routes[i][len_line] = atoi(lines[i])
            lines[i] -= cleaner
            lines[i] += since_space
            len_line += 1
            route_list.routes[i] = <int *>realloc(route_list.routes[i], len_line * sizeof(int))
            if not route_list.routes[i]:
                    return empty
        route_list.len_routes[i] = len_line

    return route_list

@cdivision(True)
@boundscheck(False)
@wraparound(False)
def main(filename):
    cdef RouteList route_list = routes_from_file(filename)

    t0 = time()

    cdef int i = 0
    cdef int j = 0
    cdef int k = 0
    cdef int m = 0
    cdef int n = 0
    cdef int val = 0
    cdef int step = 0
    i = 0
    cdef int ** info = <int **>malloc(route_list.num_routes * sizeof(int *))

    #########################################
    # Allocate and initialize info array.
    j = 0
    for j in range(route_list.num_routes):
        info[j] = <int *>malloc(route_list.num_routes * sizeof(int))
        info[j][j] = 1
        k = 0
        for k in range(route_list.num_routes):
            if k != j:
                info[j][k] = 0
    #########################################

    #########################################
    # Cycle through the rounds.
    for i in range(481): # limited to 480 by the problem

        #########################################
        # Swaps gossip for drivers meeting at
        # stops. Steps == minutes within round.
        j = 0
        for j in range(route_list.num_routes):
            k = 0
            for k in range(route_list.num_routes):

                #########################################
                # Skips if drivers are the same, because,
                # duh, they're going to meet. Also skips
                # symmetric meetings.
                if j == k:
                    continue
                if j < k:
                    break
                #########################################

                j_step = i % route_list.len_routes[j]
                k_step = i % route_list.len_routes[j]
                j_info = []
                k_info = []
                if route_list.routes[j][j_step] == route_list.routes[k][k_step]:
                    for m in range(route_list.num_routes):
                        info[j][m] = info[j][m] or info[k][m]
                        info[k][m] = info[k][m] or info[j][m]
                        j_info.append(info[j][m])
                        k_info.append(info[k][m])
                    print("({}m, stop: {} | {}, {} | {})".format(i,route_list.routes[j][j_step],j, k, k_info))

                #########################################
                # Checks if every driver's gossip has
                #  been shared
                val = 0
                m = 0
                for m in range(route_list.num_routes):
                    n = 0
                    for n in range(route_list.num_routes):
                        val = val + info[m][n]

                if val == route_list.num_routes**2:
                    m = 0
                    for m in range(route_list.num_routes):
                        n = 0
                        for n in range(route_list.num_routes):
                            printf('%d ', info[m][n])
                        printf('\n')
                    print("Took {} seconds.".format(time() - t0))
                    return i
                #########################################

        #########################################

    #########################################

    print("Took {} seconds.".format(time() - t0))
    return -1








