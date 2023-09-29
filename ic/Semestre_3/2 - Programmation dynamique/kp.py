import numpy as np

OBJETS = ((100, 40), (700, 15), (500, 2), (400, 9), (300, 18), (200, 2))


def glouton_kp(n, pmax):
    poids = 0  # poids total du sac
    valeur = 0  # valeur total du sac
    sac = []  # contenu du sac
    objets = sorted(list(OBJETS))  # tri ascendant en fonction de la valeur
    while len(objets) > 0 and poids <= pmax:
        v, p = objets.pop()  # choix glouton : la valeur la plus grande
        if poids + p <= pmax:  # l'objet peut-il entrer dans le sac
            sac.append((v, p))
            poids += p
            valeur += v
    return sac, poids, valeur


def dyn_kp(n, pmax): # Programmation dynamique
    s = np.zeros((n + 1, pmax + 1))
    for i in range(n + 1):
        for p in range(pmax + 1):
            vi, pi = OBJETS[i - 1]  # on considère le nième objet
            if i == 0:
                s[i, p] = 0  # pas d'objet pas de solution
            elif pi == 0:  # O kg, une solution : ne prendre aucun objet
                s[i, p] = 0
            elif pi <= p:
                s[i, p] = max(vi + s[i - 1, p - pi], s[i - 1, p])
            else:
                s[i, p] = s[i - 1, p]
    return s[n][pmax]


def rec_kp(n, pmax):
    if n == 0 or pmax == 0:
        return 0
    else:
        v, p = OBJETS[n - 1]  # on considère le nième objet
        if p > pmax:
            return rec_kp(n - 1, pmax)
        else:
            return max(v + rec_kp(n - 1, pmax - p), rec_kp(n - 1, pmax))


def mem_kp(n, pmax, S):  # récursif avec memoïsation
    if (n, pmax) in S:
        return S[(n, pmax)]    # déjà mémorisé
    elif n == 0 or pmax == 0:
        return 0    # condition d'arrêt
    else:
        v, p = OBJETS[n - 1] # on considère le nième objet
        if p > pmax:
            S[(n, pmax)] = mem_kp(n - 1, pmax, S)
            return S[(n, pmax)]
        else:
            S[(n, pmax)] = max(v + mem_kp(n - 1, pmax - p, S),
                               mem_kp(n - 1, pmax, S))
            return S[(n, pmax)]


if __name__ == "__main__":
    print(glouton_kp(6, 15))
    print(glouton_kp(6, 11))
    print(dyn_kp(6, 15))
    print(dyn_kp(6, 11))
    print(rec_kp(6, 15))
    print(rec_kp(6, 11))
    print(mem_kp(6, 15, {}))
    print(mem_kp(6, 11, {}))
