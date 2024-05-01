# Definition des Typs `Node`
struct Node
    key::Int
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
end

# Typalias `MaybeNode`
const MaybeNode = Union{Node, Nothing}

# Konstruktorfunktionen

# Erzeugt ein Blatt mit dem Wert `key`.
node(key::Int) = Node(key, nothing, nothing)

# Erzeugt einen Knoten mit dem Wert `key` und den Kindern `left` und `right`.
node(key::Int, left::MaybeNode, right::MaybeNode) = Node(key, left, right)

# Funktionen

# Gibt alle Schlüssel des Baumes in einem Vector zurück.
function getKeys(node::Node)::Vector{Int}
    keys = [node.key]
    if node.left !== nothing
        append!(keys, getKeys(node.left))
    end
    if node.right !== nothing
        append!(keys, getKeys(node.right))
    end
    return keys
end

# Gibt die Höhe eines Baumes zurück.
function height(node::Node)::Int
    if node.left === nothing && node.right === nothing
        return 1
    end
    lh = node.left === nothing ? 0 : height(node.left)
    rh = node.right === nothing ? 0 : height(node.right)
    return 1 + max(lh, rh)
end

# Wandelt einen Baum in einen Vector um.
function tree2vec(node::Node)::Vector{Union{Int, Nothing}}
    h = height(node)
    max_elements = 2^h - 1
    vec = Vector{Union{Int, Nothing}}(nothing, max_elements)
    function inner_tree2vec(node::MaybeNode, vec::Vector{Union{Int, Nothing}}, i::Int)
        if node === nothing
            return
        end
        vec[i] = node.key
        inner_tree2vec(node.left, vec, 2i)
        inner_tree2vec(node.right, vec, 2i+1)
    end
    inner_tree2vec(node, vec, 1)
    return vec
end

# Wandelt einen Vector in einen Baum um.
function vec2tree(vec::Vector{Union{Int, Nothing}})::MaybeNode
    function inner_vec2tree(i::Int)::MaybeNode
        if i > length(vec) || vec[i] === nothing
            return nothing
        end
        left_child = inner_vec2tree(2i)
        right_child = inner_vec2tree(2i + 1)
        return Node(vec[i], left_child, right_child)
    end
    return inner_vec2tree(1)
end

#= Beispielaufrufe
x = node(1)
y = node(2)
z = node(3, x, y)
u = node(4, z, nothing)

@show getKeys(z)
@show tree2vec(u)
@show vec2tree([4,3,nothing,1,2,nothing,nothing])
=#