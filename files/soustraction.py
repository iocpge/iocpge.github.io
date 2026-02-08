from random import randrange

import attractor

def draw_sticks(p, n):
    sticks = "\u25AE" * (p % (n + 1))
    print(f"Arène (pos. {p}) : \t {sticks} \t \t (reste {len(sticks)} bâtonnets)")

def sg_play():
    n = int(input("Chosissez un nombre de bâtonnets : "))
    assert (n > 0), print("Il faut au moins un bâtonnet !")
    att1, att = attractor.build_attractor(n, 0), attractor.build_attractor(n, 1)
    cg1, cg2 = attractor.gain_condition(n)
    pos = n
    draw_sticks(pos, n)
    human_player = 1
    current_player = 1  # humain commence (c'est arbitraire ;-)
    while pos != cg1 and pos != cg2:
        if human_player == current_player:
            print("Votre attracteur --> ", att1)
            s = int(input("Combien voulez-vous retirer de bâtonnets ? (1,2 ou 3) "))
            assert (0 < s < 4), "Connaissez-vous les règles de ce jeu ? Choisissez une 1, 2 ou 3 bâtonnets !"
            pos = pos - s + (n + 1)
        else:
            print("L'attracteur de l'ordinateur est -->", att)
            next_pos = attractor.next_in_attractor(att, pos)
            if next_pos is None:  # on va perdre... c'est sûr...
                print("L'ordinateur joue aléatoirement...")
                take = randrange(1, 4) % (n + 1)
                pos = pos % (n + 1) - take
            else:
                take = pos % (n + 1) - next_pos
                pos = next_pos
            print("L'ordinateur prend ", take, " bâtonnets --> pos. :", pos)
        draw_sticks(pos, n)
        current_player = 2 if current_player == 1 else 1
    if pos == cg1:
        print("Vous avez gagné !")
    elif pos == cg2:
        print("L'ordinateur a gagné !")


if __name__ == "__main__":
    sg_play()
