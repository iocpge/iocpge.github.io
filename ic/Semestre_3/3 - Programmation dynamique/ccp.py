import math


def greedy_ccp(M, price):
    solution = {}
    coins_nb = 0
    M = sorted(M)
    price_done = False
    while len(M) > 0 and not price_done:
        m = M.pop()
        nb = price // m  # how many times ?
        if nb > 0:  # if 0, no solution with m
            solution[m] = nb
            price = price - nb * m  # continue...
            coins_nb += nb
        if price ==0:
            price_done = True
    if price == 0:  # success
        return [coins_nb, solution]
    else:
        return None  # no solution


def greedy_rec_ccp(M, price, solution):
    n = len(M)
    if price == 0:
        return solution
    elif n == 0:
        return solution
    else:
        m = M.pop()  # choose greatest value, suppose M is sorted
        nb = price // m  # how many times ?
        if nb > 0:  # if 0, no solution with m
            solution[m] = nb
        return greedy_rec_ccp(M, price - nb * m, solution)  # continue...


def dp_ite_ccp(M, price):
    S = [[[0, {}] for i in range(price + 1)] for i in range(len(M) + 1)]
    # On cherche à connaître la solution optimale ET le détail de la répartition des pièces
    for p in range(0, price + 1):  # pas  de pièces, pas de solution
        S[0][p][0] = math.inf      # inf permet d'utiliser la fonction min, None ne le permet pas

    for p in range(1, price + 1):
        for i in range(1, len(M) + 1):
            mi = M[i - 1]
            if mi <= p:
                a = 1 + S[i][p - mi][0]  # with
                b = S[i - 1][p][0]   # without
                S[i][p][0] = min(a, b)
                if a <= b:  # Update dictionary
                    S[i][p][1] = S[i][p][1] | S[i][p - mi][1]
                    if mi in S[i][p][1]:
                        S[i][p][1][mi] += 1
                    else:
                        S[i][p][1][mi] = 1
                else:
                    S[i][p][1] = S[i][p][1] | S[i - 1][p][1]
            else:
                S[i][p] = S[i - 1][p]
    return S[len(M)][price]


def mem_ccp(M, price, mem):
    n = len(M)
    if (n, price) in mem:
        return mem[(n, price)]  # already memorized !
    if price == 0:
        return [0, {}]
    elif n == 0:
        return [math.inf, {}]
    else:
        m = M[0]
        if m <= price:
            mem[(n - 1, price - m)] = mem_ccp(M, price - m, mem)  # with
            mem[(n - 1, price)] = mem_ccp(M[1:], price, mem)  # without
            if (1 + mem[(n - 1, price - m)][0]) <=  mem[(n - 1, price)][0]:
                mem[(n, price)] = [mem[(n - 1, price - m)][0] + 1, {m: 1} | mem[(n - 1, price - m)][1]] # merging
                return mem[(n, price)]
            else:
                mem[(n, price)] = mem[(n - 1, price)]
                return mem[(n, price)]
        else:
            mem[(n, price)] = mem_ccp(M[1:], price, mem)
            return mem[(n, price)]


if __name__ == "__main__":

    M = [5, 1, 2]
    M = [4, 1, 3]

    for P in range(49):
        s = dp_ite_ccp(M, P)
        sg = greedy_ccp(M, P)
        sgr = greedy_rec_ccp(sorted(M[::]), P, {})  # deep copy of M that is destroyed by algorithm
        sgr_coins_nb = sum(sgr.values())  #  coins number
        sgr = [sgr_coins_nb, sgr] # to compare with others
        sm = mem_ccp(M[::], P, {})  # deep copy of M that is destroyed by algorithm
        try:
            assert sg[0] == s[0], f"M={M} - Price --> {P} - Optimal : {s} vs  {sg} - Greedy NOT optimal"
            #assert sgr[0] == s[0], f"M={M} - Price --> {P} - Optimal : {s} vs  {sgr} - Greedy rec NOT optimal"
            #assert sm[0] == s[0], f"M={M} - Price --> {P} - Optimal : {s} vs  {sm} - Memoization NOT optimal"

        except Exception as e:
            print(e)
