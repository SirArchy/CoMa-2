"""
from collections import deque
import subprocess

BASIS = \
    '\\documentclass[tikz]{{standalone}} \n\n\
    \\begin{{document}} \n\
     \\begin{{tikzpicture}}[every node/.style={{{}}}, every edge/.style={{draw,{}}}] \n\n\
       % Hier stehen die Zeichen-Befehle. \n\
       {} \n\n\
        \\end{{tikzpicture}} \n\
        \\end{{document}}'


class AVLTree():

    def __init__(self, key, commands=None):
        super().__init__(key)
        self.commands = commands
        self.nodestyle = "fill=red"
        self.edgestyle = ""

    def key(self):
        return self.key

    def __str__(self):
        self._set_commands()
        return BASIS.format(self.nodestyle, self.edgestyle, self.commands)

    def _set_commands(self):
        self._determine_words()

        coordinatelist = []
        drawnodelist = []
        for node in self.nodelist:
            ycoord = -len(node.subtreeword) * (self.height)
            xcoord = 0
            for i, entry in enumerate(node.subtreeword):
                xcoord += entry * 2 ** (self.height - i - 1)
            coordinatelist.append('  \\coordinate (x{}) at {};'.format(node.key, (xcoord, ycoord)))
            drawnodelist.append('  \\node (n{}) at (x{}) {{${}$}};'.format(node.key, node.key, node.key))

        drawedgelist = []
        for edge in self.edgelist:
            drawedgelist.append('  \\draw (n{}) edge (n{});'.format(edge[0], edge[1]))

        self.commands = '{} \n{} \n{}'.format('\n'.join(coordinatelist), '\n'.join(drawnodelist),
                                              '\n'.join(drawedgelist))

    def __str__(self):
        self._set_commands()
        return BASIS.format(self.nodestyle, self.edgestyle, self.commands)

    def _determine_words(self):
        que = deque([self.root, '*'])
        self.height = 0
        self.nodelist = [self.root]
        self.edgelist = []
        self.root.subtreeword = []
        while que:
            node = que.popleft()
            if node == '*':
                if que:
                    que.append('*')
                    self.height += 1
            else:
                if node.leftChild != None:
                    que.append(node.leftChild)
                    node.leftChild.subtreeword = node.subtreeword + [-1]
                    self.nodelist.append(node.leftChild)
                    self.edgelist.append((node.key, node.leftChild.key))
                if node.rightChild != None:
                    que.append(node.rightChild)
                    node.rightChild.subtreeword = node.subtreeword + [1]
                    self.nodelist.append(node.rightChild)
                    self.edgelist.append((node.key, node.rightChild.key))

    def vis_file(self):
        with open('avl.tex', 'w+') as ff:
            ff.write(str(self))

    def visualize(self):
        self.vis_file()
        subprocess.call(['pdflatex', 'avl.tex'], stdout=subprocess.DEVNULL)
        subprocess.call(['evince', 'avl.pdf'])
        print('Finished')
"""

class Node:
    def __init__(self, key):
        self.key = key
        self.leftChild = None
        self.rightChild = None
        self.parent = None

class AVLTree:
    def __init__(self, key):
        # Erstelle die Wurzel des AVL-Baums mit dem gegebenen Schlüssel
        self.root = Node(key)

    def insert(self, key):
        # Gehe durch den Baum, um die Position des neuen Knotens zu finden
        node = self.root
        parent = None
        while node:
            if key < node.key:
                parent = node
                node = node.leftChild
            elif key > node.key:
                parent = node
                node = node.rightChild
            else:
                # Der Schlüssel existiert bereits, tue nichts
                return

        # Füge den neuen Knoten an der gefundenen Position ein
        new_node = Node(key)
        new_node.parent = parent

        if key < parent.key:
            parent.leftChild = new_node
        else:
            parent.rightChild = new_node

        # Stelle die AVL-Baum-Eigenschaften wieder her
        self.rebalance(new_node)

    def rebalance(self, node):
        # Durchlaufe den Baum von unten nach oben und prüfe die Balancefaktoren
        while node:
            # Aktualisiere die Höhe des Knotens
            node = self.recalculate_height(node)
            # Berechne den Balancefaktor des Knotens
            balance_factor = self.get_balance_factor(node)

            # Wenn der Balancefaktor größer als 1 ist, wird eine Linksdrehung benötigt
            if balance_factor == 2:
                # Wenn der Balancefaktor des linken Kindes kleiner als 0 ist, wird zuerst eine Rechtsdrehung benötigt
                if self.get_balance_factor(node.leftChild) < 0:
                    self.rotate_left(node.leftChild)
                self.rotate_right(node)
            # Wenn der Balancefaktor kleiner als -1 ist, wird eine Rechtsdrehung benötigt
            elif balance_factor == -2:
                # Wenn der Balancefaktor des rechten Kindes größer als 0 ist, wird zuerst eine Linksdrehung benötigt
                if self.get_balance_factor(node.rightChild) > 0:
                    self.rotate_right(node.rightChild)
                self.rotate_left(node)

            # Gehe zum Elternknoten weiter, um den nächsten Knoten zu überprüfen
            node = node.parent

    def get_height(self, node):
        # Hilfsfunktion, um die Höhe eines Knotens zu erhalten
        if node is None:
            return -1
        else:
            return node.height

    def recalculate_height(self, node):
        # Aktualisiere die Höhe des Knotens und gebe den Elternknoten zurück
        node.height = 1 + max(self.get_height(node.leftChild), self.get_height(node.rightChild))
        return node.parent

    def get_balance_factor(self, node):
        # Hilfsfunktion, um den Balancefaktor eines Knotens zu berechnen
        return self.get_height(node.leftChild) - self.get_height(node.rightChild)

    def rotate_left(self, node):
        # Führe eine Linksdrehung um den gegebenen Knoten durch
        right_child = node.rightChild
        right_left_child = right_child.leftChild
        parent = node.parent


avl = AVLTree(2)
avl.insert(3)
avl.visualize()
avl.insert(4)
avl.visualize()
avl.insert(7)
avl.insert(10)
avl.visualize()
avl.insert(8)
avl.visualize()


#✔
#❌