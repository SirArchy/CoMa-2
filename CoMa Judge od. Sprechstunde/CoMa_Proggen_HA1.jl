struct Node
    key::Int
    leftChild::Union{Node, Nothing}
    rightChild::Union{Node, Nothing}
end

function Node(key::Int, leftChild::Union{Node, Nothing}=nothing, rightChild::Union{Node, Nothing}=nothing)
    new(key, leftChild, rightChild)
end

function keys(node::Node)
    # Verwenden eines Stacks, um den Baum zu durchlaufen
    stack = [node]
    result = []
    while !isempty(stack)
        node = pop!(stack)
        if node === nothing
            continue
        end
        # Fügt den Schlüssel des aktuellen Knotens der Ergebnisliste hinzu
        push!(result, node.key)
        # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
        push!(stack, node.rightChild)
        push!(stack, node.leftChild)
    end
    # Gibt die Liste aller Schlüssel im Baum zurück
    result
end

function height(node::Node)
    # Verwenden eines Stacks, um den Baum zu durchlaufen und die Höhe zu berechnen
    stack = [(node, 0)]
    max_height = -1
    while !isempty(stack)
        node, height = pop!(stack)
        if node === nothing
            continue
        end
        # Aktualisiert die maximale Höhe, die bisher gesehen wurde
        max_height = max(max_height, height)
        # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
        push!(stack, (node.rightChild, height+1))
        push!(stack, (node.leftChild, height+1))
    end
    # Gibt die Höhe des Baums zurück
    max_height + 1
end

function leaves(node::Node)
    # Verwenden eines Stacks, um den Baum zu durchlaufen
    stack = [node]
    result = []
    while !isempty(stack)
        node = pop!(stack)
        if node === nothing
            continue
        end
        # Fügt den Schlüssel des Knotens zur Ergebnisliste hinzu, wenn er ein Blatt ist
        if node.leftChild === nothing && node.rightChild === nothing
            push!(result, node.key)
        end
        # Fügt den rechten und linken Nachfolger des Knotens zum Stack hinzu, um später besucht zu werden
        push!(stack, node.rightChild)
        push!(stack, node.leftChild)
    end
    # Gibt die Liste der Schlüssel der Blätter im Baum zurück
    result
end


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