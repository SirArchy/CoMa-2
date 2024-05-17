struct Node
    value::Int
    parent::Union{Node, Nothing}
end

function union_find(data::Vector{Tuple{Int, Vector{Int}}})::Dict{Int, Node}
    nodes = Dict{Int, Node}()
    for (root_val, vals) in data
        root_node = Node(root_val, nothing)
        nodes[root_val] = root_node
        for val in vals
            nodes[val] = Node(val, root_node)
        end
    end
    return nodes
end

function find_set(node::Node)::Node
    while node.parent != nothing
        node = node.parent
    end
    return node
end

function find_set!(node::Node)::Node
    if node.parent != nothing
        node.parent = find_set!(node.parent)
    end
    return node.parent === nothing ? node : node.parent
end

function union!(node1::Node, node2::Node)::Nothing
    root1 = find_set!(node1)
    root2 = find_set!(node2)
    if root1 != root2
        root1.parent = root2
    end
    return nothing
end

function add!(nodes::Dict{Int, Node}, value::Int)::Nothing
    if haskey(nodes, value)
        throw(AssertionError("The element $value is already in the partition"))
    end
    nodes[value] = Node(value, nothing)
    return nothing
end

# Beispielanwendungen:

# Erstellen von Union-Find-Datenstruktur
#Partition = [(1, [2, 3]), (4, [5]), (6, [7, 8, 9])]
#nodes = union_find(Partition)

# Ausführen von find_set ohne Pfadkompression
#println(find_set(nodes[5]))

# Ausführen von find_set mit Pfadkompression
#println(find_set!(nodes[5]))

# Vereinigen der Bäume
#union!(nodes[1], nodes[4])
#println(nodes)

# Hinzufügen eines neuen Wurzelknotens
#add!(nodes, 11)
#println(nodes)

# Versuch, einen Wert hinzuzufügen, der bereits existiert, führt zu einem Fehler
# add!(nodes, 5)