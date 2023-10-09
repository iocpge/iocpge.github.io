import numpy as np

def rec_de(a, b):
    if len(a) == 0 or len(b) == 0:
        return max(len(a), len(b))
    elif a[0] == b[0]:
        return rec_de(a[1:], b[1:])
    else:
        return 1 + min(rec_de(a[1:], b), rec_de(a[1:], b[1:]), rec_de(a, b[1:]))


def de(a, b):
    S = np.zeros((len(a) + 1, len(b) + 1), dtype="int")
    for i in range(len(a) + 1):
        sa = a[:i]
        for j in range(len(b) + 1):
            sb = b[:j]
            if i == 0 or j == 0:
                S[i, j] = max(i, j)
            elif sa[-1] == sb[-1]:
                S[i, j] = S[i - 1, j - 1]
            else:
                S[i, j] = 1 + min(S[i - 1, j],
                                  S[i - 1, j - 1],
                                  S[i, j - 1])
    return S[len(a), len(b)]


def mem_de(a, b, mem):
    if (a, b) in mem:
        return mem[(a, b)]  #  already computed !
    else:
        if len(a) == 0 or len(b) == 0:
            mem[(a, b)] = max(len(a), len(b))
        elif a[-1] == b[-1]:
            mem[(a, b)] = mem_de(a[:-1], b[:-1], mem)
        else:
            mem[(a, b)] = 1 + min(mem_de(a[:-1], b, mem), mem_de(a[:-1], b[:-1], mem), mem_de(a, b[:-1], mem))
        return mem[(a, b)]


if __name__ == "__main__":
    words = [("sunday", "saturday"), ("chien", "niche"), ("AGATGC", "AGTATCT"), ("Levenshtein", "Lavenshtein"),
             ("sitting", "kitten"), ('mots', 'mois'), ('janvier', 'février'), ('aminci', 'machine'),
             ('aviron', 'avion'),
             ('courir', 'mourir'), ('mourir', 'mourrir'), ('courir', 'partir'), ('adroit', 'gauche'),
             ('liens', 'links')]
    for a, b in words:
        try:
            ite = de(a, b)  # [len(a), len(b)]
            mem = mem_de(a, b, {})
            print(f"{a} --> {b} :  dp --> {ite}, mem --> {mem}")
            assert ite == mem, f"Different results --< {a} vs {b}"
        except Exception as e:
            print(e)

    a = "chien"
    b = "niche"
    S = de(a, b)
    print(S)
