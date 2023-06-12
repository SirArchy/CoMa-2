# Definition des Node-Typs
mutable struct Node
    key::Real
    left::Union{Nothing, Node}
    right::Union{Nothing, Node}
    parent::Union{Nothing, Node}
end

# Leerer Konstruktor für den Node
function Node()
    Node(Inf, nothing, nothing, nothing)
end

# Hilfsfunktion zum Aktualisieren der Höhe eines Knotens
function update_height!(node::Node)
    if node === nothing
        return 0
    else
        node_height = max(update_height!(node.left), update_height!(node.right)) + 1
        return node_height
    end
end

# Hilfsfunktion zum Aktualisieren der Balancefaktoren eines Knotens
function update_balance!(node::Node)
    if node === nothing
        return 0
    else
        node_balance = update_height!(node.right) - update_height!(node.left)
        return node_balance
    end
end

# Linksrotation für AVL-Baum
function rotate_left!(node::Node)
    pivot = node.right
    node.right = pivot.left

    if node.right !== nothing
        node.right.parent = node
    end

    pivot.left = node
    pivot.parent = node.parent

    if node.parent !== nothing
        if node.parent.left == node
            node.parent.left = pivot
        else
            node.parent.right = pivot
        end
    end

    node.parent = pivot

    update_height!(node)
    update_height!(pivot)
    update_balance!(node)
    update_balance!(pivot)

    return pivot
end

# Rechtsrotation für AVL-Baum
function rotate_right!(node::Node)
    pivot = node.left
    node.left = pivot.right

    if node.left !== nothing
        node.left.parent = node
    end

    pivot.right = node
    pivot.parent = node.parent

    if node.parent !== nothing
        if node.parent.left == node
            node.parent.left = pivot
        else
            node.parent.right = pivot
        end
    end

    node.parent = pivot

    update_height!(node)
    update_height!(pivot)
    update_balance!(node)
    update_balance!(pivot)

    return pivot
end

# Funktion zum Ausgleichen des AVL-Baums
function rebalance!(node::Node)
    if node === nothing
        return
    end

    update_height!(node)
    update_balance!(node)

    if update_balance!(node) == -2
        if update_height!(node.left.left) >= update_height!(node.left.right)
            node = rotate_right!(node)
        else
            node.left = rotate_left!(node.left)
            node = rotate_right!(node)
        end
    elseif update_balance!(node) == 2
        if update_height!(node.right.right) >= update_height!(node.right.left)
            node = rotate_left!(node)
        else
            node.right = rotate_right!(node.right)
            node = rotate_left!(node)
        end
    end

    if node.parent !== nothing
        rebalance!(node.parent)
    end
end

# Einfügen eines Intervalls in den AVL-Baum
function insert!(T::Node, p::Real)::Node
    if T === nothing
        return Node(p, nothing, nothing, nothing)
    elseif p < T.key
        if T.left === nothing
            T.left = Node(p, nothing, nothing, T)
        else
            insert!(T.left, p)
        end
    else
        if T.right === nothing
            T.right = Node(p, nothing, nothing, T)
        else
            insert!(T.right, p)
        end
    end

    rebalance!(T)
    return T
end

# Löschen eines Intervalls aus dem AVL-Baum
function delete!(T::Node, p::Real)::Node
    if T === nothing
        return nothing
    elseif p < T.key
        delete!(T.left, p)
    elseif p > T.key
        delete!(T.right, p)
    else
        if T.left === nothing && T.right === nothing
            if T.parent === nothing
                return nothing
            elseif T.parent.left == T
                T.parent.left = nothing
            else
                T.parent.right = nothing
            end
        elseif T.left === nothing
            if T.parent === nothing
                T.right.parent = nothing
                return T.right
            elseif T.parent.left == T
                T.parent.left = T.right
                T.right.parent = T.parent
            else
                T.parent.right = T.right
                T.right.parent = T.parent
            end
        elseif T.right === nothing
            if T.parent === nothing
                T.left.parent = nothing
                return T.left
            elseif T.parent.left == T
                T.parent.left = T.left
                T.left.parent = T.parent
            else
                T.parent.right = T.left
                T.left.parent = T.parent
            end
        else
            successor = T.right
            while successor.left !== nothing
                successor = successor.left
            end
            T.key = successor.key
            delete!(successor, successor.key)
        end
    end

    rebalance!(T)
    return T
end


# Beispielaufrufe
println(inOrder(root))
#2-element Vector{Any}:
# 10
# Inf
root = insert!(root,30)
println(inOrder(root))
#3-element Vector{Any}:
# 10
# 30
# Inf
delete!(root,10)
println(inOrder(root))
#2-element Vector{Any}:
# 30
# Inf