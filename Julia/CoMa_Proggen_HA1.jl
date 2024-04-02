struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    
    function Node(key::Int, left::Union{Node, Nothing}=nothing, right::Union{Node, Nothing}=nothing)
        new(key, left, right)
    end
end

# Methode zum Ausgeben der Knotenschlüssel
function keys(node::Node)::Vector{Any}
    if node.left === nothing && node.right === nothing
        return [node.key]
    elseif node.left === nothing
        return vcat([node.key], keys(node.right))
    elseif node.right === nothing
        return vcat(keys(node.left), [node.key])
    else
        return vcat(keys(node.left), [node.key], keys(node.right))
    end
end

# Methode zur Berechnung der Höhe des Knotens
function height(node::Node)
    if node.left === nothing && node.right === nothing
        return 1
    elseif node.left === nothing
        return 1 + height(node.right)
    elseif node.right === nothing
        return 1 + height(node.left)
    else
        return 1 + max(height(node.left), height(node.right))
    end
end

# Methode zur Berechnung der Anzahl der Blätter
function leaves(node::Node)
    if node.left === nothing && node.right === nothing
        return 1
    elseif node.left === nothing
        return leaves(node.right)
    elseif node.right === nothing
        return leaves(node.left)
    else
        return leaves(node.left) + leaves(node.right)
    end
end

#= Beispielaufrufe
ex1 = Node(1)
ex2 = Node(2,Node(2,nothing,nothing),Node(2,nothing,Node(3)))
println(height(ex2)) # prints 3
println(height(ex1)) # prints 1
println(keys(ex1)) # prints 1-element Vector{Any}: [1]
println(keys(ex2)) # prints 4-element Vector{Any}: [2, 2, 2, 3]
println(leaves(ex2)) # prints 2

=#
