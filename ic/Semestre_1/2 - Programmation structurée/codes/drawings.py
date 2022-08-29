def block(n):
    s = ""
    for row in range(n):
        for col in range(n):
            if row == 0 or row == n - 1 or col == 0 or col == n - 1:
                s = s + "* "
            else:
                s = s + ". "
        s = s + "\n"
    return s


def square_diag(n):
    s = ""
    for row in range(n):
        for col in range(n):
            if row - col == 0 or row + col == n - 1:
                s = s + "* "
            else:
                s = s + ". "
        s = s + "\n"
    return s


def losange(n):
    assert n % 2 == 1
    s = ""
    for row in range(n):
        for col in range(n):
            if (row + col) % (n - 1) == n // 2 or abs(row - col) == n // 2:
                s = s + "* "
            else:
                s = s + ". "
        s = s + "\n"
    return s


if __name__ == "__main__":
    print(block(5))
    print(square_diag(5))
    print(losange(5))
