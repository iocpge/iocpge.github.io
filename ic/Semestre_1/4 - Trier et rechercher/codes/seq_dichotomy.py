import time
from random import randint


def seq_search(t, elem):
    for i in range(len(t)):
        if t[i] == elem:
            return i
    return None


def dichotomic_search(t, elem):
    g = 0
    d = len(t) - 1
    while g <= d:
        m = (d + g) // 2
        # print(g, m, d)
        if t[m] < elem:
            g = m + 1
        elif t[m] > elem:
            d = m - 1
        else:
            return m
    return None


def dichotomic_search_left_most(t, elem):
    g = 0
    d = len(t) - 1
    while g < d:
        m = (d + g) // 2
        # print(g, m, d)
        if t[m] < elem:
            g = m + 1
        else:
            d = m
    if t[g] == elem:
        return g
    else:
        return None


def search_timing():
    sizes = [i for i in range(10, 100000, 500)]
    M = 5 * max(sizes)
    results = []
    for i in range(len(sizes)):
        t = sorted([randint(0, M) for _ in range(sizes[i])])
        mem_t = t[:]
        results.append([])
        for method in [seq_search, dichotomic_search, dichotomic_search_left_most]:
            t = mem_t[:]
            tic = time.perf_counter()
            method(t, M // 4)
            toc = time.perf_counter()
            results[i].append(toc - tic)
        print(f"#{i} - {sizes[i]} -> {results}")

    seq = [results[i][0] for i in range(len(sizes))]
    dics = [results[i][1] for i in range(len(sizes))]
    dicslm = [results[i][2] for i in range(len(sizes))]

    from matplotlib import pyplot as plt

    plt.figure()
    plt.plot(sizes, seq, color='cyan', label='Sequential search')
    plt.plot(sizes, dics, color='blue', label='Dichotomic search')
    plt.plot(sizes, dicslm, color='black', label='Dichotomic search left most')
    plt.xlabel('n', fontsize=18)
    plt.ylabel('time', fontsize=16)
    plt.legend()
    plt.show()

# MAIN PROGRAM
t = [0, 1, 2, 4, 7, 7, 9, 13, 17, 65, 99, 99, 99, 99, 101, 111, 111, 111, 113]

print(t)
for value in t:
    print(value, seq_search(t, value), dichotomic_search(t, value), dichotomic_search_left_most(t, value),
          dichotomic_search(t, value) == dichotomic_search_left_most(t, value))

search_timing()
