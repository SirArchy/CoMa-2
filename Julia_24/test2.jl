mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::String, pos::Int)::Union{Node, Nothing}
    if pos > length(str) || str[pos] == ')'
        return nothing
    end
    
    while pos <= length(str) && !isdigit(str[pos])
        pos += 1
    end
    
    number_string = ""
    while pos <= length(str) && isdigit(str[pos])
        number_string = number_string * str[pos]
        pos += 1
    end
    key = parse(Int, number_string)
    node = Node(key, nothing, nothing, nothing)
    
    if pos <= length(str) && str[pos] == '('
        pos += 1
        if pos <= length(str) && str[pos] == ','
            pos += 1
            sub_str = str[pos:end]
            node.right = fromString(sub_str, 1) 
            if node.right !== nothing
                node.right.parent = node
            end
        else
            node.left = fromString(str, pos)
            if node.left !== nothing
                node.left.parent = node
            end
        end
        
    end
    
    pos += 1
    if pos <= length(str) && str[pos] == ','
        pos += 1
        sub_str = str[pos:end]
        node.right = fromString(sub_str, 1) 
        if node.right !== nothing
            node.right.parent = node
        end
    end
    
    return node
end

function fromString(str::String)::Node
    return fromString(str, 1) 
end

function getKeyList(tree::Node)::Vector{Int}
    key_list = Int[]
    traverseInOrder(tree, key_list)
    return sort(key_list)
end

function traverseInOrder(node::Union{Node, Nothing}, key_list::Vector{Int})
    if node === nothing
        return
    end
    
    traverseInOrder(node.left, key_list)
    push!(key_list, node.key)
    traverseInOrder(node.right, key_list)
end

function find(node::Union{Node, Nothing}, k::Int)::Union{Node, Nothing}
    if node === nothing || node.key == k
        return node
    elseif k < node.key
        return find(node.left, k)
    else
        return find(node.right, k)
    end
end

function min(node::Node)::Int
    while node.left !== nothing
        node = node.left
    end
    return node.key
end


# Beispielaufrufe

str = "58(49(89,),93(80,))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "4(1,5)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "3(2(1,2),5(4,))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "9(,97)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

str = "13(,58(52(,57(,57(57(,57(57(57,),57)),))),71))"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))
#=
Ausgabe: 
Node(4, Node(1, nothing, nothing, Node(4, nothing, nothing, nothing)), Node(5, nothing, nothing, Node(4, nothing, nothing, nothing)), nothing)
Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, Node(3, Node(2, Node(1, nothing, nothing, Node(2, Node(1, nothing, nothing, nothing), Node(2, nothing, nothing, nothing), nothing)), Node(2, nothing, nothing, nothing)), Node(5, Node(4, nothing, nothing, Node(5, Node(4, nothing, nothing, nothing), nothing, nothing)), nothing, nothing)), nothing)), nothing))
=#

#=
# Beispielaufrufe
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