from collections import deque
import subprocess
from CoMa_Proggen_HA5 import *

BASIS = \
    '\\documentclass[tikz]{{standalone}} \n\n\
    \\begin{{document}} \n\
     \\begin{{tikzpicture}}[every node/.style={{{}}}, every edge/.style={{draw,{}}}] \n\n\
       % Hier stehen die Zeichen-Befehle. \n\
       {} \n\n\
        \\end{{tikzpicture}} \n\
        \\end{{document}}'


class AVLTree(AVLTree):

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

<<<<<<<< HEAD:Python/CoMa_Proggen_HA5/AVLvis.py
#avl=AVLTree(2)
#avl.insert(3)
#avl.insert(4)
#avl.insert(7)
#avl.insert(10)
#avl.insert(8)
#avl.visualize()
========

avl=AVLTree(2)
avl.insert(3)
avl.visualize()
avl.insert(4)
avl.visualize()
avl.insert(7)
avl.insert(1)
avl.visualize()
avl.insert(8)
avl.visualize()
>>>>>>>> 7e64011519db937628e9d233a2cab67015f4ec22:Python/AVLvis.py
