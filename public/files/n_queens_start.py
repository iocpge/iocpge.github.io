# Traduction du code OCaml en Python

def print_row(col, n):
    for c in range(n):
        if col == c:
            print("\u2655 ", end="")
        else:
            print(". ", end="")
    print()
def show_sol(board):
    for col in board:
        print_row(col, len(board))
    print()

def under_attack(row, col, board):
    up_diag = any((i + j) == (row + col) for i, j in enumerate(board))
    down_diag = any((i - j) == (row - col) for i, j in enumerate(board))
    return col in board or up_diag or down_diag

def n_queens(n):
    def build_solutions(row, current_board):
        if row == n:
            return [current_board]
        # TODO

    return build_solutions(0, [])

def synth(solutions):
    for sol in solutions:
        show_sol(sol)
    print(f"Nombre de solutions: {len(solutions)}")

# Tester avec différentes tailles
for i in range(4, 9):
    synth(n_queens(i))

