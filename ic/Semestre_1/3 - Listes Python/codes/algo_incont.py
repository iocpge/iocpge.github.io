import random


def count_if_sup(L, v):
    c = 0
    for elem in L:
        if elem > v:
            c += 1
    return c


def max_val(L):
    if len(L) > 0:
        maxi = L[0]
        for elem in L:
            if elem > maxi:
                maxi = elem
        return maxi
    else:
        return None


def max_index(L):
    if len(L) > 0:
        maxi = L[0]
        index = 0
        for i in range(1, len(L)):
            if L[i] > maxi:
                maxi = L[i]
                index = i
        return index
    else:
        return None


def min_max_index(L):
    if len(L) > 0:
        mini, maxi = L[0], L[0]
        i_min, i_max = 0, 0
        for i in range(1, len(L)):
            if L[i] > maxi:
                maxi = L[i]
                i_max = i
            if L[i] < mini:
                mini = L[i]
                i_min = i
        return (i_min, i_max)
    else:
        return None, None


def average(L):
    return sum(L) / len(L)


# MAIN PROGRAM
N = 10
# in extenso
L = []
for i in range(N):
    L.append(random.random())
# idem comprehension
L = [random.random() for i in range(N)]

print(L)
threshold = 0.5
print(count_if_sup(L, threshold), " elements are greater than ", threshold)
print("Max value is ", max_val(L))
print("Max index is ", max_index(L))
print("(i_min, i_max) =", min_max_index(L))
i_min, i_max = min_max_index(L)  # unpacking tuple
print("i min =", i_min, ", i_max =", i_max)
print(average(L))
