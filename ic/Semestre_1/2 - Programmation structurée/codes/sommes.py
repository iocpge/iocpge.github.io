from math import log


def somme(n):
    acc = 0
    for i in range(1, 10 ** n + 1):
        acc += 1 / i
    return acc


def diff(n):
    return somme(n) - log(10 ** n)


if __name__ == "__main__":
    for i in range(1, 8):
        print("#", i, " --> ", diff(i))
