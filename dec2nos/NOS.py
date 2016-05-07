import argparse as ap
from itertools import product
from time import time

def calculate(seq):
    val = 0
    for i, operator in enumerate(seq):
        if operator == '0':
            val += i+1
        elif operator == '1':
            val -= i+1
        elif operator == '2':
            val *= i+1
    return val


def generate_sequence(number):
    if number == 0:
        return '2'
    elif number == 1:
        return '0'
    elif number == 2:
        return '00'

    lower = 1
    remaining = number
    while True:
        remaining /= lower
        if remaining <= 1:
            break
        lower += 1

    del remaining

    while True:
        guesses = product('012', repeat=lower)
        enders = []
        for g in guesses:
            op_result = calculate(g)
            if op_result == number:
                return g
                enders.append(g)
        del guesses
        if enders:
            return max(enders, key=lambda x: sum(y == 0 for y in x))
        lower += 1


if __name__ == "__main__":
    parser = ap.ArgumentParser(
        description=("Someone created a new numbering base system based on "
                    "integers acting as operators.\n"
                    "The integers that are used in this program are:\n"
                    "\t0: +\n"
                    "\t1: -\n"
                    "\t2: *.\n"
                    "The position of an integer in a sequence determines "
                    "what number it is operating on.\n"
                    "For example:\n"
                    "\t0000 is equivalent to 0 '+' 1 '+' 2 '+' 3 '+' 4,\n"
                    "\t012 is equivalent to 0 '+' 1 '-' 2 '*' 3.\n"
                    "As can be seen, the exists to the right of its index in the sequence.\n\n"),
        epilog=("As many arguments can be fed into the program as desired. "
                "The flag preceding the input will indicate to the program which processing "
                "will be done on the input."))

    parser.add_argument("-c", "--calc", metavar="seq", dest="sequence", nargs="+", type=str,
                        help="Calculates an input sequence.", action="append",
                        default=[])

    parser.add_argument("-g", "--gen", metavar="num", dest="number", nargs="+", type=str,
                        help="Generates sequence from input number.", action="append",
                        default=[])

    args = parser.parse_args()
    start_time = time()

    if len(args.sequence):
        print("Calculating value of input sequences:")
        [print(seq[0]+': {}'.format(calculate(seq[0]))) for seq in args.sequence]

    if len(args.number):
        print("Generating shortest sequences for input numbers:")
        [print(num[0]+': {}'.format(''.join(generate_sequence(int(num[0]))))) for num in args.number]

    print("It only took {} seconds".format(time() - start_time))

    if not len(args.sequence) and not len(args.sequence):
        start_time = time()
        print("Generating shortest sequences for numbers 1 to 500:")
        [print(str(num)+': {}'.format(''.join(generate_sequence(num)))) for num in range(1,501)]
        print("It only took {} seconds".format(time() - start_time))









