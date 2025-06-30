import math
from random import choice
from random import seed

# Symboles du plateau de jeu
VIDE = "."
BLANC = "\u25CB"
NOIR = "\u25CF"
TAILLE = 8  # taille du plateau de jeu

NORD = (0, 1)
SUD = (0, -1)
EST = (1, 0)
OUEST = (-1, 0)
NORD_OUEST = (1, -1)
NORD_EST = (1, 1)
SUD_OUEST = (-1, -1)
SUD_EST = (-1, 1)
DIRECTIONS = [NORD, SUD, EST, OUEST, NORD_OUEST, NORD_EST, SUD_OUEST, SUD_EST]

def init():
    pass # TODO


def afficher_plateau(plateau):
    pass  # TODO


def sur_le_plateau(ligne, colonne):
    pass  # TODO

def valider_un_coup(plateau, ligne, colonne, joueur):
    pass # TODO


def coups_possibles(plateau, joueur):
    pass # TODO


def copier_le_plateau(plateau):
    pass  # TODO

def jouer_un_coup(plateau, ligne, colonne, joueur):
    pass  # TODO


def compter_pions(plateau, joueur):
    pass # TODO


def est_vainqueur(plateau):
    pass # TODO


def jouer_partie(strategie_noire, strategie_blanche):
    """Faire jouer l'ordinateur contre lui-même en appliquant des stratégies"""
    plateau = init()
    joueur_courant = NOIR  # Premier joueur (règle officielle)
    impasses = 0

    afficher_plateau(plateau)

    while impasses < 2:  # un des deux joueurs peut jouer
        coups = coups_possibles(plateau, joueur_courant)

        if not coups:
            impasses += 1
            print("Le joueur ", joueur_courant, " ne peut pas jouer !")
        else:
            impasses = 0
            print("Au tour du joueur ", joueur_courant)
            if joueur_courant == NOIR:
                coup = strategie_noire(plateau, joueur_courant)
            else:
                coup = strategie_blanche(plateau, joueur_courant)
            plateau = jouer_un_coup(plateau, coup[0], coup[1], joueur_courant)
            print("Le joueur ", joueur_courant, " a joué en ", coup)

        afficher_plateau(plateau)
        nb = compter_pions(plateau, BLANC)
        nn = compter_pions(plateau, NOIR)
        print("NOIRS / BLANCS -> ", nn, " / ", nb)
        joueur_courant = BLANC if joueur_courant == NOIR else NOIR
    print("Fin de partie")
    vainqueur = est_vainqueur(plateau)
    nb = compter_pions(plateau, BLANC)
    nn = compter_pions(plateau, NOIR)
    if vainqueur == BLANC:
        print("Les BLANCS ont gagnés ! ", nb, " > ", nn)
    elif vainqueur == NOIR:
        print("Les NOIRS ont gagnés ! ", nn, " > ", nb)
    else:
        print("Égalité - partie nulle !", nn, nb)
    return vainqueur


# Stratégie aléatoire
def strategie_aleatoire(plateau, joueur):
    pass # TODO


# Stratégie gloutonne (maximiser le nombre de pions retourner)
def strategie_gloutonne(plateau, joueur):
    pass # TODO


# Minimax
def minimax(plateau, joueur, heuristique, maximisant=True, profondeur=4):
    pass # TODO

# Minimax avec élagage
def minimax_ab(plateau, joueur, heuristique, maximisant=True, profondeur=4, alpha=-math.inf, beta=math.inf):
    pass # TODO


def strategie_minimax(plateau, joueur, heuristique, profondeur=4):
    score, coup = minimax_ab(plateau, joueur, heuristique, maximisant=True, profondeur=profondeur)
    return coup


def h_simple(plateau, joueur):
    pass # TODO




if __name__ == "__main__":
    plateau = init()
    afficher_plateau(plateau)
    #jouer_partie(strategie_gloutonne, strategie_aleatoire)
    #s1 = lambda p, j: strategie_minimax(p, j, h_simple, profondeur=4)
    #jouer_partie(strategie_gloutonne, s1)


