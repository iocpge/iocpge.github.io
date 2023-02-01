from collections import Counter


def attract_grow_with(v, A, tg, dsg, V, rank):
    if v not in A:  # if not already in attractor
        A[v] = rank
        for u in tg[v]:  # up in the graph if neighbours exist
            dsg[u] -= 1  # decr. since we come from A_j
            if u in V or dsg[u] == 0:  # v in V1 OR (v in V2 and the only way out is towards A_j)
                # print("IN --> ", u)
                attract_grow_with(u, A, tg, dsg, V, rank + 1)
            # else:
            # print("OUT --> ", u)


def attractor(g, V, Cg):
    n = len(g)
    A = {}  # attractor
    tg = g_transpose(g)  # graphe transposé
    dsg = out_degrees(g) # ou bien in_degrees(tg)  # degrés entrants de TG
    rank = 0
    for v in Cg:
        attract_grow_with(v, A, tg, dsg, V, rank)
    return A


def out_degrees(g):
    return {i:len(x) for i, x in enumerate(g)}

def flatten(L):
    flat_list = []
    for adj in g:
        for i in adj:
            flat_list.append(i)
    return flat_list

def in_degrees(g):
    counts = {}
    for adj in g:
        for i in adj:
            # counts[i] = counts.get(i, 0) + 1
            if i in counts:
                counts[i] += 1
            else:
                counts[i] = 1
    return counts



def g_transpose(g):
    tg = [[] for _ in range(len(g))]
    for i in range(len(g)):
        for j in g[i]:
            tg[j].append(i)
    return tg


if __name__ == "__main__":
    arene = [[], [6], [6, 7], [6, 7, 8], [7, 8, 9], [8, 9, 10],
             [], [0], [0, 1], [0, 1, 2], [1, 2, 3], [2, 3, 4]]
    V1 = {0, 1, 2, 3, 4, 5}  # PLAYER 1 VERTEX SET
    V2 = {6, 7, 8, 9, 10, 11}  # PLAYER 2 VERTEX SET
    Cg1 = {0: 0}
    Cg2 = {6: 0}

    print(in_degrees(arene))

    a = attractor(arene, V1, Cg1)
    print("Attractor of Player 1 is -> ", a)

    b = attractor(arene, V2, Cg2)
    print("Attractor of Player 2 is -> ", b)
