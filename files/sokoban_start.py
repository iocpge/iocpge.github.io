import math
import queue
import traceback
from copy import deepcopy

NORD = (-1, 0)
SUD = (1, 0)
EST = (0, 1)
OUEST = (0, -1)
DIRECTIONS = [NORD, SUD, EST, OUEST]
MURS = ['╶', '╷', '┌', '╴', '─', '┐', '┬', '╵', '└', '│', '├', '┘', '┴', '┤', '┼']

def init_level():
    taille = (8, 8)
    murs = {(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7),
            (1, 0), (1, 2), (1, 7),
            (2, 0), (2, 4), (2, 5), (2, 7),
            (3, 0), (3, 2), (3, 7),
            (4, 0), (4, 2), (4, 5), (4, 7),
            (5, 0), (5, 2), (5, 7),
            (6, 0), (6, 4), (6, 5), (6, 7),
            (7, 0), (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7)}
    cibles = {(1, 1), (3, 6)}
    caisses = {(2, 2), (4, 4)}
    joueur = (3, 1)
    return {"taille": taille, "murs": murs, "cibles": cibles, "joueur": joueur, "caisses": caisses}

def affiche(carte):
    nl, nc = carte["taille"]
    print('  ', end='')
    for i in range(nl):
        print(i, end='')
    for i in range(nc):
        print("\n" + str(i), end=' ')
        for j in range(nl):
            if (i, j) in carte["murs"]:
                if i==0 and j==0:
                    print('┌', end='')
                elif i==0 and j== nc-1:
                    print('┐', end='')
                elif i==nl -1 and j== 0:
                    print('└', end='')
                elif i==nl-1 and j== nc-1:
                    print('┘', end='')
                elif  i==0 and (i+1,j) in carte["murs"]:
                    print('┬', end='')
                elif  i == nl-1 and (i-1,j) in carte["murs"]:
                    print('┴', end='')
                elif  j==0 and (i,j+1) in carte["murs"]:
                    print('├', end='')
                elif  j == nc-1 and (i,j-1) in carte["murs"]:
                    print('┤', end='')
                elif j == 0 or j == nc -1:
                    print('│', end='')
                elif i==0 or i == nl-1:
                    print('─', end='')
                elif j == 0 or j == nc -1:
                    print('│', end='')
                else:
                    print('\u2588', end='')
            elif (i, j) in carte["cibles"]:
                print('\033[31m\u272A\033[0m', end='')
            elif (i, j) in carte["caisses"]:
                print('\033[34m\u25C8\033[0m', end='')
            elif (i, j) == carte["joueur"]:
                print('\033[32m\u25C9\033[0m', end='')
            else:
                print(' ', end='')
    print()


def hash_carte(carte):
    pass # TODO


def mvt_valide(carte, pos):
    pass # TODO


def distance_manhattan(pos1, pos2):
    pass # TODO


def heuristique(carte):
    pass  # TODO



def resolu(carte):
    pass  # TODO


def pos_suivante(carte, direction):
    pass  # TODO


def astar(carte):
    pass # TODO


def jouer():
    pass # TODO


if __name__ == '__main__':
    level = init_level()
    affiche(level)
    jouer()
