import numpy as np

def is_ss(ch, sch):
    j = 0
    for i in range(len(ch)):
        if ch[i] == sch[j]:
            j += 1
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
    return S


def mem_lss(a, b, m):
    if (a, b) in m:
        return m[(a, b)]
    else:
        if len(a) == 0 or len(b) == 0:
            return 0
        else:
            if a[-1] == b[-1]:
                r = 1 + mem_lss(a[:-1], b[:-1], m)
                m[(a, b)] = r
                return r
            else:
                r1 = mem_lss(a[:-1], b, m)
                r2 = mem_lss(a, b[:-1], m)
                m[(a, b)] = max(r1, r2)
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
    d = {}
    m = mem_lss(a, b, {})
    print(s, s[len(a), len(b)], m)
    print(a, b, dp_lss(a, b))
