mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::String)::Node
    pos = 1
    node = goTroughString(str, pos)
    return node[1]
end

function goTroughString(str::String, pos::Integer)
    # get every digit of the key
    number_string = ""
    while pos <= length(str) && isdigit(str[pos])
        number_string = number_string * str[pos]
        pos += 1
    end
    # convert number string to int
    key = parse(Int, number_string)
    # create new node and set its key attribute
    node = Node(key, nothing, nothing, nothing)
    while pos < length(str)
        # open bracket and number next ==> left leaf
        if str[pos] == '(' && pos < length(str) && isdigit(str[pos+1]) 
            pos += 1
            # recursion starting point
            node.left, pos = goTroughString(str, pos)
            node.left.parent = node
        # open bracket and NO number next ==> go on
        elseif str[pos] == '(' && pos < length(str) && !isdigit(str[pos+1])
            pos += 1
        # comma and number next ==> right leaf
        elseif str[pos] == ',' && pos < length(str) && isdigit(str[pos+1]) 
            pos += 1
            # recursion starting point
            node.right, pos = goTroughString(str, pos)
            if node.right !== nothing
                node.right.parent = node.parent
            end
        # comma and NO number next ==> go on
        elseif str[pos] == ',' && pos < length(str) && !isdigit(str[pos+1])
            pos += 1 
        # closing bracket ==> go on and return node
        elseif str[pos] == ')' && pos < length(str) 
            pos += 1
            return node, pos
        else
            return nothing
        end
    end
    return node, pos
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
    keyList = getKeyList(node)
    return keyList[1]
end

# Beispielaufrufe
#= 
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

str = "9(,97)"
tree = fromString(str)
println(tree)
println(getKeyList(tree))
println(find(tree, 5))
println(min(tree))
=#
str = "3(2(1,2),5(4,))"
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