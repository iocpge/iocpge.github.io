from math import sqrt


def suite_u(n):
    return 2 ** sqrt(n)


def suite_v(n):
    return sqrt(2 ** n)


def diff(n):
    return suite_u(n) - suite_v(n)


if __name__ == "__main__":
    for i in range(16):
        print("u_", i, " - v_", i, " = ", diff(i))
