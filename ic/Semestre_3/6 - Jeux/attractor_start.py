from operator import itemgetter
from random import randrange

def previous_positions(p, n):
    pos_list = []
    # TODO
    return pos_list


def player_vertices(n):
    # TODO
    return [[], []]


def gain_condition(n):
    # TODO
    return 42,42


def start_positions(n):
    # TODO
    return 42, 42


def in_degrees(n):
    # TODO
    degrees = []  # degrés entrant dans le graphe transposé
    return degrees


def build_attractor(n, player=0):
    Cg = gain_condition(n)[player]
    # position finale de gain de la partie
    s1, s2 = start_positions(n)
    # position de départ des joueurs
    V = player_vertices(n)[player]
    # les sommets du joueur dont on calcule l'attracteur
    din = in_degrees(n)
    A = []  # attracteur
    rank = 0
    F = [(Cg, 0)]
    while len(F) > 0:
        u, rank = F.pop(0) # parcours en largeur
        # TODO



def in_attractor(A, pos):
    # TODO
    return None, None


def next_in_attractor(A, pos):
    # TODO
    return None


if __name__ == "__main__":
    # TESTS
    n = 7
    print(previous_positions(3, n))
    print(previous_positions(14, n))
    print(player_vertices(n))
    print(gain_condition(n))
    print(start_positions(n))
    print()

    A1 = build_attractor(n, 0)
    print(A1)
    A2 = build_attractor(n, 1)
    print(A2)

    print(next_in_attractor(A2, 17))
    print(next_in_attractor(A2, 15))
    print(next_in_attractor(A2, 13))
    print(next_in_attractor(A2, 12))
