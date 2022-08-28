from random import randrange

from cours.Jeux.attractor import attractor


def sg_arena(n):
    size = n + 1
    a = [[] for _ in range(2 * size)]
    for i in range(size):
        for j in range(1, 4):
            if i - j >= 0:
                a[i].append(size + i - j)
                a[i + size].append(i - j)
    return a


def is_player(a, p):
    n = len(a)
    return 1 if p <= n else 2


def next_in_attractor(a, att, p):
    for v in a[p]:
        if v in att:
            return v
    return None


def compute_attractors(a, cg1, cg2):
    n = len(a) // 2
    v1 = {i for i in range(n + 1)}
    att1 = attractor(a, v1, cg1)
    v2 = {i for i in range(n + 1, 2 * n + 2)}
    att2 = attractor(a, v2, cg2)
    return att1, att2


def build_arena(n):
    a = sg_arena(n)
    print("Arena -> ", a)
    cg1 = {n + 1}
    cg2 = {0}
    # Misery variation
    # cg1 = {0, n + 2}
    # cg2 = {1, n + 1}
    att1, att2 = compute_attractors(a, cg1, cg2)
    print("Attractors ->", att1, att2)
    assert (len(att1) == len(att2))
    return a, cg1, cg2, att2, att2


def draw_sticks(p, a, misery=True):
    mod = len(a) // 2
    sticks = "\u25AE" * (p % mod)
    print(f"Arena (pos. {p}) : \t {sticks} \t \t (it leaves {len(sticks)} sticks)")


def sg_play():
    n = None
    human_player = None
    n = int(input("Enter the game's size N : "))
    assert (n > 0), print("At least one stick is needed !")
    human_player = int(input("Do you want player 1 or 2 ? (first or second ?) : "))
    assert (0 < human_player < 3), print("Please enter a correct integer !")
    a, cg1, cg2, att1, att2 = build_arena(n)
    pos = n
    att = att2 if human_player == 1 else att1
    draw_sticks(pos, a)
    current_player = 1
    while True:
        if human_player == current_player:
            s = int(input("How many sticks do you want to remove ? (1,2 or 3) "))
            assert (0 < s < 4 and pos - s >= 0), "Do you know the rules ? Please enter a correct integer value !"
            if pos <= n:
                pos = pos - s + (n + 1)
            else:
                pos = pos - s - (n + 1)
        else:
            next_pos = next_in_attractor(a, att, pos)
            if next_pos is None:  # we are going to loose, slowly !
                if pos <= n:
                    pos = pos - randrange(1, 4) + (n + 1)
                else:
                    pos = pos - randrange(1, 4) - (n + 1)
            else:
                pos = next_pos
            print("Computer is playing #####")
        draw_sticks(pos, a)
        if pos in cg1 or pos in cg2:
            print(f"Player {current_player} has won !")
            break
        current_player = 2 if current_player == 1 else 1


if __name__ == "__main__":
    sg_play()
