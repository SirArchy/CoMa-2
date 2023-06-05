# Definition des Typs "Node"
struct Node
    key::Int
    left::Union{Node,Nothing}
    right::Union{Node,Nothing}
    parent::Union{Node,Nothing}
end

# Funktion zur Konvertierung eines Strings in einen Suchbaum
function fromString(str::String)::Union{Node, Nothing}
    stack = Vector{Node}()
    i = 1
    while i <= length(str)
        c = str[i]
        if isdigit(c)
            # Schlüsselwert extrahieren
            key = parse(Int, c)
            while i+1 <= length(str) && isdigit(str[i+1])
                key = key * 10 + parse(Int, str[i+1])
                i += 1
            end
            node = Node(key, nothing, nothing, nothing)
            if isempty(stack)
                push!(stack, node)
            else
                parent = stack[end]
                if parent.left === nothing
                    parent.left = node
                elseif parent.right === nothing
                    parent.right = node
                else
                    return nothing  # Warnung: Der Baum ist kein Suchbaum!
                end
                node.parent = parent
                push!(stack, node)
            end
        elseif c == '('
            # weiter zum linken Teilbaum
            i += 1
        elseif c == ','
            # weiter zum rechten Teilbaum
            i += 1
        elseif c == ')'
            # zurück zum Elternknoten
            pop!(stack)
            i += 1
        else
            return nothing  # Warnung: Unerwartetes Zeichen im Eingabestring
        end
    end
    isempty(stack) ? nothing : stack[1]  # Wurzelknoten des Baums zurückgeben
end

# Funktion zur Bestimmung der minimalen Schlüsselwertes im Baum
function min(tree::Node)::Int
    current = tree
    while current.left !== nothing
        current = current.left
    end
    current.key
end

# Funktion zur Bestimmung der Liste der Schlüsselwerte in aufsteigender Reihenfolge
function getKeyList(tree::Node)::Vector{Int}
    keyList = Int[]
    stack = Node[]
    current = tree
    while !isempty(stack) || current !== nothing
        if current !== nothing
            push!(stack, current)
            current = current.left
        else
            current = pop!(stack)
            push!(keyList, current.key)
            current = current.right
        end
    end
    keyList
end

# Funktion zum Suchen eines Knotens mit einem bestimmten Schlüsselwert
function find(tree::Node, k::Int)::Union{Node,Nothing}
    current = tree
    while current !== nothing
        if current.key == k
            return current
        elseif k < current.key
            current = current.left
        else
            current = current.right
        end
    end
    nothing
end

# Beispielaufrufe
tree2 = "3(2(1,2),5(4,))"
tree2 = fromString(tree2)
min2 = min(tree2)
println(min2)
println(getKeyList(tree2))
println(find(tree2, min2))
#=
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