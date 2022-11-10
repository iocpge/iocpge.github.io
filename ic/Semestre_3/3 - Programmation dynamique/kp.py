def kp_dp(v, w, W):
    n = len(w)
    s = []
    for i in range(n + 1):
        s.append([0 for _ in range(W + 1)])
        for p in range(W + 1):
            if i == 0:
                s[i][p] = 0  # no objects, no solution, value is zero
            elif w == 0:  # O kg, one solution : take 0 object of 0 value
                s[i][p] = 0
            elif w[i - 1] <= p:
                s[i][p] = max(v[i - 1] + s[i - 1][p - w[i - 1]], s[i - 1][p])
            else:
                s[i][p] = s[i - 1][p]
    return s  # [n][W]


def kp_dp_list(v, w, W):   # with pack detail
    n = len(w)
    s = []
    for i in range(n + 1):
        s.append([[0, []] for _ in range(W + 1)])
        for p in range(W + 1):
            if i == 0 or w == 0:
                s[i][p][0] = 0
            elif w[i - 1] <= p:
                a = v[i - 1] + s[i - 1][p - w[i - 1]][0]
                b = s[i - 1][p][0]
                s[i][p][0] = max(a, b)
                if a > b:
                    s[i][p][1].append(i)
                    s[i][p][1] += s[i - 1][p - w[i - 1]][1]
                    # print("Adding --> ", i, p, s[i][p][1])
            else:
                s[i][p][0] = s[i - 1][p][0]
                s[i][p][1] += s[i - 1][p][1]
    return s[n][W]


def kp_rec(v, w, W):  # simple recursive, not efficient
    n = len(v)
    if n == 0 or W == 0:
        return 0
    else:
        if w[-1] > W:
            return kp_rec(v[:-1], w[:-1], W)
        else:
            return max(v[-1] + kp_rec(v[:-1], w[:-1], W - w[-1]), kp_rec(v[:-1], w[:-1], W))


def kp_mem(v, w, W, S):  # memoization
    n = len(v)
    if n == 0 or W == 0:
        return 0
    else:
        if (n, W) in S:
            return S[(n-1, W)]
        else:
            if w[n - 1] > W:
                S[(n - 1, W)] = kp_mem(v[:-1], w[:-1], W, S)
                return S[(n - 1, W)]
            else:
                S[(n - 1, W)] = max(
                    v[n - 1] + kp_mem(v[:-1], w[:-1], W - w[n - 1], S),
                    kp_mem(v[:-1], w[:-1], W, S))
                return S[(n - 1, W)]


def greedy_kp(objects, W):  # Greedy select best v first
    total_weight = 0
    total_value = 0
    pack = []
    objects = sorted(objects)  # to choose max val, increasing order
    # print(objects)
    while len(objects) > 0 and total_weight <= W:
        o = objects.pop()  # choose an object, the last and the max val !
        # print(o)
        if total_weight + o[1] <= W:  # is it a solution ?
            pack.append(o)  # memorize
            total_weight += o[1]
            total_value += o[0]  # and keep on
    return pack, total_value, total_weight


def ratios_greedy_kp(objects, W):  # Greedy but select best v/w ratio first
    total_weight = 0
    total_value = 0
    pack = []
    ratios = sorted([(v / w, v, w) for v, w in objects])  # to choose max val
    # print(f"Ratios {ratios}")
    while len(ratios) > 0 and total_weight <= W:
        o = ratios.pop()  # choose an object, the last object and the greatest value !
        if total_weight + o[2] <= W:  # is it a solution ?
            pack.append((o[1], o[2]))  # memorize
            total_weight += o[2]
            total_value += o[1]  # and keep on
    return pack, total_value, total_weight


if __name__ == "__main__":
    values = [100, 700, 500, 400, 300, 200]
    weights = [40, 15, 2, 9, 18, 2]
    n = len(weights)
    for max_weight in range(2, 87):
        t = kp_dp_list(values, weights, max_weight)
        s = kp_dp(values, weights, max_weight)
        m = kp_mem(values, weights, max_weight, {})
        r = kp_rec(values, weights, max_weight)
        sg = greedy_kp(zip(values, weights), max_weight)
        srg = ratios_greedy_kp(zip(values, weights), max_weight)
        # print(f"Max weight {max_weight} --> ", s, sg)
        try:
            assert s[n][max_weight] == r, f"Optimal : {s[n][max_weight]} vs {r} (-> recursive not optimal)"
            assert s[n][max_weight] == m, f"Optimal : {s[n][max_weight]} vs {m} (-> mem recursive not optimal)"
            assert s[n][max_weight] == sg[1], f"Optimal : {s[n][max_weight]} vs {sg[1]} (greedy -> not optimal)"
            assert s[n][max_weight] == srg[1], f"Optimal : {s[n][max_weight]} vs {srg[1]} (ratio greedy -> not optimal)"
        except Exception as e:
            print(e)

# Optimal : 900 vs 700 (ratio greedy -> not optimal)
# Optimal : 900 vs 700 (ratio greedy -> not optimal)
# Optimal : 1100 vs 700 (greedy -> not optimal)
# Optimal : 1100 vs 700 (greedy -> not optimal)
# Optimal : 1200 vs 1100 (ratio greedy -> not optimal)
# Optimal : 1200 vs 1100 (ratio greedy -> not optimal)
# Optimal : 1600 vs 1400 (ratio greedy -> not optimal)
# Optimal : 1600 vs 1400 (ratio greedy -> not optimal)
# Optimal : 1900 vs 1800 (ratio greedy -> not optimal)
# Optimal : 1900 vs 1800 (ratio greedy -> not optimal)