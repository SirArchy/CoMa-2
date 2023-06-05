mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function getKeyList(tree::Node)::Vector{Int}
    keys = Int[]
    if tree.left !== nothing
        keys = [keys; getKeyList(tree.left)]
    end
    push!(keys, tree.key)
    if tree.right !== nothing
        keys = [keys; getKeyList(tree.right)]
    end
    return keys
end

function find(tree::Node, k::Int)::Union{Node, Nothing}
    if tree === nothing
        return nothing
    end
    if tree.key == k
        return tree
    elseif k < tree.key
        return find(tree.left, k)
    else
        return find(tree.right, k)
    end
end

function min(tree::Node)::Int
    while tree.left !== nothing
        tree = tree.left
    end
    return tree.key
end

function fromString(str::String)::Node
    function parseNode(str::AbstractString, index::Int)
        if str[index] == '('
            index += 1
        end

        key_str = ""
        while index <= length(str) && isdigit(str[index])
            key_str *= string(str[index])
            index += 1
        end
        key = parse(Int, key_str)

        node = Node(key, nothing, nothing, nothing)

        if index <= length(str) && str[index] == '('
            node.left, index = parseNode(str, index + 1)
        end

        if index <= length(str) && str[index] == '('
            node.right, index = parseNode(str, index + 1)
        end

        if index <= length(str) && str[index] == ')'
            index += 1
        end

        return node, index
    end

    tree, index = parseNode(str, 1)

    if index <= length(str)
        println("Der Baum ist kein Suchbaum!")
        return tree
    end

    return tree
end

# Beispielaufrufe
tree2 = "3(2(1,2),5(4,))"
tree2 = fromString(tree2)
println(tree2)
min2 = min(tree2)
println(min2)
println(getKeyList(tree2))
println(find(tree2, min2))
#=
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