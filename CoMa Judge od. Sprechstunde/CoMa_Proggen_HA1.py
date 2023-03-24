class Node:
    def __init__(self, key, leftChild=None, rightChild=None):
        self.key = key
        self.leftChild = leftChild
        self.rightChild = rightChild

    def keys(self):
        # Verwenden eines Stacks, um den Baum zu durchlaufen
        stack = [self]
        result = []
        while stack:
            node = stack.pop()
            if node is None:
                continue
            # Fügt den Schlüssel des aktuellen Knotens der Ergebnisliste hinzu
            result.append(node.key)
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            stack.append(node.rightChild)
            stack.append(node.leftChild)
        # Gibt die Liste aller Schlüssel im Baum zurück
        return result

    def height(self):
        # Verwenden eines Stacks, um den Baum zu durchlaufen und die Höhe zu berechnen
        stack = [(self, 0)]
        max_height = -1
        while stack:
            node, height = stack.pop()
            if node is None:
                continue
            # Aktualisiert die maximale Höhe, die bisher gesehen wurde
            max_height = max(max_height, height)
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            stack.append((node.rightChild, height+1))
            stack.append((node.leftChild, height+1))
        # Gibt die Höhe des Baums zurück
        return max_height

    def leaves(self):
        # Verwenden eines Stacks, um den Baum zu durchlaufen
        stack = [self]
        result = []
        while stack:
            node = stack.pop()
            if node is None:
                continue
            # Fügt den Schlüssel des Knotens zur Ergebnisliste hinzu, wenn er ein Blatt ist
            if not node.leftChild and not node.rightChild:
                result.append(node.key)
            # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
            stack.append(node.rightChild)
            stack.append(node.leftChild)
        # Gibt die Liste der Schlüssel der Blätter im Baum zurück
        return result



"""
#First Tree
nodeRLR = Node ( 4 ,None,None)
nodeRL = Node ( 3 ,None, nodeRLR)
nodeRR = Node ( 7 ,None,None)
nodeL =  Node ( 5 ,None,None)
nodeR =  Node ( 2 , nodeRL , nodeRR)
bin1 = Node ( 1 , nodeL , nodeR)

print(bin1.height()) #✔
#3
print(nodeRL.height()) #✔
#1
print(bin1.keys()) #✔
#[ 1 , 5 , 2 , 3 , 4 , 7 ]
print(bin1.leaves()) #✔
#[ 5 , 4 , 7 ]
print(nodeR.leaves()) #✔
#[ 4 , 7 ]


#Second Tree
nodeLL = Node(7, None, None)
nodeL = Node(5, nodeLL, None)
nodeRL = Node(3, None, None)
nodeR = Node(2, nodeRL, None)
bin2 = Node(0, nodeL, nodeR)

#Second Tree
print(bin2.keys()) #✔
#[ 0 , 5 , 7 , 2 , 3 ]
print(nodeLL.height()) #✔
#0
print(bin2.height()) #✔
#2
print(bin2.leaves()) #✔
#[ 7 , 3 ]
print(nodeLL.leaves()) #✔
#[ 7 ]
"""
