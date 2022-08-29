def champernowne(n):
    s = ""
    i = 1
    while len(s) < n + 1:
        s += str(i)
        i += 1
    return "0." + s[:n]


if __name__ == "__main__":

    # SCRIPT VERSION
    n = 1
    s = "0."
    i = 1
    while len(s) < n + 2:
        s += str(i)
        i += 1
    print("Champernowne ", n, " --> ", s)

    # FUNCTION VERSION
    for i in range(1, 1000):
        print("Champernowne ", i, " --> ", champernowne(i))
        assert i == len(champernowne(i)) - 2
        if "2022" in champernowne(i):
            print("Found --> ", i, champernowne(i))
            break
