import networkx as nx
import matplotlib.pyplot as plt


def tracer_graphe(adj, villes):
    G = nx.Graph()
    n = len(villes)

    # Ajout des nœuds avec le nom de la ville en attribut
    for i in range(n):
        G.add_node(i, nom=villes[i])

    # Ajout des arêtes
    for u in range(n):
        for voisin in adj[u]:
            v = voisin[0]
            poids = voisin[1]
            if u < v:
                G.add_edge(u, v, weight=poids)

    # Dessin
    pos = nx.spring_layout(G)  # Positionnement des sommets
    labels = {}
    for i in range(n):
        labels[i] = villes[i]

    nx.draw(
        G, pos, labels=labels, with_labels=True, node_color="lightblue", node_size=2000
    )

    labels_aretes = nx.get_edge_attributes(G, "weight")
    nx.draw_networkx_edge_labels(G, pos, edge_labels=labels_aretes)

    plt.show()


def tracer_cycle(villes, matrice_dist, cycle):
    """Affiche le graphe correspondant au cycle emprunté."""
    G = nx.Graph()
    n = len(cycle)

    for i in range(n - 1):
        u = cycle[i]
        v = cycle[i + 1]
        poids = matrice_dist[u][v]
        G.add_edge(u, v, weight=poids)

    u = cycle[n - 1]
    v = cycle[0]
    poids = matrice_dist[u][v]
    G.add_edge(u, v, weight=poids)

    labels = {}
    for i in cycle:
        labels[i] = villes[i]

    pos = nx.spring_layout(G)
    nx.draw(
        G, pos, labels=labels, with_labels=True, node_color="lightgreen", node_size=1500
    )

    labels_aretes = nx.get_edge_attributes(G, "weight")
    nx.draw_networkx_edge_labels(G, pos, edge_labels=labels_aretes)

    plt.show()
