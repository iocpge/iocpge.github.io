import math
from random import choice, shuffle
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
    plateau = [[VIDE for _ in range(TAILLE)] for _ in range(TAILLE)]
    # Position initiale
    plateau[3][3] = BLANC
    plateau[3][4] = NOIR
    plateau[4][3] = NOIR
    plateau[4][4] = BLANC
    return plateau


def afficher_plateau(plateau):
    print("  0 1 2 3 4 5 6 7")
    for i in range(TAILLE):
        print(i, end=" ")
        for j in range(TAILLE):
            print(plateau[i][j], end=" ")
        print()


def sur_le_plateau(ligne, colonne):
    return 0 <= ligne < TAILLE and 0 <= colonne < TAILLE


def valider_un_coup(plateau, ligne, colonne, joueur):
    if plateau[ligne][colonne] != VIDE:  # on ne peut pas jouer ce coup
        return []

    # Qui est l'adversaire ?
    adversaire = BLANC if joueur == NOIR else NOIR
    pions_a_retourner = []

    for dx, dy in DIRECTIONS:
        # Tester un direction (dx,dy)
        x, y = ligne + dx, colonne + dy
        pions_potentiels = []

        while sur_le_plateau(x, y) and plateau[x][y] == adversaire:
            pions_potentiels.append((x, y))
            x, y = x + dx, y + dy

        if len(pions_potentiels) > 0 and sur_le_plateau(x, y) and plateau[x][y] == joueur:
            # On peut prendre les pions !
            pions_a_retourner += pions_potentiels

    return pions_a_retourner


def coups_possibles(plateau, joueur):
    coups = []
    for i in range(TAILLE):
        for j in range(TAILLE):
            if valider_un_coup(plateau, i, j, joueur) != []:
                # il est alors possible de jouer ce coup
                coups.append((i, j))
    shuffle(coups)  # on mélange les coups possibles afin de générer des parties différentes
    return coups


def copier_le_plateau(plateau):
    return [ligne[:] for ligne in plateau]


def jouer_un_coup(plateau, ligne, colonne, joueur):
    nouveau_plateau = copier_le_plateau(plateau)
    pions_a_retourner = valider_un_coup(plateau, ligne, colonne, joueur)
    if pions_a_retourner:
        nouveau_plateau[ligne][colonne] = joueur
        for x, y in pions_a_retourner:
            nouveau_plateau[x][y] = joueur
    return nouveau_plateau


def compter_pions(plateau, joueur):
    c = 0
    for i in range(TAILLE):
        for j in range(TAILLE):
            if plateau[i][j] == joueur:
                c += 1
    return c


def est_vainqueur(plateau):
    nb = 0
    nn = 0
    for i in range(TAILLE):
        for j in range(TAILLE):
            if plateau[i][j] == NOIR:
                nn += 1
            elif plateau[i][j] == BLANC:
                nb += 1
    if nb > nn:
        return BLANC
    elif nn > nb:
        return NOIR
    else:
        return None


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
    coups = coups_possibles(plateau, joueur)
    if len(coups) > 0:
        return choice(coups)
    else:
        return None


# Stratégie gloutonne (maximiser le nombre de pions retourner)
def strategie_gloutonne(plateau, joueur):
    meilleur_coup = None
    max_pions = 0

    for ligne, colonne in coups_possibles(plateau, joueur):
        nouveau_plateau = jouer_un_coup(plateau, ligne, colonne, joueur)
        nb_pions = compter_pions(nouveau_plateau, joueur)
        if nb_pions > max_pions:
            max_pions = nb_pions
            meilleur_coup = (ligne, colonne)

    return meilleur_coup


# Minimax
def minimax(plateau, joueur, heuristique, maximisant=True, profondeur=4):
    return 0, None

def minimax_ab(plateau, joueur, heuristique, maximisant=True, profondeur=4, alpha=-math.inf, beta=math.inf):
    return 0, None

def strategie_minimax(plateau, joueur, heuristique, profondeur=4):
    score, coup = minimax(plateau, joueur, heuristique, maximisant=True, profondeur=profondeur)
    return coup


def h_simple(plateau, joueur):
    """Heuristique simple basée sur le nombre de pions et la valeur des cases"""
    adversaire = BLANC if joueur == NOIR else NOIR
    score = 0

    # pondération des cases
    poids = [
        [100, -20, 10, 5, 5, 10, -20, 100],
        [-20, -50, 1, 1, 1, 1, -50, -20],
        [10, 1, 3, 2, 2, 3, 1, 10],
        [5, 1, 2, 1, 1, 2, 1, 5],
        [5, 1, 2, 1, 1, 2, 1, 5],
        [10, 1, 3, 2, 2, 3, 1, 10],
        [-20, -50, 1, 1, 1, 1, -50, -20],
        [100, -20, 10, 5, 5, 10, -20, 100]
    ]
    # TODO
    return score


def h_avancee(plateau, joueur):
    """Heuristique avancée prenant en compte plusieurs facteurs stratégiques"""
    adversaire = BLANC if joueur == NOIR else NOIR
    score = 0
    return score


def jouer_partie_silencieuse(strategie_noire, strategie_blanche):
    plateau = init()
    joueur_courant = NOIR  # Premier joueur (règle officielle)
    impasses = 0
    while impasses < 2:  # un des deux joueurs peut jouer
        coups = coups_possibles(plateau, joueur_courant)
        if not coups:
            impasses += 1
        else:
            impasses = 0
            if joueur_courant == NOIR:
                coup = strategie_noire(plateau, joueur_courant)
            else:
                coup = strategie_blanche(plateau, joueur_courant)
            plateau = jouer_un_coup(plateau, coup[0], coup[1], joueur_courant)

        joueur_courant = BLANC if joueur_courant == NOIR else NOIR
    vainqueur = est_vainqueur(plateau)
    return vainqueur, plateau

def statistiques(N, s1, s2):
    deja_jouee = set()
    r = 0
    for s in range(N):
        print("s --> ", s)
        seed(s)
        v, pl = jouer_partie_silencieuse(s1, s2)
        tpl = tuple(tuple(ligne) for ligne in pl)
        if tpl not in deja_jouee:
            if v == NOIR:
                r += 1
                nn = compter_pions(pl, NOIR)
                afficher_plateau(tpl)
                print("NOIRS --> ", nn)
            deja_jouee.add(tpl)
        else:
            N = N - 1
    return r, N


if __name__ == "__main__":
    #jouer_partie(strategie_gloutonne, strategie_aleatoire)

    s1 = lambda p, j: strategie_minimax(p, j, h_simple, profondeur=4)
    #s2 = lambda p, j: strategie_minimax(p, j, h_avancee, profondeur=2)

    #N = 100
    #r, Neff = statistiques(N, strategie_gloutonne, s2)
    #print("NOIR/N --> ", 100*r/Neff ,"%")
