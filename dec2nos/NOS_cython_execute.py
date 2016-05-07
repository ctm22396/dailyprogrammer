import pyximport; pyximport.install()
from NOS_cython import calculate_ex, generate_sequence_ex
import argparse as ap
from time import time

# if __name__ == "__main__":
#     parser = ap.ArgumentParser(
#         description=("Someone created a new numbering base system based on "
#                     "integers acting as operators.\n"
#                     "The integers that are used in this program are:\n"
#                     "\t0: +\n"
#                     "\t1: -\n"
#                     "\t2: *.\n"
#                     "The position of an integer in a sequence determines "
#                     "what number it is operating on.\n"
#                     "For example:\n"
#                     "\t0000 is equivalent to 0 '+' 1 '+' 2 '+' 3 '+' 4,\n"
#                     "\t012 is equivalent to 0 '+' 1 '-' 2 '*' 3.\n"
#                     "As can be seen, the exists to the right of its index in the sequence.\n\n"),
#         epilog=("As many arguments can be fed into the program as desired. "
#                 "The flag preceding the input will indicate to the program which processing "
#                 "will be done on the input."))
#
#     parser.add_argument("-c", "--calc", metavar="seq", dest="sequence", nargs="+", type=str,
#                         help="Calculates an input sequence.", action="append",
#                         default=[])
#
#     parser.add_argument("-g", "--gen", metavar="num", dest="number", nargs="+", type=str,
#                         help="Generates sequence from input number.", action="append",
#                         default=[])
#
#     args = parser.parse_args()
#     start_time = time()
#
#     if len(args.sequence):
#         print("Calculating value of input sequences:")
#         [print(seq[0]+': {}'.format(calculate_ex(seq[0].encode(), len(seq[0])))) for seq in args.sequence]
#
#     if len(args.number):
#         print("Generating shortest sequences for input numbers:")
#         [print(num[0]+': {}'.format(''.join(generate_sequence_ex(int(num[0]))))) for num in args.number]
#
#     print("It only took {} seconds".format(time() - start_time))
#
#     if not len(args.sequence) and not len(args.sequence):
#         start_time = time()
#         print("Generating shortest sequences for numbers 1 to 500:")
#         [print(str(num)+': {}'.format(generate_sequence_ex(num))) for num in range(1,5001)]
#         print("It only took {} seconds".format(time() - start_time))
