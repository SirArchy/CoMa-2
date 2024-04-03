class Node:
    def __init__(self, key):
        self.key = key
        self.leftChild = None
        self.rightChild = None
        self.parent = None
        self.balanceFactor = 0 

class AVLTree:
    def __init__(self, key):
        self.root = Node(key)

    def height(self, node):
        if node is None:
            return 0
        return 1 + max(self.height(node.leftChild), self.height(node.rightChild))

    def updateBalance(self, node):
        if node:
            node.balanceFactor = self.height(node.rightChild) - self.height(node.leftChild)
            self.updateBalance(node.parent)

    def rotateLeft(self, node):
        newRoot = node.rightChild
        node.rightChild = newRoot.leftChild
        if newRoot.leftChild:
            newRoot.leftChild.parent = node
        newRoot.parent = node.parent
        if node is self.root:
            self.root = newRoot
        else:
            if node.parent.leftChild is node:
                node.parent.leftChild = newRoot
            else:
                node.parent.rightChild = newRoot
        newRoot.leftChild = node
        node.parent = newRoot
        self.updateBalance(node)
        self.updateBalance(newRoot)

    def rotateRight(self, node):
        newRoot = node.leftChild
        node.leftChild = newRoot.rightChild
        if newRoot.rightChild:
            newRoot.rightChild.parent = node
        newRoot.parent = node.parent
        if node is self.root:
            self.root = newRoot
        else:
            if node.parent.rightChild is node:
                node.parent.rightChild = newRoot
            else:
                node.parent.leftChild = newRoot
        newRoot.rightChild = node
        node.parent = newRoot
        self.updateBalance(node)
        self.updateBalance(newRoot)

    def rebalance(self, node):
        self.updateBalance(node)
        if node.balanceFactor < -1:
            if node.leftChild.balanceFactor > 0:
                self.rotateLeft(node.leftChild)
            self.rotateRight(node)
        elif node.balanceFactor > 1:
            if node.rightChild.balanceFactor < 0:
                self.rotateRight(node.rightChild)
            self.rotateLeft(node)
        if node.parent:
            self.rebalance(node.parent)
        else:
            self.root = node

    def insert(self, key):
        if not self.root:
            self.root = Node(key)
        else:
            self.insert_node(self.root, key)

    def insert_node(self, parent_node, key):
        if key < parent_node.key:
            if parent_node.leftChild is None:
                parent_node.leftChild = Node(key)
                parent_node.leftChild.parent = parent_node
                self.rebalance(parent_node.leftChild)
            else:
                self.insert_node(parent_node.leftChild, key)
        else:
            if parent_node.rightChild is None:
                parent_node.rightChild = Node(key)
                parent_node.rightChild.parent = parent_node
                self.rebalance(parent_node.rightChild)
            else:
                self.insert_node(parent_node.rightChild, key)


