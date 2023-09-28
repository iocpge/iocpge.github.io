import numpy as np

OBJETS = ((100, 40), (700, 15), (500, 2), (400, 9), (300, 18), (200, 2))

def greedy_kp(n, pmax):  # Greedy select best v first
    poids = 0  # poids total du sac
    valeur = 0  # valeur total du sac
    sac = []  # contenu du sac
    objets = sorted(list(OBJETS))  # tri ascendant
    while len(objets) > 0 and poids <= pmax:
        v, p = objets.pop()  # choix glouton : la valeur la plus grande
        if poids + p <= pmax:  # l'objet peut-il entrer dans le sac
            sac.append((v, p))
            poids += p
            valeur += v
    return sac, poids, valeur

def kp_dp(n, pmax):
    s = np.zeros((n + 1, pmax + 1))
    for i in range(n + 1):
        for p in range(pmax + 1):
            vi, pi = OBJETS[i - 1]
            if i == 0:
                s[i, p] = 0  # pas d'objet pas de solution
            elif pi == 0:  # O kg, une solution : ne prendre aucun objet
                s[i, p] = 0
            elif pi <= p:
                s[i, p] = max(vi + s[i - 1, p - pi], s[i - 1, p])
            else:
                s[i, p] = s[i - 1, p]
    return s[n][pmax]


def kp_rec(n, pmax):
    if n == 0 or pmax == 0:
        return 0
    else:
        v, p = OBJETS[n - 1]
        if p > pmax:
            return kp_rec(n - 1, pmax)
        else:
            return max(v + kp_rec(n - 1, pmax - p), kp_rec(n - 1, pmax))


def kp_mem(n, pmax, S):  # memoïsation
    if (n, pmax) in S:  # déjà mémorisé
        return S[(n, pmax)]
    elif n == 0 or pmax == 0:
        return 0
    else:
        v, p = OBJETS[n - 1]
        if p > pmax:
            S[(n, pmax)] = kp_mem(n - 1, pmax, S)
            return S[(n, pmax)]
        else:
            S[(n, pmax)] = max(v + kp_mem(n - 1, pmax - p, S),
                               kp_mem(n - 1, pmax, S))
            return S[(n, pmax)]





if __name__ == "__main__":
    print(greedy_kp(6, 15))
    print(greedy_kp(6, 11))
    print(kp_dp(6, 15))
    print(kp_dp(6, 11))
    print(kp_rec(6, 15))
    print(kp_rec(6, 11))
    print(kp_mem(6, 15, {}))
    print(kp_mem(6, 11, {}))
