from collections import Counter


def attract_grow_with(v, A, tg, dsg, V):
    if v not in A:  # if not already in attractor
        A.add(v)  # then be in !
        for u in tg[v]:  # up in the graph if neighbours exist
            dsg[u] -= 1  # decr. since we come from A_j
            if u in V or dsg[u] == 0:  # v in V1 OR (v in V2 and the only way out is towards A_j)
                # print("IN --> ", u)
                attract_grow_with(u, A, tg, dsg, V)
            # else:
            # print("OUT --> ", u)


def attractor(g, V, Cg):
    n = len(g)
    A = set()  # attractor
    tg = g_transpose(g)  # graphe transposé
    dsg = in_degrees(tg)  # degrés entrants de TG
    for v in Cg:
        attract_grow_with(v, A, tg, dsg, V)
    return A


def out_degrees(g):
    return [len(x) for x in g]


def in_degrees(g):
    flat_list = [i for adj in g for i in adj]
    in_deg = []
    c = Counter(flat_list)
    for v in range(len(g)):
        if v in c:
            in_deg.append(c[v])
        else:
            in_deg.append(0)
    return in_deg


def g_transpose(g):
    tg = [[] for _ in range(len(g))]
    for i in range(len(g)):
        for j in range(len(g)):
            if i in g[j]:
                tg[i].append(j)
    return tg


if __name__ == "__main__":
    arene = [[], [6], [7], [6, 7], [7, 8, 9], [9, 10],
             [], [0], [1], [0, 1], [1, 2, 3], [3, 4]]
    V1 = {0, 1, 2, 3, 4, 5}  # PLAYER 1 VERTEX SET
    V2 = {6, 7, 8, 9, 10, 11}  # PLAYER 2 VERTEX SET
    Cg1 = {0}
    Cg2 = {6}

    a = attractor(arene, V1, Cg1)
    print("Attractor of Player 1 is -> ", a)

    b = attractor(arene, V2, Cg2)
    print("Attractor of Player 2 is -> ", b)
