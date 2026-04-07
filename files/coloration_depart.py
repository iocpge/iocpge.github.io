import networkx as nx
from matplotlib import pyplot as plt


def ladj_to_nx(g):
    gx = nx.Graph()
    n = len(g)
    gx.add_nodes_from([i for i in range(n)])
    for i in range(n):
        for v in g[i]:
            gx.add_edge(i, v)
    return gx


def show(g, color_map):
    color_nodes = ["" for _ in range(len(g))]
    for k, v in enumerate(color_map):
        color_nodes[k] = v
    gx = ladj_to_nx(g)
    nx.draw_networkx(gx, node_color=color_nodes, with_labels=True)
    plt.show()


def couleur_suivante(utilisees, couleurs):
    pass  # TODO


def degrees(g):
    pass  # TODO


def sort_g(g):
    pass  # TODO


def welsh_powel(g, colors):
    n = len(g)
    sommets = sort_g(g)
    colored = [False for _ in range(n)]  # Sommets colorés ou non
    color_map = [None for _ in range(n)]  # Couleur associée à un sommet
    # Pour chaque sommet s du graphe g ...
    # TODO
    return color_map


if __name__ == "__main__":
    colors = [
        "deeppink",
        "darkturquoise",
        "yellow",
        "dodgerblue",
        "magenta",
        "darkorange",
        "lime",
    ]
    g = [
        [1, 3, 14],
        [0, 2, 4, 5],
        [1, 5, 7],
        [0, 4, 8, 13, 14],
        [1, 3, 5, 8],
        [1, 2, 4, 6, 7],
        [5, 7],
        [2, 5, 6],
        [3, 4, 9, 13],
        [8, 10, 13],
        [9, 11, 13],
        [10, 12, 13],
        [11, 13],
        [3, 8, 9, 10, 11, 12, 14],
        [0, 3, 13],
    ]

    color_map = welsh_powel(g, colors)
    print(color_map)
    show(g, color_map)
