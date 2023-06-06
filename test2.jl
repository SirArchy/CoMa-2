mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::String)::Union{Node, String}
    function parseNode(substr::SubString)::Union{Node, String}
        if isempty(substr)
            return nothing
        end

        key_str, rest = split(substr, "(", limit=2)
        if isempty(rest)
            return "Ungültiger Baum: Fehlendes öffnendes oder schließendes Klammernpaar"
        end

        key = parse(Int, key_str)

        if isempty(rest)
            return Node(key, nothing, nothing, nothing)
        end

        left_substr, right_substr = split(rest, ",", limit=2)
        if isempty(right_substr)
            right_substr = ""
        end

        left_node = parseNode(left_substr)
        if typeof(left_node) == String
            return left_node
        end

        right_node = parseNode(right_substr)
        if typeof(right_node) == String
            return right_node
        end

        node = Node(key, left_node, right_node, nothing)
        left_node.parent = node
        right_node.parent = node
        return node
    end

    root_node = parseNode(str)
    if typeof(root_node) == String
        return "Der Baum ist kein Suchbaum!"
    end

    function isSearchTree(node::Node, min_key::Int, max_key::Int)::Bool
        if node === nothing
            return true
        end

        if node.key < min_key || node.key > max_key
            return false
        end

        return isSearchTree(node.left, min_key, node.key-1) && isSearchTree(node.right, node.key+1, max_key)
    end

    if isSearchTree(root_node, Int64.min, Int64.max)
        return root_node
    else
        return "Der Baum ist kein Suchbaum!"
    end
end




tree = fromString("4(1,5)")
# Ausgabe: Node(4, Node(1, nothing, nothing, Node(4, nothing, nothing, nothing)), Node(5, nothing, nothing, Node(4, nothing, nothing, nothing)), nothing)
println(tree)
tree1 = fromString("3(2(1,2),5(4,))")
println(tree1)

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