from random import sample, choice


def make_tab(n, m):
    return {(i, j) for i in range(n) for j in range(m)}


def show_tab(tab):
    if len(tab) > 0:
        squares = sorted(list(tab))
        m = max(squares, key=lambda x: x[1])[1] + 1
        for i, j in squares:
            if (i * m + j) % m == 0:
                print()
            print("\u2588", end=' ')
        print(f"     ----> {len(tab)} squares\n")
    else:
        print("No more chocolate !")


def eat(tab, i, j):
    eaten_tab = set()
    for (pi, pj) in tab:
        if pi < i or pj < j:
            eaten_tab.add((pi, pj))
    return eaten_tab


def chomp_score(tab, player_is_max):
    if tab == {(0, 0)}:
        return -1 if player_is_max else 1
    if tab == set():
        return 1 if player_is_max else -1


def minimax(tab, L=10, player_is_max=True):
    # p = "MAX" if player_is_max else "min"
    # show_tab(tab)
    # print(tab)
    if tab == {(0, 0)} or tab == set():  # LEAVES
        return chomp_score(tab, player_is_max), tab
    # assert L != 0, "Max depth reached !"
    if L == 0:
        return chomp_heuristic(tab, player_is_max)
    if player_is_max:
        M = -1
        c = None
        for i, j in tab:
            # print(f"Minimax Considering --> player {p} playing ({i},{j})")
            score, _ = minimax(eat(tab, i, j), L - 1, False)
            if score > M:
                M = score
                c = (i, j)
                # here we can add a break if MAX_SCORE reached
                break
        return M, c
    else:
        m = 1
        c = None
        for i, j in tab:
            # print(f"Minimax Considering --> player {p} playing ({i},{j})")
            score, _ = minimax(eat(tab, i, j), L - 1, True)
            if score < m:
                m = score
                c = (i, j)
                # here we can add a break if MIN_SCORE reached
                break
        return m, c


def chump_play(n, m):
    human_player = 1
    current_player = 2  # human_player
    tab = make_tab(n, m)
    show_tab(tab)
    while True:
        if human_player == current_player:
            s = input(f"Please choose a square ? {tab} ").split(',')
            c = (int(s[0]), int(s[1]))
            assert (c in tab), "Do you know the rules ? Please choose a valid square !"
            print(f"You took : {c}")
        else:
            print("Square ? -> ", is_square_position(tab))
            if is_square_position(tab):
                c = (1, 1)
            else:
                _, c = memo_minimax(tab, {}, 12, True)
                if c is None:
                    print("No wining positions found...")
                    minus_zero = set(tab) - {(0, 0)}
                    c = sample(list(minus_zero), 1)[0]  # do not take (0,0)
            print(f"Computer is taking : {c}")
        tab = eat(tab, c[0], c[1])
        show_tab(tab)
        name = "Computer" if current_player == 2 else "Human Player"
        if tab == {(0, 0)}:
            print(f"Player {name} has won !")
            break
        if len(tab) == 0:
            print(f"Player {name} has lost !")
            break
        current_player = 2 if current_player == 1 else 1


def chomp_heuristic(tab, player_is_max):
    rows = [i for (i, j) in tab]
    cols = [j for (i, j) in tab]
    n_rows = len(rows)
    n_cols = len(cols)
    score = 1 if player_is_max else -1
    if n_rows == 1 \
            or n_cols == 1 \
            or (n_rows == 1 and n_cols == 1):
        return score
    elif n_rows == n_cols and (n_rows - 1, n_cols - 1) in tab:  # Square !
        return -score
    else:
        return -score


def is_square_position(tab):
    rows = [i for (i, j) in tab]
    cols = [j for (i, j) in tab]
    n_rows = len(rows)
    n_cols = len(cols)
    return (n_rows == n_cols) and (n_rows - 1, n_cols - 1) in tab


def memo_minimax(tab, memo, L, player_is_max):
    # p = "MAX" if player_is_max else "min"
    # show_tab(tab)
    # print(tab)
    if tab == {(0, 0)} or tab == set():  # LEAVES
        return chomp_score(tab, player_is_max), tab
    # assert L != 0, "Max depth reached !"
    if L == 0:
        return chomp_heuristic(tab, player_is_max), tab
    if player_is_max:
        M = -1
        c = None
        for i, j in tab:
            # print(f"Minimax Considering --> player {p} playing ({i},{j})")
            key = (frozenset(tab), i, j, L - 1, False)
            if key in memo:
                score = memo[key]
            else:
                score, _ = memo_minimax(eat(tab, i, j), memo, L - 1, False)
            if score > M:
                M = score
                c = (i, j)
                # here we can add a break if MAX_SCORE reached
                break
        return M, c
    else:
        m = 1
        c = None
        for i, j in tab:
            # print(f"Minimax Considering --> player {p} playing ({i},{j})")
            key = (frozenset(tab), i, j, L - 1, True)
            if key in memo:
                score = memo[key]
            else:
                score, _ = memo_minimax(eat(tab, i, j), memo, L - 1, True)
            if score < m:
                m = score
                c = (i, j)
                # here we can add a break if MIN_SCORE reached
                break
        return m, c


if __name__ == "__main__":
    N = 5
    M = 6
    chump_play(N, M)
