mutable struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function fromString(str::AbstractString)::Union{Node, Nothing}
    stack = Vector{Union{Node, Nothing}}()
    root = nothing
    current_parent = nothing
    
    for c in str
        if c == '('
            continue
        elseif c == ')'
            current_parent = stack[1]
            pop!(stack)
        elseif c == ','
            continue
        else
            key = parse(Int, c)
            node = Node(key, nothing, nothing, current_parent)
            if isempty(stack)
                root = node
            else
                if stack[1].left === nothing
                    stack[1].left = node
                else
                    stack[1].right = node
                end
            end
            push!(stack, node)
        end
    end
    
    return is_search_tree(root) ? root : (println("Der Baum ist kein Suchbaum!"); nothing)
end

function is_search_tree(node::Union{Node, Nothing}, min_val::Int = -Inf, max_val::Int = Inf)::Bool
    if node === nothing
        return true
    elseif node.key < min_val || node.key > max_val
        return false
    else
        return is_search_tree(node.left, min_val, node.key) && is_search_tree(node.right, node.key, max_val)
    end
end



tree1 = "3(2(1,2),5(4,))"
tree1 = fromString(tree1)
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