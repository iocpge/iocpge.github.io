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
    pole = (" " * size + " |" + " " * size)
    print("      ", pole * 3)
    for k in range(size, 0, -1):
        s = draw_stage(k, start, size)
        a = draw_stage(k, aux, size)
        t = draw_stage(k, target, size)
        print("#", k, " : ", s, a, t)


def init_game(n):
    global start, aux, target
    # TODO :  INIT global start, aux and target
    pass


def move_from_a_to_b(from_a, to_b):
    # TODO : show_game(), move disc from a to b, show_game()
    pass


def hanoi(n, s, a, t):
    # TODO : do not forget stop condition !
    pass


# MAIN PROGRAM
n = 4
init_game(n)
print(start, aux, target)
show_game()
hanoi(n, start, aux, target)
show_game()
