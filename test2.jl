mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end


function fromString(str::String, pos::Int)::Node
    if pos > length(str) || str[pos] == ')'
        return nothing
    end
    
    key = parse(Int, str[pos])
    node = Node(key, nothing, nothing, nothing)
    
    pos += 1
    if pos <= length(str) && str[pos] == '('
        pos += 1
        node.left = fromString(str, pos)
        if node.left != nothing
            node.left.parent = node
        end
    end
    
    pos += 1
    if pos <= length(str) && str[pos] == ','
        pos += 1
        node.right = fromString(str, pos)
        if node.right != nothing
            node.right.parent = node
        end
    end
    
    pos += 1  # Move past the closing parenthesis
    
    return node
end

function fromString(str::String)::Node
    return fromString(str, 1)
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