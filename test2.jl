mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function is_search_tree(node::Node)
    if node == nothing
        return true
    end
    
    if node.left != nothing && node.left.key > node.key
        return false
    end
    
    if node.right != nothing && node.right.key < node.key
        return false
    end
    
    return is_search_tree(node.left) && is_search_tree(node.right)
end

function fromString(str::String)::Tuple{Union{Node, Nothing}, String}
    if isempty(str)
        return nothing, "Invalid tree encoding!"
    end
    
    open_bracket = findfirst('(', str)
    close_bracket = findlast(')', str)
    
    if open_bracket == nothing || close_bracket == nothing
        return nothing, "Invalid tree encoding!"
    end
    
    key = parse(Int, str[1:open_bracket-1])
    
    left_str = str[open_bracket+1:close_bracket-1]
    right_str = str[close_bracket+2:end]
    
    left_node, left_error = fromString(left_str)
    if !isempty(left_error)
        return nothing, left_error
    end
    
    right_node, right_error = fromString(right_str)
    if !isempty(right_error)
        return nothing, right_error
    end
    
    node = Node(key, left_node, right_node, nothing)
    
    if left_node != nothing
        left_node.parent = node
    end
    
    if right_node != nothing
        right_node.parent = node
    end
    
    if !is_search_tree(node)
        return nothing, "The tree is not a search tree!"
    end
    
    return node, ""
end






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