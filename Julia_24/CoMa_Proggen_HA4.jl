mutable struct Node
    value::Int
    parent::Union{Node, Nothing}
end

function union_find(data::Vector{Tuple{Int, Vector{Int}}})::Dict{Int, Node}
    nodes = Dict{Int, Node}()
    for (root_value, elements) in data
        root = Node(root_value, nothing)
        nodes[root_value] = root
        for element in elements
            if element != root_value
                nodes[element] = Node(element, root)
            end
        end
    end
    return nodes
end

function find_set(node::Node)::Node
    while node.parent !== nothing
        node = node.parent
    end
    return node
end

function find_set!(node::Node)::Node
    if node.parent !== nothing
        node.parent = find_set!(node.parent)
        return node.parent
    else
        return node
    end
end

function union!(node1::Node, node2::Node)::Nothing
    root1 = find_set!(node1)
    root2 = find_set!(node2)
    if root1 != root2
        root2.parent = root1  # Attach the tree of root2 to root1
    end
    return nothing
end

function add!(nodes::Dict{Int, Node}, value::Int)::Nothing
    if haskey(nodes, value)
        throw(AssertionError("The element $value is already in the partition"))
    else
        nodes[value] = Node(value, nothing)  # Create a new tree with the new node as root
    end
    return nothing
end

# Beispielaufrufe

#Partition = [(1, [1, 2, 3]) , (4, [4, 5]), (6,[6, 7, 8, 9])]
#nodes = union_find(Partition)
#find_set(nodes[5]))  # Node(4, nothing)
#find_set!(nodes[5]))  # Node(4, nothing)
#union!(nodes[1], nodes[4])
#nodes
#add!(nodes, 5)  # Soll einen AssertionError werfen
#add!(nodes, 11)
#nodes

#Partition = [(11, [10, 8, 11]), (15, [2, 12, 15]), (14, [14])]
#nodes = union_find(Partition)
#keys(nodes) # [15, 11, 10, 2, 12, 8, 14]
#find_set( Node(15, nothing) ) # 15
#find_set!( Node(15, nothing) ) # 15
#union!(nodes[11], nodes[15])
#union!(nodes[15], nodes[11])
#union!(nodes[15], nodes[10])
#nodes
#add!(nodes, 5)  # Soll einen AssertionError werfen
#add!(nodes, 11)
#nodes

#Die Abgabe war nicht erfolgreich. Das Programm hatte einen Laufzeitfehler.
#
#Fehler in den öffentlichen Testinstanzen:
#Es wurde für 1 von 4(25.0%) der Testinstanzen eine Lösung berechnet.
#Letzte versuchte Instanz:
#Input: [(11, [10, 8, 11]), (15, [2, 12, 15]), (14, [14])]
#Erwarteter Output: keys(nodes) = [15, 11, 10, 2, 12, 8, 14]
#find_set( Node(15, nothing) ) = 15
#Checking functionality of union! by unioning 15 and 11 and 10
#roots of 15 and 11 = 15 11
#roots of 15 and 11 = 15 15
#roots of 15,10,11 = 15 15 15
#AssertionError thrown as expected
#keys(nodes) = [2, 8, 10, 11, 12, 14, 15, 9223372036854775807]. (Sorted for easy comparison)
#Fehler: LoadError