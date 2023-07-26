import sys

args = sys.argv
max = int(args[1])
for i in range(1, max+1):
    if i % 15 == 0:
        print(i, "\tFizzBuzz", sep="")
    elif i % 3 == 0:
        print(i, "\tFizz", sep="")
    elif i % 5 == 0:
        print(i, "\tBuzz", sep="")
    else:
        print(i, "\t", sep="")
