import numpy as np

c = 0


def is_ss(ch, sch):
    if len(sch) == 0:
        return True  # "" est sous-chaîne de toutes les chaînes
    j = 0
    for i in range(len(ch)):
        if ch[i] == sch[j]:
            j += 1  # un caractère commun
            if j == len(sch):
                return True
    return False


def is_common_ss(a, b, sch):
    return is_ss(a, sch) and is_ss(b, sch)


def dp_lss(a, b):
    S = np.zeros((len(a) + 1, len(b) + 1), dtype="int")
    for i in range(len(a) + 1):
        for j in range(len(b) + 1):
            if i == 0 or j == 0:
                S[i, j] = 0
            elif a[i - 1] == b[j - 1]:
                S[i, j] = 1 + S[i - 1, j - 1]
            else:
                S[i, j] = max(S[i - 1, j], S[i, j - 1])
    return S[len(a), len(b)]


def memoize(f):
    memo = {}

    def aux(*x):
        if x not in memo:
            memo[x] = f(*x)
        return memo[x]

    return aux


# Décommenter la ligne suivante pour voir l'effet du décorateur memoize
#@memoize
def rec_lss(a, b):
    global c
    if len(a) == 0 or len(b) == 0:
        return 0
    elif a[-1] == b[-1]:
        c = c + 1
        return 1 + rec_lss(a[:-1], b[:-1])
    else:
        c = c + 2
        return max(rec_lss(a[:-1], b), rec_lss(a, b[:-1]))


def mem_lss(a, b, m):
    global c
    if (a, b) in m:
        return m[(a, b)]
    else:
        if len(a) == 0 or len(b) == 0:
            return 0
        elif a[-1] == b[-1]:
            c = c + 1
            m[(a, b)] = 1 + mem_lss(a[:-1], b[:-1], m)
            return m[(a, b)]
        else:
            c = c + 2
            m[(a, b)] = max(mem_lss(a[:-1], b, m), mem_lss(a, b[:-1], m))
            return m[(a, b)]


if __name__ == "__main__":
    a = "AATGCG"
    b = "TATTAGC"
    assert is_ss(a, "GCG")
    assert not is_ss(a, "TAT")
    assert is_common_ss(a, b, "ATGC")
    assert is_common_ss(a, b, "AAGC")
    assert not is_common_ss(a, b, "TTC")
    s = dp_lss(a, b)
    srec = rec_lss(a, b)
    print("rec_lss - # appels récursifs -> ", c)
    assert 4 == s
    assert s == srec
    d = {}
    c = 0
    m = mem_lss(a, b, {})
    print("mem_lss - # appels récursifs -> ", c)
