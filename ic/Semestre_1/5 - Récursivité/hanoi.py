import time

global moves

global start, aux, target
start = []
aux = []
target = []


def draw_stage(k, tower, size):
    if k <= len(tower):  # there is something to draw
        wm = 2 * tower[k - 1] + 1
        dec = size - wm // 2
        stage = " " * dec + "*" * wm + " " * dec
    else:
        stage = (" " * size + "|" + " " * size)
    return stage


def show_game():
    global start, aux, target
    size = max(max(start) if start else 0, max(aux) if aux else 0, max(target) if target else 0)
    print()
    # pole = (" " * size + "|" + " " * size)
    # print(f"     {pole * 3}")
    pole = (" " * size + " |" + " " * size)
    print("      ", pole * 3)
    for k in range(size, 0, -1):
        s = draw_stage(k, start, size)
        a = draw_stage(k, aux, size)
        t = draw_stage(k, target, size)
        print("#", k, " : ", s, a, t)
        # print(f"#{k} : {s}{a}{t}")


def init_game(n):
    global start, aux, target
    start = [i for i in range(n, 0, -1)]
    aux = []
    target = []


def move_from_a_to_b(from_a, to_b):
    global moves  # mandatory because moves is modified below
    show_game()
    to_b.append(from_a.pop())
    moves += 1
    show_game()


def hanoi(n, s, a, t):
    if n == 1:
        move_from_a_to_b(s, t)
    else:
        hanoi(n - 1, s, t, a)
        move_from_a_to_b(s, t)
        hanoi(n - 1, a, s, t)


# MAIN PROGRAM
moves = 0
n = 5
init_game(n)
print(start, aux, target)
show_game()
hanoi(n, start, aux, target)
show_game()

print(moves)

# for i in range(1, 23):
#     moves = 0
#     init_game(i)
#     hanoi(i, start, aux, target)
#     ui = 2 ** i - 1
#     assert ui == moves

# n = 30
# init_game(n)
# tic = time.process_time()
# hanoi(n, start, aux, target)
# print(time.process_time() - tic)  # 3 minutes environ sans affichage évidememnt
