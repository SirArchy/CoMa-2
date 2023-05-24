mutable struct Node
    successors::Vector{Node}
    name::String
    color::Symbol

    function Node(name::String)
        new(Vector{Node}(), name, :white)
    end
end

function dfs(node::Node, sorted::Vector{Node})
    if node.color == :gray
        error("Der Graph enthaelt einen Kreis!")
    elseif node.color == :white
        node.color = :gray
        for successor in node.successors
            dfs(successor, sorted)
        end
        node.color = :black
        push!(sorted, node)
    end
end

function top_sort(G::Vector{Node})
    sorted = Vector{Node}()
    for node in G
        if node.color == :white
            dfs(node, sorted)
        end
    end
    return reverse(sorted)
end


#=
Input: [("A", [2]), ("B", [1])]
Erwarteter Output: Der Graph enthaelt einen Kreis!
=#