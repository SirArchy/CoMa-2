mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::String)::Node
    if isempty(str)
        return nothing
    end
    
    key = parse(Int, match(r"^\d+", str).match)
    node = Node(key, nothing, nothing, nothing)
    
    remaining_str = match(r"\((.*)\)", str).captures[1]
    
    if !isempty(remaining_str)
        index = findfirst('(', remaining_str)
        if index === nothing
            left = parse(Int, match(r"(\d+)(?=,)",remaining_str).match)
            right = parse(Int, match(r"(?<=,)(\d+)",remaining_str).match)
            node.left = Node(left, nothing, nothing, node)
            node.right = Node(right, nothing, nothing, node)
        else
            left_str = remaining_str[1:index-1]
            right_str = remaining_str[index+1:end]
            left = fromString(left_str)
            right = fromString(right_str)
            
            if left !== nothing
                left.parent = node
            end

            if right !== nothing
                right.parent = node
            end

            node.left = left
            node.right = right
        end
    end
    
    return node
end

function getKeyList(tree::Node)::Vector{Int}
    key_list = Int[]
    traverse(tree, key_list)
    return key_list
end

function traverse(node::Union{Node, Nothing}, key_list::Vector{Int})
    if node === nothing
        return
    end
    
    traverse(node.left, key_list)
    push!(key_list, node.key)
    traverse(node.right, key_list)
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
#=
str = "9(,97)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))

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