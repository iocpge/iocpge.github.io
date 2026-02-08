def echanger(t, i, j):
    tmp = t[i]
    t[i] = t[j]
    t[j] = tmp


def index_du_plus_petit(t, k):
    n = len(t)
    imin = k
    for i in range(k + 1, n):
        if t[i] < t[imin]:
            imin = i
    return imin


def tri_selection(t):
    n = len(t)
    for k in range(n):
        imin = index_du_plus_petit(t, k)
        echanger(t, k, imin)


# TEST
L = [9, 2, 4, 5, 1, 7, 6, 8]
print(L)
tri_selection(L)
print(L)
