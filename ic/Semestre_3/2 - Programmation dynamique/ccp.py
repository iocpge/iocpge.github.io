import math

# PIECES = (5, 1, 2)
PIECES = (4, 1, 3)


def glouton_ccp(prix):
    solution = {}
    nb_de_pieces = 0
    pieces = sorted(list(PIECES))  # tri ascendant sur le premier élement de chaque tuple
    while len(pieces) > 0 and not prix == 0:
        m = pieces.pop()  # on prend la valeur la plus grande
        n = prix // m  # combien de fois ?
        if n > 0:
            solution[m] = n
            prix = prix - n * m
            nb_de_pieces += n
    if prix == 0:
        return [nb_de_pieces, solution]
    else:
        return None  # pas de solution


def glouton_rec_ccp(pieces, prix, solution):
    if prix == 0:
        return solution
    elif len(pieces) == 0:
        return solution
    else:
        m = pieces.pop()  # la plus grande valeur
        n = prix // m  #
        if n > 0:
            solution[m] = n
        return glouton_rec_ccp(pieces, prix - n * m, solution)  # continue...


def dyn_ite_ccp(n, prix):
    S = [[[0, {}] for i in range(prix + 1)] for i in range(n + 1)]
    # On cherche à connaître la solution optimale ET le détail de la répartition des pièces
    for p in range(0, prix + 1):  # pas  de pièces, pas de solution
        S[0][p][0] = math.inf  # inf permet d'utiliser la fonction min, None ne le permet pas

    for p in range(1, prix + 1):
        for i in range(1, n + 1):
            mi = PIECES[i - 1]  # on considère la nième pièce
            if mi <= p:
                a = 1 + S[i][p - mi][0]  # avec
                b = S[i - 1][p][0]  # sans
                S[i][p][0] = min(a, b)
                if a <= b:
                    S[i][p][1] = S[i][p][1] | S[i][p - mi][1]
                    if mi in S[i][p][1]:
                        S[i][p][1][mi] += 1
                    else:
                        S[i][p][1][mi] = 1
                else:
                    S[i][p][1] = S[i][p][1] | S[i - 1][p][1]
            else:
                S[i][p] = S[i - 1][p]
    return S[n][prix]


def mem_ccp(n, prix, mem):
    if (n, prix) in mem:
        return mem[(n, prix)]  # déjà mémorisé
    if prix == 0:
        mem[(n, prix)] = 0
        return mem[(n, prix)]
    elif n == 0:
        mem[(n, prix)] = math.inf
        return mem[(n, prix)]
    else:
        m = PIECES[n - 1]  # on considère la nième pièce
        if m <= prix:
            mem[(n, prix)] = min(1 + mem_ccp(n, prix - m, mem),
                                 mem_ccp(n - 1, prix, mem))
        else:
            mem[(n, prix)] = mem_ccp(n - 1, prix, mem)
        return mem[(n, prix)]


if __name__ == "__main__":
    print(glouton_ccp(6))
    print(glouton_rec_ccp(sorted(list(PIECES)), 6, {}))
    print(dyn_ite_ccp(3, 6))
    print(mem_ccp(3, 6, {}))
