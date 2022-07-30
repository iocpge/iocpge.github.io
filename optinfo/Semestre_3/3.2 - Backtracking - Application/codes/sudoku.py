# coding: utf8
# nb solution --> https://oeis.org/A000170/list
from random import randrange, sample, seed

nu = 3
N = nu * nu
solutions_number = 0
seed(66)

telegram = [8, None, 9, None, None, None, None, None, 7,
            None, None, None, 5, None, 9, None, None, None,
            None, 3, 5, None, 7, None, 8, 9, None,
            None, 2, None, 7, None, 8, None, 1, None,
            7, None, None, None, None, None, None, None, 2,
            None, 6, None, 1, None, 5, 4, 7, None,
            None, 9, 7, 8, 5, 4, 2, 3, None,
            None, None, None, 9, None, 6, 7, None, None,
            5, None, None, None, None, None, None, None, 6
            ]

all_done = [1, 2, 3, 4, 5, 6, 7, 8, 9,
            4, 5, 6, 7, 8, 9, 1, 2, 3,
            7, 8, 9, 1, 2, 3, 4, 5, 6,
            2, 3, 4, 5, 6, 7, 8, 9, 1,
            5, 6, 7, 8, 9, 1, 2, 3, 2,
            8, 9, 1, 2, 3, 4, 5, 6, 7,
            3, 4, 5, 6, 7, 8, 9, 1, 2,
            6, 7, 8, 9, 1, 2, 3, 2, 5,
            9, 1, 2, 3, 4, 5, 6, 7, 8
            ]

multiple = [8, None, 9, None, None, None, None, None, 7,
            None, 7, 6, None, 8, 9, None, None, None,
            None, 3, None, None, 7, None, 8, 9, None,
            None, 2, None, 7, None, 8, None, 1, None,
            7, None, None, None, None, None, None, None, 2,
            None, 6, None, 1, 2, None, 4, 7, None,
            6, 9, 7, 8, None, 4, 2, 3, 1,
            None, None, None, 9, None, 6, 7, None, None,
            None, None, None, None, None, 7, 9, None, 6
            ]



def show(board):
    for c in range(N * N):
        if board[c]:
            print(board[c], end=" ")
        else:
            print('.', end=" ")
        # print("L :", c // N, "C: ", c % N)
        if (c % N) % nu == nu - 1:
            print(' ', end=" ")
        if c % N == N - 1:
            print()
            if (c // N) % nu == nu - 1:
                print()
    print("--")


def in_row(board, c, n):
    row = c // N
    return n in board[row * N:row * N + N]


def in_col(board, c, n):
    col = c % N
    return n in board[col:col + N * N:N]


def in_block(board, c, n):
    row = c // N
    col = c % N
    r = (row // nu) * nu
    c = (col // nu) * nu
    block_given = set()
    for i in range(r, r + nu):
        for j in range(c, c + nu):
            if board[i * N + j]:
                block_given.add(board[i * N + j])
    return n in block_given


def is_valid(board, c, n):
    return not in_row(board, c, n) and not in_col(board, c, n) and not in_block(board, c, n)


def sudoku(board, c=0):
    global solutions_number
    if c == N * N or None not in board:  # last place set or full board
        solutions_number += 1
        print("New solution !", solutions_number)
        show(board)
        return True
    else:
        if board[c] is None:
            for n in range(1, N + 1):
                if is_valid(board, c, n):
                    board[c] = n
                    sudoku(board, c + 1)
                    board[c] = None  # Backtrack
        else:
            sudoku(board, c + 1)
    return False


if __name__ == "__main__":
    show(telegram)
    #sudoku(telegram)
    sudoku(multiple)



