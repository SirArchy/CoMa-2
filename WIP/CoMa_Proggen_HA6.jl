struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    parent::Union{Node, Nothing}
end

function getKeyList(tree::Node)::Vector{Int}
    if tree === nothing
        return []
    else
        return [getKeyList(tree.left)..., tree.key, getKeyList(tree.right)...]
    end
end

function find(tree::Node, k::Int)::Union{Node, Nothing}
    if tree === nothing || tree.key == k
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

function fromString(str::String)::Union{Node, Nothing}
    if isempty(str)
        return nothing
    end
    open_bracket = findfirst(c -> c == '(', str)
    close_bracket = findfirst(c -> c == ')', str)

    if open_bracket === nothing || close_bracket === nothing
        println("Ungültiges Baumformat!")
        return nothing
    end

    key = parse(Int, str[1:open_bracket-1])
    left_str = str[open_bracket+1:close_bracket-1]
    right_str = str[close_bracket+2:end]

    left = fromString(left_str)
    right = fromString(right_str)

    if left !== nothing
        if left.key >= key
            println("Der Baum ist kein Suchbaum!")
            return nothing
        end
        left.parent = nothing
    end

    if right !== nothing
        if right.key <= key
            println("Der Baum ist kein Suchbaum!")
            return nothing
        end
        right.parent = nothing
    end

    node = Node(key, left, right, nothing)

    if left !== nothing
        left.parent = node
    end

    if right !== nothing
        right.parent = node
    end

    return node
end




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
#=
=#