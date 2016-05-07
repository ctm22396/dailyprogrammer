def product(base, repeat):
    base_length = len(base)
    num_products = base_length**repeat
    tmp_list = ['']*(num_products * repeat)
    return_list = ['']*(num_products)

    for i in range(base_length):
        if repeat - 1:
            tmp_product = product(base, repeat - 1)
        for j in range(int(base_length**(repeat-1))):
            for k in range(repeat):
                if not k:
                    tmp_list[k + j * repeat + i * repeat * base_length ** (repeat - 1)] = base[i]
                else:
                    if repeat - 1:
                        tmp_list[k + j * repeat + i * repeat * base_length ** (repeat - 1)] = tmp_product[j][k-1]

    for i in range(num_products):
        tmp_element = [''] * (repeat)
        for j in range(repeat):
            tmp_element[j] = tmp_list[i*repeat + j]
        return_list[i] = tmp_element

    return return_list