import time
from random import randint


def swap(t, i, j):
    t[i], t[j] = t[j], t[i]


def selection_sort(t):
    for i in range(len(t)):
        min_index = i
        for j in range(i + 1, len(t)):
            if t[j] < t[min_index]:
                min_index = j
        swap(t, i, min_index)


def insertion_sort(t):
    for i in range(1, len(t)):
        to_insert = t[i]
        j = i
        while t[j - 1] > to_insert and j > 0:
            t[j] = t[j - 1]
            j -= 1
        t[j] = to_insert


def bubble_sort(t):
    for i in range(len(t) - 1):
        for j in range(len(t) - 1):
            if t[j] > t[j + 1]:
                swap(t, j, j + 1)


def complexity_counting_sort(t):
    v_max = max(t)
    count = [0] * (v_max + 1)
    for i in range(len(t)):
        count[t[i]] += 1
    for i in range(1, v_max + 1):
        count[i] += count[i - 1]
    output = [None for i in range(len(t))]
    for i in range(len(t)):
        output[count[t[i]] - 1] = t[i]
        count[t[i]] -= 1
    return output


def counting_sort(t):
    v_max = max(t)
    count = [0] * (v_max + 1)
    for i in range(len(t)):
        count[t[i]] += 1
    output = [None for i in range(len(t))]
    i = 0  # indice de parcours du tableau résultat
    for v in range(v_max + 1):
        for j in range(count[v]):
            output[i] = v
            i += 1
    return output


def sort_timing():
    sizes = [i for i in range(10, 5000, 500)]
    M = 5 * max(sizes)
    results = []
    for i in range(len(sizes)):
        t = [randint(0, M) for _ in range(sizes[i])]
        mem_t = t[:]
        results.append([])
        for method in [selection_sort, bubble_sort, insertion_sort, counting_sort, sorted]:
            t = mem_t[:]
            tic = time.perf_counter()
            method(t)
            toc = time.perf_counter()
            results[i].append(toc - tic)
        print("#", i, " - ", sizes[i], " -> ", results)

    sel = [results[i][0] for i in range(len(sizes))]
    bub = [results[i][1] for i in range(len(sizes))]
    ins = [results[i][2] for i in range(len(sizes))]
    cnt = [results[i][3] for i in range(len(sizes))]
    p = [results[i][4] for i in range(len(sizes))]

    from matplotlib import pyplot as plt

    plt.figure()
    plt.plot(sizes, sel, color='red', label='selection sort')
    plt.plot(sizes, bub, color='green', label='bubble sort')
    plt.plot(sizes, ins, color='blue', label='insertion sort')
    plt.plot(sizes, cnt, color='cyan', label='counting sort')
    plt.plot(sizes, p, color='black', label='sorted python')
    plt.xlabel('n', fontsize=18)
    plt.ylabel('time', fontsize=16)
    plt.legend()
    plt.show()


# MAIN PROGRAM
N = 20
M = 100

t = [randint(0, M) for _ in range(N)]

for method in [selection_sort, insertion_sort, bubble_sort, counting_sort]:
    tmp = t[:]
    if method in [selection_sort, bubble_sort, insertion_sort]:  # in-place
        method(tmp)
    else:
        tmp = method(tmp)  # not in-place
    print("--> Method", method.__name__, ":\n ", t, "\n", tmp)

t = ["Zorglub", "Spirou", "Fantasio", "Marsupilami", "Marsu", "Samovar", "Zantafio"]
for method in [selection_sort, insertion_sort, bubble_sort]:  # , counting_sort]:
    method(t)
    print("--> Method", method.__name__, ":\n ", t, "\n", t)

sort_timing()
