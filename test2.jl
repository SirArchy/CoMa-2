mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::String)::Node
    function parseNode(str::String)::Tuple{Node, String}
        # Den Key des Knotens aus dem String extrahieren
        key_str, str = split(str, "(", limit=2)
        key = parse(Int, key_str)

        # Überprüfen, ob der Knoten einen linken Teilbaum hat
        if isempty(str) || str[1] == ','
            left = nothing
            str = str[2:end]
        else
            # Den linken Teilbaum rekursiv parsen
            left, str = parseNode(str[1:end-1])
            str = str[2:end]
        end

        # Überprüfen, ob der Knoten einen rechten Teilbaum hat
        if isempty(str) || str[1] == ')'
            right = nothing
            str = str[2:end]
        else
            # Den rechten Teilbaum rekursiv parsen
            right, str = parseNode(str)
            str = str[2:end]
        end

        # Einen neuen Knoten erstellen und zurückgeben
        node = Node(key, left, right, parent)
        return node, str
    end

    # Den String rekursiv parsen, um den Baum aufzubauen
    root, _ = parseNode(str)
    return root
end

# Beispielaufrufe

println(fromString("4(1,5)"))
println(fromString("3(2(1,2),5(4,))"))
#=
Ausgabe: 
Node(4, Node(1, nothing, nothing, Node(4, nothing, nothing, nothing)), Node(5, nothing, nothing, Node(4, nothing, nothing, nothing)), nothing)
Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, nothing)), nothing)), nothing))
=#
#=
# Beispielaufrufe
tree2 = "3(2(1,2),5(4,))"
tree2 = fromString(tree2)
min2 = min(tree2)
println(min2)
println(getKeyList(tree2))
println(find(tree2, min2))

tree3 = "4(1,5)"
tree3 = fromString(tree3)
min3 = min(tree3)
println(min3)
println(getKeyList(tree3))
println(find(tree3, min3))
tree1 = "13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))"
tree1 = fromString(tree1)
min1 = min(tree1)
println(min1)
println(getKeyList(tree1))
println(find(tree1, min1))
# Erwarteter Output: 
# fromString() korrekt: true
# min: 13
# KeyList: [13, 52, 57, 57, 57, 57, 57, 57, 57, 58, 71]
# find the minimum: 13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))
# unable to find 0: true
# n_nodes: 11
=#