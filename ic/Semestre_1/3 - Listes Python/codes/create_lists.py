h = 5
n = h * h

# EVENS
L = []
for i in range(n):
    L.append(2 * i)  # in extenso
print(L)
L = [2 * i for i in range(n)]  # comprehension
print(L)

# ODDS
L = []
for i in range(n):
    L.append(2 * i + 1)  # in extenso
print(L)
L = [2 * i + 1 for i in range(n)]  # comprehension
print(L)

# [1, 4, 7, 10, ...]
L = []
start = 1
for i in range(n):
    L.append(start + 3 * i)  # in extenso
print(L)
L = [start + 3 * i for i in range(n)]  # comprehension
print(L)

# ZEROS
L = []
for i in range(n):
    L.append(0)  # in extenso
print(L)
L = [0] * n  # comprehension
print(L)

# [1, -1, 1, -1, ...]
# in extenso
L = []
for i in range(n):
    L.append((-1) ** i)  # in extenso
print(L)

# [1, -1, 1, -1, ...]
# comprehension
L = [(-1) ** i for i in range(n)]  # comprehension
print(L)

# [1, 1, 1, ... 1, -1, -1, -1, ..., 1, 1, 1, ...]
# in extenso
L = []
for i in range(h):
    for k in range(h):
        if i % 2 == 0:
            L.append(1)
        else:
            L.append(-1)
print(L)

# [1, 1, 1, ... 1, -1, -1, -1, ..., 1, 1, 1, ...]
# idem
# comprehension et concaténation
L = []
pu = [1] * h
mu = [-1] * h
for i in range(h):
    if i % 2 == 0:
        L += pu
    else:
        L += mu
print(L)

# [1, 1, 1, ... 1, -1, -1, -1, ..., 1, 1, 1, ...]
# idem
# comprehension uniquement
L = [(-1) ** i for i in range(h) for j in range(h)]  # comprehension
print(L)

# [ [1, 1, 1, ... 1], [-1, -1, -1, ...,-1], [1, 1, 1, ..., 1], ...]
# in extenso
L = []
for i in range(h):
    M = []
    for k in range(h):
        if i % 2 == 0:
            M.append(1)
        else:
            M.append(-1)  # in extenso
    L.append(M)
print(L)

# [ [1, 1, 1, ... 1], [-1, -1, -1, ...,-1], [1, 1, 1, ..., 1], ...]
# idem
# partie en compréhension
L = []
pu = [1] * h  # comprehension
mu = [-1] * h  # comprehension
for i in range(h):
    if i % 2 == 0:
        L.append(pu)
    else:
        L.append(mu)
print(L)

# [ [1, 1, 1, ... 1], [-1, -1, -1, ...,-1], [1, 1, 1, ..., 1], ...]
# idem
# compréhension
L = [[(-1) ** i] * h for i in range(h)]  # comprehension
print(L)

# DOMINOS
# in extenso
dominos = []
for i in range(7):
    for j in range(i + 1):
        dominos.append((i, j))
print(len(dominos), dominos)

# DOMINOS
# comprehension
dominos = [(i, j) for i in range(7) for j in range(i + 1)]
print(len(dominos), dominos)