def next(u):
    return u + 1


def u_imp_for(u0, n):
    terme = u0
    for i in range(1, n + 1):
        terme = next(terme)
    return terme


def u_imp_while(u0, n):
    terme = u0
    i = 0
    while i < n:
        terme = next(terme)
        i += 1
    return terme


def u(u0, n):
    if n == 0:
        return u0
    else:
        return u(u0, n - 1) + 1


for i in range(11):
    print("Test rang --> ", i)
    assert u(0, i) == u_imp_for(0, i)
    assert u(0, i) == u_imp_while(0, i)
