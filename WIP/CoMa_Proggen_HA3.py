def top_order(G):
    # Initialisierung: Alle Knoten sind weiß und haben keinen Vorgänger
    for node in G:
        node.color = "white"
        node.pred = []
    
    # Hilfsfunktion für Tiefensuche
    def dfs_visit(node, result):
        # Markiere Knoten als grau (besucht, aber noch nicht fertig)
        node.color = "gray"
        # Rekursive Suche in Nachfolgern
        for succ in node.successors:
            if succ.color == "white":
                succ.pred.append(node)
                dfs_visit(succ, result)
            elif succ.color == "gray":
                # Zyklus gefunden
                result.append(-1)
                return
        # Markiere Knoten als fertig (schwarz) und füge ihn zum Ergebnis hinzu
        node.color = "black"
        result.append(node.name)
    
    # Tiefensuche
    result = []
    for node in G:
        if node.color == "white":
            dfs_visit(node, result)
            if result[-1] == -1:
                # Zyklus gefunden
                return [-1]
    
    # Ergebnis zurückgeben
    return result[::-1]


class Node:
    def __init__(self):
        self.name = ""
        self.successors = []
        self.color = "white"
        self.pred = []

def create_graph(adj_list):
    nodes = {}
    for node_name in adj_list:
        if node_name not in nodes:
            nodes[node_name] = Node(node_name)
        for succ_name in adj_list[node_name]:
            if succ_name not in nodes:
                nodes[succ_name] = Node(succ_name)
            nodes[node_name].successors.append(nodes[succ_name])
    return list(nodes.values())



n = Node()
m = Node()
n.name = "Quelle"
m.name = "Senke"
n.color = m.color = "white"
n.successors = [m]
m.successors = []
G = [m, n]
print(top_order(G))
#['Quelle', 'Senke'] #✔
n = Node()
m = Node()
n.name = "links"
m.name = "rechts"
n.color = m.color="white"
n.successors = [m]
m.successors = [n]
G = [m, n]
print(top_order(G))
#[-1] ❌ gibt ['rechts', -1] aus
