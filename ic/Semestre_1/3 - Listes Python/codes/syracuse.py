def suivant(u):
    if u % 2 == 0:
        return u // 2
    else:
        return 3 * u + 1


def syracuse(u0):
    u = u0
    vol = [u0]
    while u != 1:
        u = suivant(u)
        vol.append(u)
    return vol


def steroids_syracuse(u0):
    u = u0
    vol = [u0]
    vol_alt = 0
    max_alt = u0
    flying = True
    while u != 1:
        u = suivant(u)
        vol.append(u)
        if u > max_alt:
            max_alt = u
        if flying:
            if u > u0:
                vol_alt += 1
            else:
                flying = False
    return vol, max_alt, vol_alt


if __name__ == "__main__":
    vol = syracuse(3)
    print(vol, len(vol)-1)

    for u0 in [3, 7, 25, 54, 97, 703]:
        vol, max_alt, vol_alt = steroids_syracuse(u0)
        print("u0 =", u0, "vol :", vol, " flight time :", len(vol)-1, " Max altitude :", max_alt, " alt. vol :", vol_alt)
